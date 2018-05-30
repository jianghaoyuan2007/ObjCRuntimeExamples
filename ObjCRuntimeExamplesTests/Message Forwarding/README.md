
## NSInvocation

An Objective-C message rendered as an object.

NSInvocation 对象具有可以执行 Objective-C 方法调用所有的内容。

使用方法可以参考 `NSInvocationTests.m` 里面的 `- (void)testInvocationObjectCalledAsExpected` 方法。

## Message Forwarding

NSProxy
    ---> - (NSMethodSignature *)methodSignatureForSelector:(SEL)sel 
    ---> - (void)forwardInvocation:(NSInvocation *)invocation

## References

* 第 12 条：理解消息转发机制（Effective Objective-C 2.0）

* (Objective-C 中的消息与消息转发)[https://blog.ibireme.com/2013/11/26/objective-c-messaging/]
