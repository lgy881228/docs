//
//  JSFuction.m
//  XEngine
//
//  Created by edz on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JSFuction.h"

@implementation JSFuction
- (void)requestNetwork:(NSDictionary *)data :(JSCallback)completionHandler {
    NSLog(@"msg ==> %@", data);
    NSLog(@"msg ==> %@", data[@"url"]);
    NSLog(@"msg ==> %@", data[@"data"][@"age"]);
    NSString *method = data[@"method"];
    NSString *url = data[@"url"];
    NSDictionary *param = nil;
    if ([data[@"data"] isKindOfClass:NSDictionary.class])
    {
        param = data[@"data"];
    }
    if ([method isEqualToString:@"GET"])
    {
        [JSAPIRequest get:url params:nil dataModel:nil success:^(id result, NSUInteger code, NSString *message) {
            NSLog(@"%@",result);
            NSError *parseError =nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

            NSLog(@"JSON: %@", jsonStr);
           
            completionHandler(jsonStr, YES);
        } failure:^(NSString *errorString) {
            
        }];
    }else
    {
        [JSAPIRequest post:url params:nil dataModel:nil success:^(id result, NSUInteger code, NSString *message) {
            NSLog(@"%@",result);
            NSError *parseError =nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

            NSLog(@"JSON: %@", jsonStr);
                         
            completionHandler(jsonStr, YES);
           } failure:^(NSString *errorString) {
               
           }];
    }
    // 把msg转换成一个模型然后在统一管理
   
//    [XEngineRequest post:@"" params:nil success:^(NSDictionary *responseHeaderFields, id responseData) {
//
//    } failure:^(NSError *error) {
//
//    }];
    
}

- (NSString *) testSyn: (NSString *) msg
{
    return [msg stringByAppendingString:@"[ syn call]"];
}
@end
