//
//  XEngineRequest.m
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "XEngineRequest.h"

@implementation XEngineRequest
+ (void)customizeHTTPSessionManager:(AFHTTPSessionManager *)manager
{
    [super customizeHTTPSessionManager:manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 添加header
}


+ (void)customizeRequestParams:(NSDictionary **)inputParams
{
    NSMutableDictionary *totalParams = [[NSMutableDictionary alloc] init];
    NSDictionary *params = *inputParams;
    if (params && params.count)
    {
        [totalParams setDictionary:params];
    }
    
    *inputParams = totalParams;
}


+ (NSString *)customRequestServer
{
    return HostUrl;
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
        NSDictionary *data = (NSDictionary *)jsonData[@"data"];
        NSInteger returncode = [jsonData[@"code"] integerValue];
        NSString *message = jsonData[@"msg"];
        
        if (Succeed_Code == returncode)
        {
            if (data)
            {
                [self handleSuccessData:data code:returncode message:message withSuccessBlock:successBlock dataModel:jsonModel];
            }
            else
            {
                if (successBlock)
                {
                    successBlock(data, returncode, message);
                }
            }
        }
        else
        {
            if (returncode)
            {
                
            }
            
            if (successBlock)
            {
                successBlock(data, returncode, message);
            }
        }
    }
    else
    {
        successBlock(jsonData, NSNotFound, @"");
    }
}




@end
