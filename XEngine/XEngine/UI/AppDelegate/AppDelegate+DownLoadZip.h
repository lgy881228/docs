//
//  AppDelegate+DownLoadZip.h
//  XEngine
//
//  Created by edz on 2020/7/9.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (DownLoadZip)
- (void)downloadZipforServer:(NSArray *)serverArray success:(void(^)(BOOL isUnZip,NSString *filePath))isSuccess;
@end

NS_ASSUME_NONNULL_END
