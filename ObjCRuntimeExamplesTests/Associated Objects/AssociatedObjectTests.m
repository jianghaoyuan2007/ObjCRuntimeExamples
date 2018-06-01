//
//  AssociatedObjectTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+RunAtDealloc.h"

@interface AssociatedObjectTests : XCTestCase

@end

@implementation AssociatedObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRunAtDeallocBlockIsRunningAsExpectation {
    XCTestExpectation *expectation = [self expectationWithDescription:@"The expectation for runAtDealloc block."];
    NSObject *object = [NSObject new];
    [object runAtDealloc:^{
        NSLog(@"The object is released.");
        [expectation fulfill];
        XCTAssertTrue(true);
    }];
    object = nil;
    [self waitForExpectations:@[expectation] timeout:2];
}


@end
