//
//  MultipleInheritanceTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/30.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/message.h>

@interface Airplane: NSObject

@end

@implementation Airplane

- (NSString *)takeOff {
    return @"Take Off";
}

@end

@interface Ship: NSObject

@end

@implementation Ship

- (NSString *)sail {
    return @"Sail";
}

@end

@interface Postcard: NSObject

@property (nonatomic, strong) Airplane *airplane;

@property (nonatomic, strong) Ship *ship;

@end

@implementation Postcard

- (id)init {
    if (self = [super init]) {
        
        _airplane = [Airplane new];
        
        _ship = [Ship new];
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    // aSelector 表示未知的 @selector
    if ([self.airplane respondsToSelector:aSelector]) {
        
        return self.airplane;
    } else if ([self.ship respondsToSelector:aSelector]) {
        
        return self.ship;
    } else {
        return [super forwardingTargetForSelector:aSelector];
    }
}

@end

@interface MultipleInheritanceTests : XCTestCase

@end

@implementation MultipleInheritanceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntanceOfPostcardCanResposeAirplaneAndShipSelectors {
    Postcard *postcard = [Postcard new];
    
    id result1 = [postcard performSelector:@selector(takeOff) withObject:nil];
    XCTAssertTrue([result1 isEqualToString:@"Take Off"]);
    
    id result2 = objc_msgSend(postcard, sel_registerName("sail"));
    XCTAssertTrue([result2 isEqualToString:@"Sail"]);
}


@end
