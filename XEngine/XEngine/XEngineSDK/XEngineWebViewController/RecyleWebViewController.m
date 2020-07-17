//
//  RecyleWebViewController.m
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  modified by zk on 2020/7/11.
//  Copyright © 2020 中科泰岳. All rights reserved.
//



#import "RecyleWebViewController.h"
#import "WebViewPool.h"
#import <Masonry/Masonry.h>
#define kIPHONEX                ( [UIScreen mainScreen].bounds.size.height > 736)            // 设备6p 6sp 7p 高度

#define kNavigationH            (CGFloat)(kIPHONEX?(88):(64))
              // 状态栏和导航栏总高度

//#import "FakeViewController.h"

// DONE: 1. 复用 webview 不会有闪历史界面的问题
// TODO: 2. 复用 webview 向前加载时, 历史界面会突然闪现一下. 在只有两个可复用的 webview 情况下, 不好解决. 因为 DONE:1 的原因, 前一个 webview 的内容必须保持,直到用户点了加载按钮那一刻起, 才应该加载页面.
// TODO: 3. 由于复用了 webiew ,页面历史状态只会保留一层. 虽然可以通过重新加载得到历史页面,但页面的状态有时都跟 url 没关系. 除非 webview 可以保存现场并恢复现场. 可以再实现一个 webview 的池方案.

@interface RecyleWebViewController ()
@property (nonatomic, strong) NSString *fileUrl;
@property (nonatomic, strong) WebViewPool *mgr;
@property (nonatomic, strong) DWKWebView * webview;
@property (nonatomic, assign) int index;
@property (nonatomic, readwrite) BOOL statusBarHidden;
@end
 
@implementation RecyleWebViewController
- (BOOL)customizedEnabled
{
    return YES;
}

//- (void)loadUrlWithModel:(ZipModel *)zipModel url:(NSString *)url
//{
//     NSString * tempurl = [url stringByAppendingPathComponent:@"index.html"];
//
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        if ([fileManager fileExistsAtPath:tempurl])
//        {
//            NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",url];
////            NSURL * accessUrl = [[NSURL URLWithString:pathUrl] URLByDeletingLastPathComponent];
//            NSLog(@"index.html存在");
//            self.fileUrl = pathUrl;
////            [self.webview loadFileURL:[NSURL URLWithString:pathUrl] allowingReadAccessToURL:accessUrl];
//        }
//        else
//        {
//            [self loadPreviosFileWithModel:zipModel];
//            NSString *localFilePath = [NSObject microAppDirectory];
//            NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:localFilePath error:nil];
//            NSLog(@"%@",files);
//            NSArray * sortArr = [files sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                 return [obj2 compare:obj1 options:NSCaseInsensitiveSearch];   //obj1在前为升序,obj2在前为降序
//            }];
//            NSLog(@"%@",sortArr);
//            for (NSString *localPathName in sortArr)
//            {
//                if ([localPathName hasPrefix:zipModel.microAppId])
//                {
//                    NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",[NSString stringWithFormat:@"%@/%@",[NSObject microAppDirectory], localPathName]];
//
////                    NSURL * accessUrl = [[NSURL URLWithString:pathUrl] URLByDeletingLastPathComponent];
//                    NSLog(@"index.html存在");
//                    self.fileUrl = pathUrl;
////                    [self.webview loadFileURL:[NSURL URLWithString:pathUrl] allowingReadAccessToURL:accessUrl];
//                    return;
//
//                }
//            }
////            NSString *path = [[NSBundle mainBundle] bundlePath];
////            NSURL *baseURL = [NSURL fileURLWithPath:path];
//            NSString * htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@/index",zipModel.microAppId,@"0"] ofType:@"html"];
//            self.fileUrl = [NSString stringWithFormat:@"file://%@", htmlPath];
////            [self.webview loadFileURL:[NSURL fileURLWithPath:htmlPath] allowingReadAccessToURL:baseURL];
//
//            NSLog(@"文件index.html不存在");
//                       // load test.html
//
//        }
//}
- (instancetype)initWithMicroAppId:(NSString *)microAppId url:(NSString*) url index:(int) index{
      self = [super init];
        if (self) {
           
            self.mgr = [WebViewPool SingleWebViewPool];
            if (![self loadLastFileWithUrlPath:url])
            {
                if (![self loadPreviosFileWithModel:microAppId])
                {
                    [self loadLocalDocumentWithModel:microAppId];
                }
            }
            self.index =index;
            self.filePath = url;
//            self.microAppModel = zipModel;
            self.webview = [self.mgr getUnusedWebViewFromPool];
            NSLog(@"current webview %@",self.webview);
            [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
                           make.top.left.right.bottom.equalTo(self.view);
                       }];
            [self.webview loadFileURL:[NSURL URLWithString:self.fileUrl]
            allowingReadAccessToURL:[[NSURL URLWithString:self.fileUrl] URLByDeletingLastPathComponent]];
//            self.webview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 0 - 50);
//            self.wantedNavigationItem.title =  name;
//            self.navigationItem.titleView = [Custom_Control createNavigationNormalTitle:name];
        }
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
//    [self.view bringSubviewToFront:btn];
    
//    if (self.autoLayoutEnabled)
//    {
//        if ([self respondsToSelector:@selector(customizeWebViewConstraints)])
//        {
//            [self customizeWebViewConstraints];
//        }
//        else
//        {
//            [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.left.right.bottom.equalTo(self.view);
//            }];
//        }
//    }else
//    {
//        self.webview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
//    }
    
    self.webview.navigationDelegate = self;
