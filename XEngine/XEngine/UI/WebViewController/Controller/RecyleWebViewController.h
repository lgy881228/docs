//
//  RecyleWebViewController.h
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  Copyright © 2020 杜文. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RecyleWebViewController : UIViewController <WKWebViewLayoutDelegate, WKWebViewLoadDataDelegate>
- (instancetype)initWithModel:(ZipModel *)zipModel url:(NSString*) url index:(int) index parentRecyleWebViewController:(RecyleWebViewController*) parentRWVc;
- (void) prepareBackOffscreenRender:(NSString*) url;
- (void) prepareForwardOffscreenRender;

@property (nonatomic, readwrite) BOOL autoLayoutEnabled;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) ZipModel *microAppModel;

@property (nonatomic, strong) NSArray *modules;

@end



