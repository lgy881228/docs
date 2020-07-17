//
//  PublicData.h
//  ECEJ
//
//  Created by jia on 16/3/31.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface PublicData : NSObject

+ (instancetype)sharedInstance;

@end
