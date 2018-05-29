//
//  KVOImplementationTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+KVO.h"

@interface Message: NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end

@interface KVOImplementationTests : XCTestCase

@end

@implementation KVOImplementationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCustomKVOOfMessageReturnsHelloWorld {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Custom KVO Implementation."];
    NSString *text = @"Hello World!";
    Message *message = [Message new];
    [message PG_addObserver:self
                     forKey:NSStringFromSelector(@selector(text))
                  withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                      [expectation fulfill];
                      XCTAssertTrue([newValue isEqualToString:text]);
                  }];
    message.text = text;
    [self waitForExpectations:@[expectation] timeout:2];
}

@end
