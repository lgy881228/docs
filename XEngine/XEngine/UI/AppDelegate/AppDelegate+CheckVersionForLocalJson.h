//
//  AppDelegate+CheckVersionForLocalJson.h
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+DownLoadZip.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CheckVersionForLocalJson)
- (void)checkLocalVersion;
- (NSInteger)getTotalVersion;
- (void)checkOnlineVersion;
@end

NS_ASSUME_NONNULL_END
