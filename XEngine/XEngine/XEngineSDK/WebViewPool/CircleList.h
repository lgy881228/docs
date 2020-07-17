//
//  Queue.h
//  IOSHybridAppDemo
//
//  Created by zk on 2020/7/10.
//  Copyright © 2020 LGD_Sunday. All rights reserved.
//

 
@interface CircleList : NSObject {
    NSMutableArray *contents;
}
- (void) forward;
- (void) backward;
- (id)   peekCurrent;
- (id)   peekNext;
- (void) add:(id)obj;
- (void)debugInfo;
- (id)   peekPrevious;
- (NSUInteger) getCurrentInex;
- (NSUInteger) getCount;

@end
 
