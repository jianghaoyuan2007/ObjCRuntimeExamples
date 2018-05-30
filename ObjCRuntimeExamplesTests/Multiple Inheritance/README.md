
## Overview

在 Objective-C Runtime 的消息转发机制中，当前接收者还有第二次机会处理未知的 `@selector`。在这一步中，Runtime 会询问它：能不能把这条消息转给其他接收者来处理。

```objective-c

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

```
方法参数代表未知的 @selector，若当前接收者可以找到备援对象，则将其返回。若找不到，则返回 nil。

通过这个方案，我们可以用“组合”来模拟出“多重继承”的某些特性。

在一个对象内部，可能还有一些了其他的对象，该对象可经由此方法将能够处理某 @selector 的相关内部对象返回，这样的话，在外界看来好像就是该对象亲自处理了这些消息。

## References

* 第 12 条：理解消息转发机制（Effective Objective-C 2.0）
