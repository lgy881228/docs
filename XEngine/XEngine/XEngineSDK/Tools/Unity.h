//
//  Unity.h
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Unity : NSObject
+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microApp;

+ (UIViewController *)topViewController;
+ (UIView *)topView;
@end

NS_ASSUME_NONNULL_END
