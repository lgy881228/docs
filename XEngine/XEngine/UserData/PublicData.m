//
//  PublicData.m
//  ECEJ
//
//  Created by jia on 16/3/31.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#import "PublicData.h"

@interface PublicData ()

@end

@implementation PublicData

+ (instancetype)sharedInstance
{
    static PublicData *__sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    dispatch_once(&dispatchToken, ^{
        __sharedInstance = [[super allocWithZone:nil] init];
    });
    return __sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        //
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if ([self class] == [PublicData class])
    {
        return [[self class] sharedInstance];
    }
    else
    {
        return [super allocWithZone:zone];
    }
}

+ (instancetype)alloc
{
    if ([self class] == [PublicData class])
    {
        return [[self class] sharedInstance];
    }
    else
    {
        return [super alloc];
    }
}

+ (instancetype)new
{
    if ([self class] == [PublicData class])
    {
        return [[self class] sharedInstance];
    }
    else
    {
        return [super new];
    }
}

#ifndef OBJC_ARC_UNAVAILABLE
+ (id)copyWithZone:(struct _NSZone *)zone
{
    if ([self class] == [CommonData class])
    {
        return [[self class] instance];
    }
    else
    {
        return [super copyWithZone:zone];
    }
}
#endif

@end
