//
//  XEngineSDK.h
//  XEngine
//
//  Created by 李国阳 on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XEngine.h"
@interface XEngineSDK : NSObject

+ (id) registerApp:(NSString *)appId andAppSecret:(NSString *)secret serverUrl:(NSString *)server;
//- (void)updateMicroApp;
@end