//   for (NSString *objName in self.modules) {
//
//        id obj = [[NSClassFromString(objName) alloc] init];
//        [self.webview addJavascriptObject:obj namespace:nil];
//    }
  
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [btn setTitle:@"跳转下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)dealloc
{
   [self.mgr putbackWebViewIntoPool];
    
}

- (void)push {
    
    RecyleWebViewController *test1 = [[RecyleWebViewController alloc] initWithMicroAppId:@"" url:self.filePath index:self.index+1];
        [self.navigationController pushViewController:test1 animated:YES];
    
}


#pragma mark - Inner Methods


- (void)reloadData
{
    [self.webview reload];
}

- (BOOL)loadLastFileWithUrlPath:(NSString *)url
{
    NSString * tempurl = [url stringByAppendingPathComponent:@"index.html"];

            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:tempurl])
            {
                NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",url];
                NSLog(@"index.html存在");
                self.fileUrl = pathUrl;
    //            [self.webview loadFileURL:[NSURL URLWithString:pathUrl] allowingReadAccessToURL:accessUrl];
                return YES;
            }else
            {
                NSArray *tempArray = [url componentsSeparatedByString:@"/"];
                NSString *addUrlPath = [tempArray lastObject];
                NSString * tempurl = [url stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/index.html",addUrlPath]];
                if ([fileManager fileExistsAtPath:tempurl]) {
                    NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",url];
                                   NSLog(@"index.html存在");
                                   self.fileUrl = pathUrl;
                    return YES;
                }
                
               
            }
    return NO;
}

- (BOOL)loadPreviosFileWithModel:(NSString *)microAppId
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
        if ([localPathName hasPrefix:microAppId])
        {
            NSString * pathUrl = [NSString stringWithFormat:@"file://%@/index.html",[NSString stringWithFormat:@"%@/%@",[NSObject microAppDirectory], localPathName]];
            NSLog(@"index.html存在");
            self.fileUrl = pathUrl;
            return YES;
        }
    }
    return NO;
}
- (BOOL)loadLocalDocumentWithModel:(NSString *)microAppId
{
   
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@/index",microAppId,@"0"] ofType:@"html"];
    self.fileUrl = [NSString stringWithFormat:@"file://%@", htmlPath];
    //            [self.webview loadFileURL:[NSURL fileURLWithPath:htmlPath] allowingReadAccessToURL:baseURL];
    NSLog(@"文件index.html不存在");
    return YES;
}


- (BOOL)isLocalFile
{
    return [self.filePath isAbsolutePath];
}


//// 将文件copy到tmp目录
//- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL
//{
//    NSError *error = nil;
//    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error])
//    {
//        return nil;
//    }
//
//    // Create "/temp/www" directory
//    NSFileManager *fileManager= [NSFileManager defaultManager];
//    NSURL *temDirURL = [[self class] localFileLoadingBugFixingTemporaryDirectory];
//    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
//
//    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
//
//    // Now copy given file to the temp directory
//    [fileManager removeItemAtURL:dstURL error:&error];
//    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
//
//    // Files in "/temp/www" load flawlesly :)
//    return dstURL;
//}

+ (NSURL *)localFileLoadingBugFixingTemporaryDirectory
{
    return [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
}

#pragma mark - WKNavigationDelegate
- (BOOL)validateRequestURL:(NSURL *)requestURL
{
    return YES;
}

- (BOOL)loadData { 
    return YES;
}


#pragma mark - WKNavigationDelegate
// 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    NSURL *url = navigationAction.request.URL;
    NSLog(@"*********%@",url);
    if ([self validateRequestURL:url])
    {
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
    {
        // 不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self showLoading];
}

// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    // navigationAction.request.URL.host
    NSLog(@"WKwebView ... didCommitNavigation ..");
    
    [NSThread delaySeconds:0.1f perform:^{
        
        [self hideLoading];
    }];
}

// 5a 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id res , NSError * _Nullable error) {
        self.wantedNavigationItem.title = res;
    }];
    //    if (!self.isLocalFile && !self.navigationBarTitle && webView.title)
    //    {
    //        self.navigationBarTitle = webView.title;
    //    }
    //
    //    [NSThread delaySeconds:0.1f perform:^{
    //
    //        [self hideLoading];
    //    }];
    //
    //    // 屏蔽运营商广告 开始
    //    [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('c60_fbar_buoy ng-isolate-scope')[0].style.display = 'none'" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
    //
    //        if (!error)
    //        {
    //            // succeed
    //        }
    //    }];
    // [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementById('tlbstoolbar')[0].style.display = 'none'"];
    // 屏蔽运营商广告 结束
    
    //    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    //    NSLog(@"%@", currentURL);
}

// 5b 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"加载失败");
    
    [self hideLoading];
    
    if (self.isLocalFile) return;
    
    if ([self isNoNetwork])
    {
        [self promptMessage:kNetworkUnavailable];
    }
    else
    {
        [self promptMessage:kLoadDataFailed];
    }
}

#pragma mark - Full Screen
//- (void)startFullScreenObserving
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil]; // 进入全屏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil]; // 退出全屏
//}

//- (void)stopFullScreenObserving
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
//}




- (BOOL)statusBarAppearanceByViewController
{
    NSNumber *viewControllerBased = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIViewControllerBasedStatusBarAppearance"];
    if (viewControllerBased && !viewControllerBased.boolValue)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#if RotationObservingForVideoEnabled
- (void)retainStatusBar
{
    if (self.statusBarAppearanceByViewController)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}

#pragma mark iOS 8 Prior
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.view layoutSubviews];
    
    [self retainStatusBar];
}

#pragma mark ios 8 Later
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        [self retainStatusBar];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        //
    }];
}
#endif





@end
