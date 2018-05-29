//
//  DynamicPropertyTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EOCAutoDictionary.h"

@interface DynamicPropertyTests : XCTestCase

@end

@implementation DynamicPropertyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringOfEOCAutoDictionarySetterAndGetterWorks {
    NSString *contentOfTested = @"Hello World!";
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    dict.string = contentOfTested;
    XCTAssertTrue([dict.string isEqualToString:contentOfTested]);
}

- (void)testNumberOfEOCAutoDictionarySetterAndGetterWorks {
    NSNumber *contentOfTested = @123;
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    dict.number = contentOfTested;
    XCTAssertTrue(dict.number == contentOfTested);
}

- (void)testDateOfEOCAutoDictionarySetterAndGetterWorks {
    NSDate *contentOfTested = [NSDate date];
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    dict.date = contentOfTested;
    XCTAssertTrue(dict.date == contentOfTested);
}

- (void)testOpaqueObjectOfEOCAutoDictionarySetterAndGetterWorks {
    NSObject *contentOfTested = [NSObject new];
    EOCAutoDictionary *dict = [EOCAutoDictionary new];
    dict.opaqueObject = contentOfTested;
    // 第二次调用 `Setter` 方法将不在走动态解析的方法（ + (BOOL)resolveInstanceMethod:(SEL)sel）
    // 因为此方法已在类的方法缓存列表中
    dict.opaqueObject = contentOfTested;
    XCTAssertTrue(dict.opaqueObject == contentOfTested);
}


@end
