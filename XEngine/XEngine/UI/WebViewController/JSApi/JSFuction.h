//
//  JSFuction.h
//  XEngine
//
//  Created by edz on 2020/7/13.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSFuction : NSObject
- (NSString *) testSyn: (NSString *) msg;
- (void)requestNetwork:(NSDictionary *)data :(JSCallback)completionHandler;
//- (void)requestNetwork:(NSDictionary *)data :(JSCallback)completionHandler;
@end

NS_ASSUME_NONNULL_END
