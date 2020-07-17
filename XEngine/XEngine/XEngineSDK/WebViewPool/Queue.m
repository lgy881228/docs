//
//  Queue.m
//  IOSHybridAppDemo
//
//  Created by zk on 2020/7/10.
//  Copyright © 2020 LGD_Sunday. All rights reserved.
//

#import "Queue.h"

@implementation Queue

- (id)init {
    if (self = [super init]) {
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}


// Queues are first-in-first-out, so we remove objects from the head
- (id) dequeue {
    // if ([self count] == 0) return nil; // to avoid raising exception (Quinn)
    id headObject = [contents objectAtIndex:0];
    if (headObject != nil) {
         [contents removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
    [contents addObject:anObject];
    //this method automatically adds to the end of the array
}

// read only
- (id) peek{
    if ([contents count]>0)
        return [contents objectAtIndex:0];
    return nil;
}
@end
