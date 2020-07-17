//
//  ZipArchiveTool.m
//  XEngine
//
//  Created by edz on 2020/7/8.
//  Copyright © 2020 edz. All rights reserved.
//

#import "ZipArchiveTool.h"
#import <SSZipArchive/SSZipArchive.h>
@interface ZipArchiveTool ()

@end
@implementation ZipArchiveTool

+ (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath complate:(UnZipComplate)complate
{
    //    NSLog(@"%@,%@",zipPath,unzipPath);
        NSError *error;
//    if () {
//        NSLog(@"success");
//
//        NSLog(@"%@",unzipPath);
//    } else {
//        NSLog(@"%@",error);
//    }
    
    // 压缩包的全路径(包括文件名)
    //    NSString *destinationPath = zipPath;
    
    // 目标路径,
//    NSString *destinationPath = unzipPath;
    // 解压, 返回值代表是否解压完成
//    Boolean b = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
    
    

    //    ------------ 带回调的解压    ------------
    Boolean b1 = [SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        /*
         * entry : 解压出来的文件名
         * entryNumber : 第几个, 从1开始
         * total : 总共几个
         */
        
        NSLog(@"progressHandler:%@, entryNumber:%ld, total:%ld  names:%@", entry, entryNumber, total,unzipPath);
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {

        /*
         * path : 被解压的压缩吧全路径
         * succeeded 是否成功
         * error 错误信息
         */
      
        if (succeeded)
        {
            complate(YES,unzipPath);
        }else
        {
            complate(NO,@"");
        }
        NSLog(@"completionHandler:%@, , succeeded:%d, error:%@", path, succeeded, error);
    }];
}


@end
