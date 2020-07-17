//
//  RPUserModel.m
//  RedPacket
//
//  Created by 李找乐 on 2020/1/13.
//  Copyright © 2020 李找乐. All rights reserved.
//

#import "RPUserModel.h"

@implementation RPUserModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

#pragma mark － NSSecureCoding
+ (BOOL)supportsSecureCoding
{
    return YES;
}


- (id)initWithCoder:(NSCoder *)decoder
{
   
    if (self = [super init])
    {
        // NSSecureCoding 解归档时要传数据类名
        _mobile = [decoder decodeObjectOfClass:[NSString class] forKey:@"mobile"];
        _avatar= [decoder decodeObjectOfClass:[NSString class] forKey:@"avatar"];
        _user_name = [decoder decodeObjectOfClass:[NSString class] forKey:@"user_name"];
        _user_id = [decoder decodeObjectOfClass:[NSString class] forKey:@"user_id"];
        _token = [decoder decodeObjectOfClass:[NSString class] forKey:@"token"];
        _sex = [decoder decodeObjectOfClass:[NSString class] forKey:@"sex"];
//        _apnsToken = [decoder decodeObjectOfClass:[NSString class] forKey:@"apnsToken"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_mobile forKey:@"mobile"];
    [encoder encodeObject:_avatar forKey:@"avatar"];
    [encoder encodeObject:_user_name forKey:@"user_name"];
    [encoder encodeObject:_user_id forKey:@"user_id"];
    [encoder encodeObject:_avatar forKey:@"avatar"];
    [encoder encodeObject:_token forKey:@"token"];
    [encoder encodeObject:_sex forKey:@"sex"];
//    [encoder encodeObject:_apnsToken forKey:@"apnsToken"];
    
   
}


@end
