//
//  DsBridgeWebViewController.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "DsBridgeWebViewController.h"
#import "JS_NavigationBarAPI.h"
@interface DsBridgeWebViewController ()
@property (nonatomic, strong) DWKWebView *dsWebView;
@end

@implementation DsBridgeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dsWebView = [[DWKWebView alloc] init];
    self.webView = self.dsWebView;
    self.webView.navigationDelegate=self;
    
    // register api object without namespace
    JS_NavigationBarAPI  * js_nav =  [[JS_NavigationBarAPI alloc] init];
    [(DWKWebView *)self.webView addJavascriptObject:js_nav namespace:nil];
//    js_nav.vc = self;
       // load test.html
       
       NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
       NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                          encoding:NSUTF8StringEncoding
                                                             error:nil];
        self.htmlString = htmlContent;
       //    NSString *htmlContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://your.url"] encoding:NSUTF8StringEncoding error:nil];
       
    
//       [self.webView loadHTMLString:htmlContent baseURL:baseURL];
   
    // Do any additional setup after loading the view.
}

- (BOOL)loadHTMLString
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:self.htmlString baseURL:baseURL];
    return YES;
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
