//
//  SingleQueue.h
//  dsbridgedemo
//
//  Created by Chenwuzheng on 2020/7/10.
//  Copyright © 2020 杜文. All rights reserved.
//

#import <Foundation/Foundation.h>
 


NS_ASSUME_NONNULL_BEGIN

@interface WebViewPool : NSObject
+ (WebViewPool *)SingleWebViewPool;

- (id)  getUnusedWebViewFromPool;
- (void)  putbackWebViewIntoPool;
@end

NS_ASSUME_NONNULL_END
