//
//  PageViewController.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "PageViewController.h"
#import "JS_NavigationBarAPI.h"
@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JS_NavigationBarAPI  * js_nav =  [[JS_NavigationBarAPI alloc] init];
       self.webView.navigationDelegate = self;
    [self.webView addJavascriptObject:js_nav namespace:nil];
       js_nav.target = self;
              // load test.html
              
       NSString *path = [[NSBundle mainBundle] bundlePath];
       NSURL *baseURL = [NSURL fileURLWithPath:path];
       NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"MandMobile_files/index" ofType:@"html"];
       NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                                 encoding:NSUTF8StringEncoding
                                                                    error:nil];
    self.htmlString = htmlContent;
    self.baseUrl =  baseURL;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
