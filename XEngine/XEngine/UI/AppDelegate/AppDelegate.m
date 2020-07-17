//
//  AppDelegate.m
//  XEngine
//
//  Created by edz on 2020/7/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "EntryViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    __block BOOL end = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//        end = YES;
//    });
//    while (!end) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
     

    
    EntryViewController *homePageVC = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
       
       
       self.window.rootViewController = nav;
     [XEngineSDK registerApp:AppID andAppSecret:AppSecret serverUrl:@""];
    return YES;
}



@end
