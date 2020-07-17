//
//  Stack.h
//  IOSHybridAppDemo
//
//  Created by zk on 2020/7/10.
//  Copyright © 2020 LGD_Sunday. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Stack : NSObject {
    NSMutableArray *contents;
}

- (void)push:(id)object;
- (id)pop;
- (id)top;
- (void)debugInfo;
@end
 
 
