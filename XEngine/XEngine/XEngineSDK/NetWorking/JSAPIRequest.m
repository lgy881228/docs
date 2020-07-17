//
//  JSAPIRequest.m
//  XEngine
//
//  Created by edz on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JSAPIRequest.h"

@implementation JSAPIRequest
+ (NSString *)customRequestServer
{
    return @"";
}

+ (void)handleResponseHeader:(NSDictionary *)responseHeaderFields resesponseData:(id)responseData withSuccessBlock:(TTSuccessBlock)successBlock dataModel:(Class)jsonModel failure:(TTFailureBlock)failureBlock
{
    if ([responseData isKindOfClass:NSData.class])
    {
//        NSData *data = [responseData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        if (tmp)
        {
            responseData = tmp;
        }
    }
    
    NSDictionary *jsonData = (NSDictionary *)responseData;
    NSLog(@"%@", jsonData.description);
    
    if ([jsonData isKindOfClass:NSDictionary.class])
    {
        
        [self handleSuccessData:jsonData code:0 message:@"" withSuccessBlock:successBlock dataModel:jsonModel];
        
    }
    else
    {
        successBlock(jsonData, NSNotFound, @"");
    }
}
@end
