//
//  Unity.m
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "Unity.h"
#import "NSString+Extras.h"
@implementation Unity
+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microApp
{
    
    NSString *key = [NSString stringWithFormat:@"%@%@",appSecret,microApp];

    return [key md5HexDigest];
}


+ (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (UIViewController *)topViewController // topViewController
{
    UIViewController *topViewController = nil;
    if (self.rootViewController)
    {
        if ([self.rootViewController isKindOfClass:TabBarController.class])
        {
            TabBarController *tabBarController = (TabBarController *)self.rootViewController;
            topViewController = tabBarController.selectedViewController;
            
            if ([topViewController isKindOfClass:UINavigationController.class])
            {
                topViewController = ((UINavigationController *)topViewController).topViewController;
            }
        }
        else if ([self.rootViewController isKindOfClass:UINavigationController.class])
        {
            UINavigationController *navigationController = (UINavigationController *)self.rootViewController;
            topViewController = navigationController.topViewController;
        }
        else
        {
            topViewController = self.rootViewController;
        }
    }
    return topViewController;
    //    if (topViewController)
    //    {
    //        return [self checkTopViewController:topViewController];
    //    }
    //    else
    //    {
    //        return nil;
    //    }
}

+ (UIView *)topView
{
    UIViewController *vc = [self topViewController];
    UIView *currentView = vc.view;
    return currentView;;
}
@end
