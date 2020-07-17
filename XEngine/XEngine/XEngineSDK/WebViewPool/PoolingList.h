//
//  PoolingList.h
//
//  Created by zk on 2020/7/10.
//

 
@interface PoolingList : NSObject {
    NSMutableArray *contents;
}
- (void) forward;
- (void) backward;
- (id)   peekCurrent;
 
- (void) add:(id)obj;
- (void)debugInfo;
 
- (NSUInteger) getCurrentInex;
- (NSUInteger) getCount;
- (void)shrinkToSize:(int) size;

@end
 
