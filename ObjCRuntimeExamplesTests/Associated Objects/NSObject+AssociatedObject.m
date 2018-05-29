//
//  NSObject+AssociatedObject.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject(AssociatedObject)
@dynamic associatedObject;

- (void)setAssociatedObject:(id)object {
    objc_setAssociatedObject(self,
                             @selector(associatedObject),
                             object,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, @selector(associatedObject));
}

@end
