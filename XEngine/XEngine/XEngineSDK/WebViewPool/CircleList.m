//
//  Queue.m
//  IOSHybridAppDemo
//
//  Created by zk on 2020/7/10.
//  Copyright © 2020 LGD_Sunday. All rights reserved.
//

#import "CircleList.h"
@interface CircleList ()

@property (nonatomic, assign) NSUInteger current_idx ;

@end

@implementation CircleList

- (id)init {
    if (self = [super init]) {
        _current_idx= 0;
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) forward{
    _current_idx=(_current_idx+1)%[contents count];
}
- (void) backward{
    _current_idx=(_current_idx+[contents count]-1)%[contents count];
}
- (id)   peekCurrent{
    if([contents count]==0)return nil;
    id obj = [contents objectAtIndex:(_current_idx)%[contents count]];
    return obj;
}
- (id)   peekNext{
    if([contents count]==0)return nil;
       id obj = [contents objectAtIndex:(_current_idx+1)%[contents count]];
       return obj;
}
- (id)   peekPrevious{
    if([contents count]==0)return nil;
     NSUInteger previous_current_idx=(_current_idx+[contents count]-1)%[contents count];
    id obj = [contents objectAtIndex:previous_current_idx];
    return obj;
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

@end
