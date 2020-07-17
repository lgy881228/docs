//
//  XEngineSDK.m
//  XEngine
//
//  Created by 李国阳 on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEngineSDK.h"
@interface XEngineSDK ()
@property (copy, nonatomic) NSString *appId;
@property (copy, nonatomic) NSString *secret;
@property (copy, nonatomic) NSString *server;

@end
@implementation XEngineSDK
+ (id) registerApp:(NSString *)appId andAppSecret:(NSString *)secret serverUrl:(NSString *)server
{
    XEngineSDK *xEngineSDK = [[XEngineSDK alloc] init];
    xEngineSDK.appId = appId;
    xEngineSDK.secret = appId;
    xEngineSDK.server = appId;
    [xEngineSDK updateMicroApp];
    return xEngineSDK;
    
}

- (void)updateMicroApp
{
    // 需要添加规则
//    e.g @property (copy, nonatomic) NSString *appId;
//        @property (copy, nonatomic) NSString *secret;
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@.%@.zip?key=%@",HostUrl,DownLoadZipUrl,zipModel.microAppId,zipModel.microAppVersion,[Unity getAppKey:AppSecret MicroApp:zipModel.microAppId Version:zipModel.microAppVersion]];
    NSString *version;
    if ([PublicData sharedInstance].updateModel)
    {
        version = [PublicData sharedInstance].updateModel.version;
    }else
    {
        version = [NSString stringWithFormat:@"%ld",[self getTotalVersion]];
    }
    
    NSDictionary *param = @{
        @"key": [Unity getAppKey:self.secret MicroApp:self.appId],
        @"version":version
        
    };
    [XEngineRequest get:MicroAppsVersion params:param dataModel:UpdateModel.class success:^(id result, NSUInteger code, NSString *message) {
            NSLog(@"%@",result);
            if (Succeed_Code == code) {
                UpdateModel *onlineModel = (UpdateModel *)result; // 线上的
                UpdateModel *localModel = [PublicData sharedInstance].updateModel; // 本地的
                NSMutableArray *serverURLArray = [NSMutableArray array];
                if (localModel)
                {
                    for (ZipModel *onlineZipModel in onlineModel.data)
                    {
                        for (ZipModel *localZipModel in localModel.data)
                        {
                            if ([localZipModel.microAppId isEqualToString:onlineZipModel.microAppId])
                            {
                                if ([localZipModel.microAppVersion integerValue] < [onlineZipModel.microAppVersion integerValue])
                                {
                                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.%@.zip",HostUrl,onlineZipModel.microAppId,onlineZipModel.microAppVersion];
                                    [serverURLArray addObject:urlStr];
                                }
                                break;
                            }
                        }
                       
                    }
                    
                    
                }else
                {
                    for (ZipModel *onlineZipModel in onlineModel.data)
                                   {
                                       NSString *urlStr = [NSString stringWithFormat:@"%@/%@.%@.zip",HostUrl,onlineZipModel.microAppId,onlineZipModel.microAppVersion];
                                       [serverURLArray addObject:urlStr];
                                   }

                }

                [PublicData sharedInstance].updateModel = onlineModel;
                [self downloadZipforServer:serverURLArray success:^(BOOL isUnZip, NSString * _Nonnull filePath) {
                    NSLog(@"%@",filePath);
                }];
               
            }
    
        } failure:^(NSString *errorString) {
            NSLog(@"%@",errorString);
        }];
}

- (void)downloadZipforServer:(NSArray *)serverArray success:(void (^)(BOOL, NSString * _Nonnull))isSuccess
{
     for (NSString *server in serverArray)
        {
            NSLog(@"%@",server);
            [DownLoadRequest downLoadWithFilePath:server andVersion:@"666" progress:^(NSProgress * _Nonnull downloadProgress) {

                double curr=(double)downloadProgress.completedUnitCount;
                       double total=(double)downloadProgress.totalUnitCount;
                       NSLog(@"下载进度==%.2f",curr/total);

            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
                NSString *cachesPath = [NSObject cachesDirectory];
                NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
                return [NSURL fileURLWithPath:path];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {

                //设置下载完成操作
                NSLog(@"%@",[filePath path]);
                if (error) {

                }
                // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
                NSString *htmlFilePath = [filePath path];// 将NSURL转成NSString
                // Caches 和 Preferences 区别，
                // https://juejin.im/entry/5a1bd924f265da43085dbfe6
                // 但放 Caches 有问题。
    //            NSString *folderName = [NSString stringWithFormat:@"xengineMicroApps/%@",[[htmlFilePath lastPathComponent] stringByDeletingPathExtension]];
                 NSString *folderName = [NSString stringWithFormat:@"xengineMicroApps"];
                
                NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:folderName];

                
               [ZipArchiveTool releaseZipFilesWithUnzipFileAtPath:htmlFilePath Destination:path complate:^(BOOL isUnZip, NSString *filePath) {
                               
                   if (isUnZip) {
    //                    解压完成后删除zip包
                       NSFileManager *fileManager = [NSFileManager defaultManager];
                       [fileManager removeItemAtPath:htmlFilePath error:NULL];
                               
                   }
                        isSuccess(isUnZip,filePath);
                
               }];


            }];

        }
}

- (NSInteger)getTotalVersion
{
    NSString *prePAth = [NSObject microAppDirectory];
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:prePAth error:nil];
        NSLog(@"%@",files);
    if (files.count == 0)
    {
        return 0;
    }
    NSArray * sortArr = [files sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
             return [obj2 compare:obj1 options:NSCaseInsensitiveSearch];   //obj1在前为升序,obj2在前为降序
        }];
        
        NSLog(@"%@",sortArr);
    NSInteger version = 0;
    NSMutableArray *prefixArray = [NSMutableArray array];
    for (NSString *fileName in sortArr)
    {
        NSArray *subArray = [fileName componentsSeparatedByString:@"."];
        subArray = [subArray subarrayWithRange:NSMakeRange(0, subArray.count -1)];
//        NSLog(@"%@",subArray);
        NSString *prefix  = [subArray componentsJoinedByString:@"."];
        [prefixArray addObject:prefix];
        
    }
    prefixArray = [prefixArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",prefixArray);
    
    //    NSMutableArray
        for (NSString *prefix in prefixArray)
        {
                        
            for (NSString *fileName in sortArr)
            {
                if ([fileName hasPrefix:prefix])
                {
                    NSRange range = [fileName rangeOfString:prefix];
                    NSString *endNumber = [fileName substringFromIndex:range.length + 1];
                    version = version + [endNumber integerValue];
                    break;
                    
                }
            }
        }
    NSLog(@"%ld",version);
    return version;
    
}


@end
