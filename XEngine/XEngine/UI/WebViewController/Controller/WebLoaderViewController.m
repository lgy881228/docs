//
//  WebLoaderViewController.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "WebLoaderViewController.h"
#import "JS_NavigationBarAPI.h"
@interface WebLoaderViewController ()

@end

@implementation WebLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate=self;

    NSLog(@"%@",self.filePath);
    //此处wkwebview加载方式有可能会变（加载本地路径和网址不一样 模拟器真机也不一样 建议用真机调试）
    
    NSString * tempurl = [self.filePath stringByAppendingPathComponent:@"index.html"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:tempurl])
    {
        NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",self.filePath];
        NSURL * accessUrl = [[NSURL URLWithString:pathUrl] URLByDeletingLastPathComponent];
        NSLog(@"index.html存在");
        [self.webView loadFileURL:[NSURL URLWithString:pathUrl] allowingReadAccessToURL:accessUrl];
    }
    else
    {
        NSString *localFilePath = [NSObject microAppDirectory];
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:localFilePath error:nil];
        NSLog(@"%@",files);
        NSArray * sortArr = [files sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
             return [obj2 compare:obj1 options:NSCaseInsensitiveSearch];   //obj1在前为升序,obj2在前为降序
        }];
        NSLog(@"%@",sortArr);
        for (NSString *localPathName in sortArr)
        {
            if ([localPathName hasPrefix:self.microAppModel.microAppId])
            {
                NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",[NSString stringWithFormat:@"%@/%@",[NSObject microAppDirectory], localPathName]];
                
                NSURL * accessUrl = [[NSURL URLWithString:pathUrl] URLByDeletingLastPathComponent];
                NSLog(@"index.html存在");
                [self.webView loadFileURL:[NSURL URLWithString:pathUrl] allowingReadAccessToURL:accessUrl];
                return;
               
            }
        }
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@/index",self.microAppModel.microAppId,@"0"] ofType:@"html"];
        //                    self.htmlString = htmlContent;
        //                    self.baseUrl =  baseURL;
                        [self.webView loadFileURL:[NSURL fileURLWithPath:htmlPath] allowingReadAccessToURL:baseURL];
//        UpdateModel *updateModel = [PublicData sharedInstance].updateModel;
//        for (ZipModel *zipModel in updateModel.data) {
//            if ([zipModel.microAppId isEqualToString:self.microAppModel.microAppId])
//            {
//                
//                break;
//            }
//        }
        NSLog(@"文件index.html不存在");
                   // load test.html
        
    }
    
        
        // register api object without namespace
    JS_NavigationBarAPI  * js_nav =  [[JS_NavigationBarAPI alloc] init];
    [self.webView addJavascriptObject:js_nav namespace:nil];
    js_nav.target = self;

    
    
//    [self.webView callHandler:@"addValue" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
//           NSLog(@"%@",value);
//       }];
    // open debug mode, Release mode should disable this.
#ifdef DEBUG
    [self.webView setDebugMode:YES];
#else
    [self.webView setDebugMode:NO];
#endif
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
