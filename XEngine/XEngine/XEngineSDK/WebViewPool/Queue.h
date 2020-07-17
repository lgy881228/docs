//
//  Queue.h
//  IOSHybridAppDemo
//
//  Created by zk on 2020/7/10.
//  Copyright © 2020 LGD_Sunday. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Queue : NSObject {
    NSMutableArray *contents;
}
- (id)   dequeue;
- (void) enqueue:(id)obj;
- (id)   peek;
@end
 
