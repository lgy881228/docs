//
//  XEngineSDK.m
//  XEngine
//
//  Created by 李国阳 on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEngineSDK.h"
#import "XEngineRequest+DownLoadZip.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "WebViewPool.h"
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
    [WebViewPool SingleWebViewPool];
    return xEngineSDK;
    
}

- (void)updateMicroApp
{
  
    // 需要添加规则
//    e.g @property (copy, nonatomic) NSString *appId;
//        @property (copy, nonatomic) NSString *secret;
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@.%@.zip?key=%@",HostUrl,DownLoadZipUrl,zipModel.microAppId,zipModel.microAppVersion,[Unity getAppKey:AppSecret MicroApp:zipModel.microAppId Version:zipModel.microAppVersion]];
    UIView *rootView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    if (rootView) {
        [MBProgressHUD showHUDAddedTo:rootView animated:YES];
    }
    
    NSString *version;
    if ([PublicData sharedInstance].microConfigModel)
    {
        version = [PublicData sharedInstance].microConfigModel.version;
    }else
    {
        version = [NSString stringWithFormat:@"%ld",[self getTotalVersion]];
    }
    
    NSDictionary *param = @{
        @"key": [Unity getAppKey:self.secret MicroApp:self.appId],
        @"version":version
        
    };
    [XEngineRequest get:MicroAppsVersion params:param dataModel:MicroConfigModel.class success:^(id result, NSUInteger code, NSString *message) {
            NSLog(@"%@",result);
            if (Succeed_Code == code) {
                MicroConfigModel *onlineModel = (MicroConfigModel *)result; // 线上的
                MicroConfigModel *localModel = [PublicData sharedInstance].microConfigModel; // 本地的
                NSMutableArray *serverURLArray = [NSMutableArray array];
                if (!localModel)
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
                
                if (serverURLArray.count == 0)
                {
                    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
                }
                [PublicData sharedInstance].microConfigModel = onlineModel;
                __block NSInteger count = 0;
                [self downloadZipforServer:serverURLArray success:^(BOOL isUnZip, NSString * _Nonnull filePath) {
                    NSLog(@"%@",filePath);
                    count++;
                    if (count == serverURLArray.count)
                    {
                        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
                    }
                }];
               
            }else
            {
                [self allocMicroApps];
            }
    
        } failure:^(NSString *errorString) {
            NSLog(@"%@",errorString);
            [self allocMicroApps];
        }];
}

- (void)downloadZipforServer:(NSArray *)serverArray success:(void (^)(BOOL, NSString * _Nonnull))isSuccess
{
     for (NSString *server in serverArray)
        {
            NSLog(@"%@",server);
            [XEngineRequest downLoadWithFilePath:server andVersion:@"666" progress:^(NSProgress * _Nonnull downloadProgress) {

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
                NSString *folderName = [NSString stringWithFormat:@"xengineMicroApps/%@",[[htmlFilePath lastPathComponent] stringByDeletingPathExtension]];
//                 NSString *folderName = [NSString stringWithFormat:@"xengineMicroApps"];
                
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

// 初始化模型
- (void)allocMicroApps
{
 
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.rootViewController.view animated:YES];
   
    
  NSArray *localHTMLArray = [self recursivePathsForResourcesOfType:@"html" inDirectory:[[NSBundle mainBundle] bundlePath]];
    
    if (![PublicData sharedInstance].microConfigModel) {
//        MicroConfigModel *microConfigModel = [[MicroConfigModel alloc] initWithDictionary:dic error:nil];
//        [PublicData sharedInstance].microConfigModel = microConfigModel;
        
        MicroConfigModel *microConfigModel = [[MicroConfigModel alloc] init];
        microConfigModel.version = @"0";
        microConfigModel.code = @"0";
        microConfigModel.forceUpdate = @"0";
        NSMutableArray *zipArray = [NSMutableArray array];
        for (NSString *pathString in localHTMLArray) {
            ZipModel *zipModel = [[ZipModel alloc] init];
            zipModel.microAppVersion = @"0";
            zipModel.microAppName = @"";
            NSArray *subArray = [pathString componentsSeparatedByString:@"/"];
            NSString *microAppIdName = subArray[0];
            NSArray *microAppIdArray = [microAppIdName componentsSeparatedByString:@"."];
            microAppIdArray = [microAppIdArray subarrayWithRange:NSMakeRange(0, microAppIdArray.count -1)];
            NSString *microAppId  = [microAppIdArray componentsJoinedByString:@"."];
            zipModel.microAppId = microAppId;
            [zipArray addObject:zipModel];
        }
        microConfigModel.data = [NSArray arrayWithArray:zipArray];
        [PublicData sharedInstance].microConfigModel = microConfigModel;
        
    }
}
- (NSArray *)recursivePathsForResourcesOfType:(NSString *)type inDirectory:(NSString *)directoryPath{

    NSMutableArray *filePaths = [[NSMutableArray alloc] init];

    // Enumerators are recursive
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];

    NSString *filePath;

    while ((filePath = [enumerator nextObject]) != nil){

        // If we have the right type of file, add it to the list
        // Make sure to prepend the directory path
        if([[filePath pathExtension] isEqualToString:type]){
//            [filePaths addObject:[directoryPath stringByAppendingPathComponent:filePath]];
            [filePaths addObject:filePath];
        }
    }
    

    return filePaths;
}
@end
