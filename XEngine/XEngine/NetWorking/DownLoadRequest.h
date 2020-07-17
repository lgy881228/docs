//
//  DownLoadRequest.h
//  XEngine
//
//  Created by edz on 2020/7/9.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownLoadRequest : NSObject
+ (NSURLSessionDownloadTask *)downLoadWithFilePath:(NSString *)urlPath andVersion:(NSString *)version progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
