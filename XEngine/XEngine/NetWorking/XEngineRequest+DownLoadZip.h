//
//  XEngineRequest+DownLoadZip.h
//  XEngine
//
//  Created by 李国阳 on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEngineRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XEngineRequest (DownLoadZip)
+ (NSURLSessionDownloadTask *)downLoadWithFilePath:(NSString *)urlPath andVersion:(NSString *)version progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
