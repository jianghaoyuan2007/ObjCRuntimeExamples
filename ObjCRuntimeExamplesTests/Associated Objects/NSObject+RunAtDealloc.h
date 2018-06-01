//
//  NSObject+RunAtDealloc.h
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/31.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TSEmptyBlock)(void);

@interface TSBlockExecutor: NSObject

@property (nonatomic, readonly, copy) TSEmptyBlock block;

- (id)initWithBlock: (TSEmptyBlock)block;

@end

@interface NSObject (RunAtDealloc)

- (void)runAtDealloc: (TSEmptyBlock)block;

@end
