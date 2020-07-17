//
//  JSONToDictionary.m
//  XEngine
//
//  Created by edz on 2020/7/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JSONToDictionary.h"

@implementation JSONToDictionary
+ (NSDictionary *)toDictionary:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData)
    {
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        return param;
    }
    return nil;
    
}

+ (NSString *)toString:(NSDictionary *)dict
{
    NSError *parseError =nil;
    if ([dict isKindOfClass:NSDictionary.class])
    {
        if (!dict || dict.count == 0)
        {
            return nil;
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }else
    {
        return nil;
    }
    
}

@end
