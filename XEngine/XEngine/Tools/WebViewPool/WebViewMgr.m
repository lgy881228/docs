//
//  SingleQueue.m
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  Copyright © 2020 杜文. All rights reserved.
//

#import "WebViewMgr.h"
#import "DWKWebView.h"
#import "JSFuction.h"
//#import "JsEchoApi.h"
#import "JSBUtil.h"
#import "CircleList.h"
#import "Stack.h"

@interface WebViewMgr ()
@property (nonatomic, strong) dispatch_queue_t myQueue;
@property (nonatomic, strong) Stack* stack;
@property (nonatomic, strong) CircleList* cirleList;
@end


@implementation WebViewMgr
 
 
+ (WebViewMgr *)SingleWebViewMgr {
    static WebViewMgr *_instance;
    @synchronized (self) {
        if(!_instance) {
            _instance = [[WebViewMgr alloc] init];
        }
        return _instance;
    }
}

- (instancetype)init{
    _cirleList =[[CircleList alloc] init];
    _stack = [[Stack alloc] init];

    // 队列-串行
    _myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    // 同步执行任务
    dispatch_sync(_myQueue,^{
        for (int i =0 ; i<2; i++) {
            DWKWebView* webView1 = [[DWKWebView alloc] init];
//            for (NSString *objName in self.modules) {
//                
//                id obj = [[NSClassFromString(objName) alloc] init];
//                [webView1 addJavascriptObject:obj namespace:nil];
//            }
//            JSFuction *js = [[JSFuction alloc] init];
//            [webView1 addJavascriptObject:js namespace:nil];
//            [webView1 addJavascriptObject:[[JsEchoApi alloc] init] namespace:@"echo"];
            [webView1 customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];

            [_cirleList add:webView1];
            
        }
    });
 
    return self;
}
 
- (void)pushUrlInStack:(NSString *)url {
    return [_stack push:url];
}
 
- (NSString* )peekUrlInStack{
     return [_stack top];
}
- (NSString* )popUrlInStack {
    return [_stack pop];
}

- (id)getNextWebView{
    return [_cirleList getNext];
}
- (id)  peekPreviousWebView{
    return [_cirleList peekPrevious];
}
- (void)debugInfo{
    
    [_cirleList debugInfo];
    [_stack debugInfo];
}
- (id)  peekCurrentWebView{
    return [_cirleList peekCurrent];
}
-(id) peekNextWebView{
    return [_cirleList peekNext];
}
@end
