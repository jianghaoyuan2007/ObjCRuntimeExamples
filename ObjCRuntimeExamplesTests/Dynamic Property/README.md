
## Overview

以动态解析的方式来实现 @dynamic 属性。

```objective-c

+ (BOOL)resolveInstanceMethod:(SEL)sel

```

* 因为用 @dynamic 的属性并没有实现其 Getter 和 Setter 的方法。但在对其进行调用的时候（object.opaqueObject = @123），会在 object 对应的类中查找 setOpaqueObject 方法。

* 在本类及其父类中没有找到该方法的时候，此时会以动态解析的方式去处理。 

* 如果在动态解析的过程中对该类添加了相关的方法，那么该方法会被缓存到这个类对应的方法缓存中，下次直接从缓存中直接查找并跳转。

* 在 `EOCAutoDictionary` 类中，私有属性 `backingStore` 用作存储这些 @dynamic 属性的容器。

## References

* [第 12 条：理解消息转发机制（Effective Objective-C 2.0）](https://www.amazon.cn/dp/B00IDSGY06/ref=sr_1_1?ie=UTF8&qid=1527576434&sr=8-1&keywords=effective+objective-c+2.0)
