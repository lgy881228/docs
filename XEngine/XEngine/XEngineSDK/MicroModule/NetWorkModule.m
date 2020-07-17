//
//  NetWorkModule.m
//  XEngine
//
//  Created by edz on 2020/7/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "NetWorkModule.h"
#import "JSAPIRequest.h"
@implementation NetWorkModule
- (void)requestNetwork:(NSString *)jsonString complate:(XEngineCallBack)completionHandler
{
    NSLog(@"%@",jsonString);
    
    NSDictionary *param = [JSONToDictionary toDictionary:jsonString];
    NSLog(@"%@",param);
    if (!param)
    {
        return;
    }
    NSString *method = param[@"method"];
    NSString *url = param[@"url"];
    if ([method isEqualToString:@"GET"])
       {
           [JSAPIRequest get:url params:nil dataModel:nil success:^(id result, NSUInteger code, NSString *message) {
               NSLog(@"%@",result);
               NSString *jsonStr = [JSONToDictionary toString:result];

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
}


@end
