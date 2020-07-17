//
//  ZipArchiveTool.h
//  XEngine
//
//  Created by edz on 2020/7/8.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UnZipComplate)(BOOL isUnZip, NSString *filePath);
@interface ZipArchiveTool : NSObject
+ (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath complate:(UnZipComplate)complate;
@end

NS_ASSUME_NONNULL_END
