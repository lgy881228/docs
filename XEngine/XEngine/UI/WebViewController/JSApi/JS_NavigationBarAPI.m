//
//  JS_NavigationBarAPI.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JS_NavigationBarAPI.h"
#import "ViewController.h"
#import "WebLoaderViewController.h"
#import "PageViewController.h"
@implementation JS_NavigationBarAPI
- (NSString *)presentDialog:(NSString *)msg {
    
    PageViewController *indexVC = [[PageViewController alloc] init];
   
//    WKWebViewController *bbbb = [[WKWebViewController alloc] init];
//    bbbb.fileURL = @"https://www.baidu.com";
    [self.target pushViewController:indexVC];
    
    return nil;
    return [msg stringByAppendingString:@"调用了me"];
}



- (NSString *)presentoffLineController: (NSString *) msg {
    //      TEST native uicontroller over webviewcontroller
//    PackageViewController* pvc =   [[PackageViewController alloc] init];
//    [self.vc presentViewController:pvc animated:YES completion:nil];
    return nil;
}

- (NSString *)presentcontroller: (NSString *) msg {
    //      TEST native uicontroller over webviewcontroller
    UITabBarController* tab =   [[UITabBarController alloc] init];
    NSMutableArray* viewControllers =[[NSMutableArray alloc]init];
    for (int i =0; i<4; i++) {
        UIViewController * vc=   [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0];
        vc.tabBarItem.title = [NSString stringWithFormat:@"bar title"];
        [viewControllers addObject:vc];
    }
    
    tab.viewControllers = viewControllers;
    [self.target presentViewController:tab animated:YES completion:nil];
    return nil;
}

- (NSString *)testSyn: (NSString *)msg {
    
    //        WARNING: UIview won't move with webview content
    //        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //        view1.backgroundColor = [UIColor redColor];
    //        [self.vc.view addSubview:view1];//添加到self.view
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) syncCalendar:(NSString *) msg :(JSCallback)completionHandler {
    completionHandler(@"testNoArgAsyn called [ syncCalendar call]",YES);
}


- (void) testAsyn:(NSString *) msg :(JSCallback) completionHandler
{
   dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.syncAndAsyncMix.serialQueue", NULL);
    dispatch_async(serialQueue, ^{
        [NSThread sleepForTimeInterval:3.000];
        completionHandler([msg stringByAppendingString:@"after 2 secs.  [ asyn call]"],YES);
    });
}

- (NSString *)testNoArgSyn:(NSDictionary *) args {
    return  @"testNoArgSyn called [ syn call]";
}

- ( void )testNoArgAsyn:(NSDictionary *) args :(JSCallback)completionHandler {
    completionHandler(@"testNoArgAsyn called [ asyn call]",YES);
}

- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler {
//    value=10;
//    hanlder=completionHandler;
//    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
//                                              target:self
//                                            selector:@selector(onTimer:)
//                                            userInfo:nil
//                                             repeats:YES];
}

- (void)onTimer:t {
//    if(value!=-1) {
//        hanlder([NSNumber numberWithInt:value--],NO);
//    } else {
//        hanlder(0,YES);
//        [timer invalidate];
//    }
}

@end
