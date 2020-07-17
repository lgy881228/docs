//
//  DownLoadRequest.m
//  XEngine
//
//  Created by edz on 2020/7/9.
//  Copyright © 2020 edz. All rights reserved.
//

#import "DownLoadRequest.h"

@implementation DownLoadRequest
+ (NSURLSessionDownloadTask *)downLoadWithFilePath:(NSString *)urlPath andVersion:(NSString *)version progress:(void (^)(NSProgress *))progressBlock destination:(NSURL * (^)(NSURL *, NSURLResponse * ))destinationBlock completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError * ))completion
{
    //远程地址
    NSURL *URL = [NSURL URLWithString:urlPath];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progressBlock(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
       return destinationBlock(targetPath,response);
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completion(response,filePath,error);
    }];
    
    [task resume];
    
    return task;
    

    
}
@end
