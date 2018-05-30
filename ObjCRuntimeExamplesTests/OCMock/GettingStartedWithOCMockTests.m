//
//  GettingStartedWithOCMockTests.m
//  ObjCRuntimeExamplesTests
//
//  Created by Stephen Chiang on 2018/5/30.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface Tweet: NSObject

@property (nonatomic, copy) NSString *content;

@end

@implementation Tweet

- (id)initWithContent:(NSString *)content {
    if (self = [super init]) {
        _content = [content copy];
    }
    return self;
}

@end

@interface TwitterConnection: NSObject

- (NSArray *)fetchTweets;

- (NSArray *)retrieveTweetsForSearchTerm:(NSString *)term;

@end

@implementation TwitterConnection

- (NSArray *)fetchTweets {
    return nil;
}

- (NSArray *)retrieveTweetsForSearchTerm:(NSString *)term {
    return nil;
}

@end

@interface TweetView: NSObject

- (void)addTweet:(Tweet *)aTweet;

@end

@implementation TweetView

- (void)addTweet:(Tweet *)aTweet {
    
}

@end

@interface Controller: NSObject

@property(retain) TwitterConnection *connection;
@property(retain) TweetView *tweetView;

- (void)updateTweetView;

@end

@implementation Controller

- (void)updateTweetView {
//    NSArray *tweets = [self.connection fetchTweets];
    NSArray *tweets = [self.connection retrieveTweetsForSearchTerm: @"123"];
    if (tweets != nil) {
        /* display tweets */
        for (Tweet *tweet in tweets) {
            NSLog(@"The content of message: %@", tweet.content);
            [self.tweetView addTweet:tweet];
        }
    } else {
        /* handle error cases */
        NSLog(@"Error!");
    }
}

@end

@interface GettingStartedWithOCMockTests : XCTestCase

@end

@implementation GettingStartedWithOCMockTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)DISABLE_testDisplaysTweetsRetrievedFromConnection {
    
    Controller *controller = [[Controller alloc] init];
    
    id mockConnection = OCMClassMock([TwitterConnection class]);
    controller.connection = mockConnection;
    
    // 对 mockConnection 对象进行 Stub，使其可以返回预期的内容。
    // 这里 mockConnection 对象会返回单条信息。
    Tweet *testTweet = [[Tweet alloc] initWithContent:@"A new message."];
    NSArray *tweetArray = [NSArray arrayWithObject:testTweet];
    OCMStub([mockConnection fetchTweets]).andReturn(tweetArray);
    
    // updateTweetView 方法中调用了 mockConnection 中的 fetchTweets 方法，该方法已经设置返回特定的内容。
    [controller updateTweetView];
}

- (void)testDisplaysTweetsRetrievedFromConnection {
    Controller *controller = [[Controller alloc] init];
    
    id mockConnection = OCMClassMock([TwitterConnection class]);
    controller.connection = mockConnection;
    
    Tweet *testTweet = [[Tweet alloc] initWithContent:@"A new message."];
    NSArray *tweetArray = [NSArray arrayWithObject:testTweet];
    OCMStub([mockConnection retrieveTweetsForSearchTerm:[OCMArg any]]).andReturn(tweetArray);
    
    id mockView = OCMClassMock([TweetView class]);
    controller.tweetView = mockView;
    
    [controller updateTweetView];
    
    OCMVerify([mockView addTweet:[OCMArg any]]);
}

@end
