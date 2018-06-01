//
//  NSObject+RunAtDealloc.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/31.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "NSObject+RunAtDealloc.h"
#import <objc/runtime.h>

@implementation TSBlockExecutor

- (id)initWithBlock:(TSEmptyBlock)block {
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

- (void)dealloc {
    if (self.block) {
        self.block();
    }
}

@end

const void *runAtDeallocBlockKey = &runAtDeallocBlockKey;

@implementation NSObject (RunAtDealloc)

- (void)runAtDealloc:(TSEmptyBlock)block {
    if (block) {
        TSBlockExecutor *executor = [[TSBlockExecutor alloc] initWithBlock:block];
        
        objc_setAssociatedObject(self,
                                 runAtDeallocBlockKey,
                                 executor,
                                 OBJC_ASSOCIATION_RETAIN);
    }
}

@end
