//
//  RecyleWebViewController.h
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  Copyright © 2020 杜文. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XEngine.h"

@interface RecyleWebViewController : UIViewController <WKWebViewLayoutDelegate, WKWebViewLoadDataDelegate>
- (instancetype)initWithMicroAppId:(NSString *)microAppId url:(NSString*) url index:(int) index;
- (void) prepareBackOffscreenRender:(NSString*) url;
- (void) prepareForwardOffscreenRender;

@property (nonatomic, readwrite) BOOL autoLayoutEnabled;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *microAppId;

@property (nonatomic, strong) NSArray *modules;

@end



