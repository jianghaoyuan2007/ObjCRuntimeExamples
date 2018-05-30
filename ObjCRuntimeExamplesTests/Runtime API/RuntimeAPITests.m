//
//  RuntimeAPITests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/30.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@interface RuntimeAPITests : XCTestCase

@end

@implementation RuntimeAPITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetIMPAndInvokeIt {
    NSString *string = @"HELLO WORLD!";
    
    SEL sel = @selector(lowercaseString);
    IMP implementation = class_getMethodImplementation([NSString class], sel);
    
    NSString *result =  implementation(string, sel);

    XCTAssertTrue([result isEqualToString:[string lowercaseString]]);
}

- (void)testSuperclassOfCreatedSubclassIsSameWithClass {
    Class class = [NSObject class];
    void *ref = (__bridge void *)class;
    const char *className = [[NSString stringWithFormat:@"%@-%p-%u", NSStringFromClass(class), ref, arc4random()] UTF8String];
    Class subclass = objc_allocateClassPair(class, className, 0);
    objc_registerClassPair(subclass);
    
    Class newClass = objc_getClass(className);
    Class superclass = class_getSuperclass(newClass);
    XCTAssertNotNil(newClass);
    XCTAssertTrue(superclass == class);
}

@end
