//
//  MethodSwizzlingTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/28.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <OCMock/OCMock.h>

// References:
// * 置换测试: Mock, Stub 和其他 https://objccn.io/issue-15-5/
// * OCMock 3 reference http://ocmock.org/reference/#verifying-interactions

@interface Animal: NSObject

- (void)sleep;

- (void)sleepMethod;

@end

@implementation Animal

- (void)sleep {
    [self sleepMethod];
}

- (void)sleepMethod {
    NSLog(@"I'm sleeping.");
}

@end

@interface Dog: Animal

@end

@implementation Dog

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL oldSel = @selector(sleep);
        SEL newSel = @selector(p_sleep);
        Method oldMethod = class_getInstanceMethod([self class], oldSel);
        Method newMethod = class_getInstanceMethod([self class], newSel);
        BOOL didAddMethod = class_addMethod([self class], oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (didAddMethod) {
            class_replaceMethod([self class], newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod ));
        } else {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)p_sleep {
    [self p_sleepMethod];
}

- (void)p_sleepMethod {
    NSLog(@"The dog is sleeping.");
}

@end

@interface MethodSwizzlingTests : XCTestCase

@end

@implementation MethodSwizzlingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTheInstanceOfDogCallSleepMethodp_sleepMethodCalled {
    id mock = OCMClassMock([Dog class]);
    [mock sleep];
    // OCMockObject(Dog): Method p_sleep was not invoked.
    OCMVerify([mock p_sleepMethod]);
}

- (void)testTheInstanceOfDogCallp_sleepMethodSleepMethodCalled {
    id mock = OCMClassMock([Dog class]);
    [mock p_sleep];
    // OCMockObject(Dog): Method sleep was not invoked.
    OCMVerify([mock sleepMethod]);
}

@end
