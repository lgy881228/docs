//
//  NSObject+CacheLocalized.m
//  XEngine
//
//  Created by edz on 2020/7/8.
//  Copyright © 2020 edz. All rights reserved.
//

#import "NSObject+CacheLocalized.h"

@implementation NSObject (CacheLocalized)
- (NSString *)cachesDirectory
{
    return [NSObject cachesDirectory];
}

+ (NSString *)cachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [paths lastObject];
}

- (NSString *)microAppDirectory
{
    return [NSObject microAppDirectory];
}

+ (NSString *)microAppDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [[paths lastObject] stringByAppendingPathComponent:@"xengineMicroApps"];
}


@end
