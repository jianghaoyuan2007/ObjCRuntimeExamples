//
//  OCMockTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface SomeController: NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;;

@end

@implementation SomeController

- (void)updateUserDefaults {
    [self.userDefaults setObject:@"Object" forKey:@"Key"];
}

@end

@interface OCMockTests : XCTestCase

@end

@implementation OCMockTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// MARK: - Creating stubs for instance and class methods

- (void)testOCMStubSpecifiedArguementAndReturnWorkAsExpected {
    // create a mock for the user defaults
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);

    NSString *specifiedArguement = @"MyAppURLKey";
    NSString *expectedReturnValue = @"http://testurl";
    
    // set it up to return a specific value when stringForKey: is called
    OCMStub([userDefaultsMock stringForKey:specifiedArguement]).andReturn(expectedReturnValue);

    XCTAssertTrue([[userDefaultsMock stringForKey:specifiedArguement] isEqualToString:expectedReturnValue]);
}

- (void)testOCMStubAnyArguementAndReturnWorkAsExpected {
    // create a mock for the user defaults
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    
    NSString *specifiedArguement = @"MyAppURLKey";
    NSString *expectedReturnValue = @"http://testurl";
    
    // set it up to return a specific value when stringForKey: is called
    OCMStub([userDefaultsMock stringForKey:[OCMArg any]]).andReturn(expectedReturnValue);
    
    XCTAssertTrue([[userDefaultsMock stringForKey:specifiedArguement] isEqualToString:expectedReturnValue]);
}

- (void)testOCMStubClassMethodAndReturnWorkAsExpected {
    // 使用 object_getClass 方法来获取该类的 Meta Class，目的是可以在下面的代码中调用类方法。
    id userDefaultsMock = OCMClassMock(object_getClass([NSUserDefaults class]));

    // stub a class method to return our mock, and not the standard shared instance
    OCMStub([userDefaultsMock standardUserDefaults]).andReturn(userDefaultsMock);
    
    XCTAssertTrue([userDefaultsMock standardUserDefaults] == userDefaultsMock);
}

// MARK: - Verifying behaviour with a mock

- (void)testOCMVerifyCallUpdateUserDefaultsMethodAndSetObjectForKeyMethodIsCalled {
    SomeController *controller = [SomeController new];
    id mockedUserDefaults = OCMClassMock([NSUserDefaults class]);
    controller.userDefaults = mockedUserDefaults;
    
    [controller updateUserDefaults];
    
    OCMVerify([mockedUserDefaults setObject:@"Object" forKey:@"Key"]);
}

// MARK: - Mocking methods on an existing object: partial mocks




@end
