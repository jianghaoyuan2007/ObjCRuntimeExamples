//
//  NSObject+KVO.h
//  ObjCRuntimeExamples
//
//  Created by Stephen Chiang on 2018/5/28.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PGObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)PG_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(PGObservingBlock)block;

- (void)PG_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
