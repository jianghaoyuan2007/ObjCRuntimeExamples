//
//  NSInvocationTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/30.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface Executant: NSObject

- (NSString *)execute:(NSString *)command;

@end

@implementation Executant

- (NSString *)execute:(NSString *)command {
    NSLog(@"%@", command);
    return command;
}

@end

@interface NSInvocationTests : XCTestCase

@end

@implementation NSInvocationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInvocationObjectCalledAsExpected {

    __weak id returnValue = nil;

    Executant *target = [Executant new];
    NSString *command = @"Hello World.";
    SEL selector = @selector(execute:);
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    [invocation setArgument:&command atIndex:2];
    [invocation retainArguments];
    
    [invocation invoke];
    
    [invocation getReturnValue:&returnValue];
    
    XCTAssertTrue([returnValue isEqualToString:command]);
}

@end
