//
//  KVOTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/29.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <objc/message.h>

static void *XXContext = &XXContext;

@interface WeatherReport: NSObject

@property (nonatomic, assign) int temperature;

@end

@implementation WeatherReport

@end

@interface KVOTests : XCTestCase

@end

@implementation KVOTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReportTemperautreExpectedValueIs20 {
    WeatherReport *report = [WeatherReport new];
    NSString *keyPath = NSStringFromSelector(@selector(temperature));
    XCTKVOExpectation *expectation = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                         object:report
                                                                  expectedValue:@20];
    [report addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:XXContext];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        report.temperature = 20;
    });
    [self waitForExpectations:@[expectation] timeout:2];
    @try {
        [report removeObserver:self forKeyPath:NSStringFromSelector(@selector(temperature))];
    } @catch (NSException * expection) {
        NSLog(@"%@", expection);
    }
}

- (void)testReportTemperautreExpectedValueAre20_30_40 {
    WeatherReport *report = [WeatherReport new];
    NSString *keyPath = NSStringFromSelector(@selector(temperature));
    XCTKVOExpectation *expectation20 = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                           object:report
                                                                    expectedValue:@20];
    XCTKVOExpectation *expectation30 = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                           object:report
                                                                    expectedValue:@30];
    XCTKVOExpectation *expectation40 = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                           object:report
                                                                    expectedValue:@40];
    
    [report addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:XXContext];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        report.temperature = 20;
        report.temperature = 40;
        report.temperature = 30;
    });
    [self waitForExpectations:@[expectation20, expectation30, expectation40] timeout:2];
    @try {
        [report removeObserver:self forKeyPath:NSStringFromSelector(@selector(temperature))];
    } @catch (NSException * expection) {
        NSLog(@"%@", expection);
    }
}

- (void)testNonKVOClassOfReportInstanceIsWeatherReportClass {
    WeatherReport *report = [WeatherReport new];
    Class classOfReportInstance = object_getClass(report);
    XCTAssertTrue(classOfReportInstance == [WeatherReport class]);
}

- (void)testKVOOriginalClassOfReportInstanceIsWeatherReportClass {
    WeatherReport *report = [WeatherReport new];
    Class originalClassOfReportInstance = object_getClass(report);
    XCTAssertTrue(originalClassOfReportInstance == [WeatherReport class]);
    NSLog(@"%@", NSStringFromClass(originalClassOfReportInstance));
    NSString *keyPath = NSStringFromSelector(@selector(temperature));
    XCTKVOExpectation *expectation = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                         object:report
                                                                  expectedValue:@20];
    [report addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:XXContext];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        report.temperature = 20;
    });
    [self waitForExpectations:@[expectation] timeout:2];
    @try {
        [report removeObserver:self forKeyPath:NSStringFromSelector(@selector(temperature))];
    } @catch (NSException * expection) {
        NSLog(@"%@", expection);
    }
}

- (void)testKVOTempClassOfReportInstanceIsNSKVONotifying_WeatherReportClass {
    WeatherReport *report = [WeatherReport new];
    NSString *keyPath = NSStringFromSelector(@selector(temperature));
    XCTKVOExpectation *expectation = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                         object:report
                                                                  expectedValue:@20];
    [report addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:XXContext];
    Class tempClassOfReportInstance = object_getClass(report);
    XCTAssertTrue(tempClassOfReportInstance == [objc_getClass("NSKVONotifying_WeatherReport") class]);
    NSLog(@"%@", NSStringFromClass(tempClassOfReportInstance));
    Class superclassOfTempClassOfReportInstance = class_getSuperclass(tempClassOfReportInstance);
    XCTAssertTrue(superclassOfTempClassOfReportInstance == [WeatherReport class]);
    NSLog(@"%@", NSStringFromClass(superclassOfTempClassOfReportInstance));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        report.temperature = 20;
    });
    [self waitForExpectations:@[expectation] timeout:2];
    @try {
        [report removeObserver:self forKeyPath:NSStringFromSelector(@selector(temperature))];
    } @catch (NSException * expection) {
        NSLog(@"%@", expection);
    }
}

- (void)testKVORemovedClassOfReportInstanceIsWeatherReportClass {
    WeatherReport *report = [WeatherReport new];
    NSString *keyPath = NSStringFromSelector(@selector(temperature));
    XCTKVOExpectation *expectation = [[XCTKVOExpectation alloc] initWithKeyPath:keyPath
                                                                         object:report
                                                                  expectedValue:@20];
    [report addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew
                context:XXContext];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        report.temperature = 20;
    });
    [self waitForExpectations:@[expectation] timeout:2];
    @try {
        [report removeObserver:self forKeyPath:NSStringFromSelector(@selector(temperature))];
    } @catch (NSException * expection) {
        NSLog(@"%@", expection);
    }
    Class removedClassOfReportInstance = object_getClass(report);
    XCTAssertTrue(removedClassOfReportInstance == [WeatherReport class]);
    NSLog(@"%@", NSStringFromClass(removedClassOfReportInstance));
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == XXContext) {
        if ([object isKindOfClass:[WeatherReport class]]) {
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(temperature))]) {
                NSLog(@"change: %@", change);
            }
        }
    }
}

@end
