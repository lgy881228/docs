//
//  PoolingList.m
//
//  Created by zk on 2020/7/10.
//  current
//  |
//  * -> * -> *

//       current
//       |         auto expand
//  * -> * -> * -> [*] -> [*]

#import "PoolingList.h"
@interface PoolingList ()

@property (nonatomic, assign) int current_idx ;

@end

@implementation PoolingList

- (id)init {
    if (self = [super init]) {
        _current_idx= 0;
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) forward{
    _current_idx++;
    assert(_current_idx<[contents count]);
}
- (void) backward{
    _current_idx--;
     assert(_current_idx>=0);
}
- (id)   peekCurrent{
    if([contents count]==0)return nil;
    return  [contents objectAtIndex:_current_idx];
}

- (void) add:(id)obj{
    if(obj == nil) return;
    
    [contents addObject:obj];
}
- (void)debugInfo{
    for (NSString *curElement in contents)
    {
       NSLog(@"%@", curElement);
    }
}
- (NSUInteger) getCurrentInex{
    return self.current_idx;
}
- (NSUInteger) getCount{
    return [contents count];
}
- (void)shrinkToSize:(int) size {
    if(self.current_idx>size){
        NSLog(@"error: current_idx: %d, size: %d",self.current_idx, size);
        return;
    }
 
    NSUInteger length = [contents count] - size ;
    [contents removeObjectsInRange:(NSRange){size, length}];
}

@end
