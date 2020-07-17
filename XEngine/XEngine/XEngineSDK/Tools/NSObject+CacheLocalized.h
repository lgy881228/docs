//
//  NSObject+CacheLocalized.h
//  XEngine
//
//  Created by edz on 2020/7/8.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CacheLocalized)
// 获取Caches目录路径
- (NSString *)cachesDirectory;
+ (NSString *)cachesDirectory;

// 获取Preferences目录路径
- (NSString *)microAppDirectory;
+ (NSString *)microAppDirectory;
@end

NS_ASSUME_NONNULL_END
