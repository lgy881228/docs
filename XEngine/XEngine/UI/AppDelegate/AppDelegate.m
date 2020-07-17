//
//  AppDelegate.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate.h"
#import "WebLoaderViewController.h"
#import "EntryViewController.h"

#import "AppDelegate+CheckVersionForLocalJson.h"
#import "XEngineSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [XEngineSDK registerApp:AppID andAppSecret:AppSecret serverUrl:@""];
    
//    if ([PublicData sharedInstance].updateModel)
//    {
//        [self getTotalVersion];
//    }else
//    {
//        [self checkLocalVersion];
//    }
//    [self getTotalVersion];
//    [self checkOnlineVersion];
 
    
    
//    RecyleWebViewController *recyleWebViewController = [[RecyleWebViewController alloc] initWithTitle:<#(nonnull NSString *)#> url:<#(nonnull NSString *)#> index:<#(int)#> parentRecyleWebViewController:<#(nonnull RecyleWebViewController *)#>]
    EntryViewController *homePageVC = [[EntryViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    
    self.window.rootViewController = nav;
    return YES;
}




@end
