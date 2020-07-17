//
//  SingleQueue.h
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  Copyright © 2020 杜文. All rights reserved.
//

#import <Foundation/Foundation.h>
 


NS_ASSUME_NONNULL_BEGIN

@interface WebViewMgr : NSObject 
+ (WebViewMgr *)SingleWebViewMgr;

- (NSString* )popUrlInStack;
- (NSString* )peekUrlInStack;
- (void)pushUrlInStack:(NSString *)url;

- (id)  getNextWebView;
- (id)  peekCurrentWebView;
- (id)  peekPreviousWebView;
- (id)  peekNextWebView;
- (void) debugInfo;

@property (nonatomic, strong) NSArray <NSString *>*modules;
@end

NS_ASSUME_NONNULL_END
