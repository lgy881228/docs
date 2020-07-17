//
//  WebBridgeViewController.h
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>



@interface WebBridgeViewController : UIViewController<WKNavigationDelegate, WKWebViewLayoutDelegate, WKWebViewLoadDataDelegate, WKWebViewFullScreenDelegate>

@property (nonatomic, strong) DWKWebView *webView;

@property (nonatomic, strong) NSString *fileURL;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) NSURL *baseUrl;

@property (nonatomic, readwrite) BOOL autoLayoutEnabled;

// this class always return YES, subclass must to override, not using:(.customizedEnabled = ?).
- (BOOL)customizedEnabled;

- (BOOL)isLocalFile;

#pragma mark - tmp file directory
+ (NSURL *)localFileLoadingBugFixingTemporaryDirectory;

@end


