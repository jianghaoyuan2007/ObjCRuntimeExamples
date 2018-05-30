//
//  MessageForwardingTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/30.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/message.h>

@interface Postman: NSProxy

@end

@implementation Postman

- (instancetype)init {
    // no super, we're inheriting from NSProxy
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSLog(@"invocation: %@", invocation);
}

// Raises NSInvalidArgumentException. Override this method in your concrete subclass to return a proper NSMethodSignature object for the given selector and the class your proxy objects stand in for.

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

@end

@interface MessageForwardingTests : XCTestCase

@end

@implementation MessageForwardingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    Postman *postman = [[Postman alloc] init];
    objc_msgSend(postman, sel_registerName("greet"));
    
    NSString *string = @"Hello World";
    IMP implementation = class_getMethodImplementation([NSString class], @selector(lowercaseString));
    id result = implementation(string, @selector(lowercaseString));
    NSLog(@"Result = %@", result);
}


@end
