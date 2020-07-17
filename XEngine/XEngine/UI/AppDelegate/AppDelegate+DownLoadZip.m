//
//  AppDelegate+DownLoadZip.m
//  XEngine
//
//  Created by edz on 2020/7/9.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate+DownLoadZip.h"

@implementation AppDelegate (DownLoadZip)
- (void)downloadZipforServer:(NSArray *)serverArray success:(void (^)(BOOL, NSString * _Nonnull))isSuccess
{
//    [self testgroup:serverUrl success:isSuccess];
//   [[htmlFilePath lastPathComponent] stringByDeletingPathExtension]
//    UpdateModel *model =  PublicData.sharedInstance.updateModel;
//    NSMutableArray *serverURl = [NSMutableArray array];
//    for (ZipModel *zipModel in model.data)
//    { //app/com.zkty.xiaoqu/com.zkty.xiaoqu.opendoor.1.zip?key=1f2414c23a7d55dddc11caa32a8e9a4a
////        NSString *urlStr = [NSString stringWithFormat:@"%@%@%@.%@.zip?key=%@",HostUrl,DownLoadZipUrl,zipModel.microAppId,zipModel.microAppVersion,[Unity getAppKey:AppSecret MicroApp:zipModel.microAppId Version:zipModel.microAppVersion]];
//        NSString *urlStr = [NSString stringWithFormat:@"%@/%@.%@.zip",HostUrl,zipModel.microAppId,zipModel.microAppVersion];
//        [serverURl addObject:urlStr];
//    }
//
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
//   //@"http://192.168.3.211:8000/Archive4.zip"
//
   
}



@end
