//
//  JSONToDictionary.h
//  XEngine
//
//  Created by edz on 2020/7/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONToDictionary : NSObject
+ (NSDictionary *)toDictionary:(NSString *)jsonString;
+ (NSString *)toString:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
