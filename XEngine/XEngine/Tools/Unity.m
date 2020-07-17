//
//  Unity.m
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "Unity.h"
#import "NSString+Extras.h"
@implementation Unity
+ (NSString *)getAppKey:(NSString *)appSecret MicroApp:(NSString *)microApp
{
    
    NSString *key = [NSString stringWithFormat:@"%@%@",appSecret,microApp];

    return [key md5HexDigest];
}
@end
