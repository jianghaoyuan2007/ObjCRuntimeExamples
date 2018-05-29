
## Overview

### KVO (Key-Value Observing)

* KVO 是 Objective-C 对观察者模式（Observer Pattern）的实现。也是 Cocoa Binding 的基础。
* 当被观察对象的某个属性发生更改时，观察者对象会获得通知。

### KVO 实现机制

* KVO 的实现也依赖于 Objective-C 强大的 Runtime。
* 被观察对象的 isa 指针会指向一个中间类，而不是原来真正的类。
* 原来，这个中间类，继承自原本的那个类。不仅如此，Apple 还重写了 -class 方法，企图欺骗我们这个类没有变，就是原本那个类。更具体的信息，去跑一下 Mike Ash 的那篇文章里的代码就能明白，这里就不再重复。

### 简单概述下 KVO 的实现：

1. 当你观察一个对象时，一个新的类会动态被创建。
2. 这个类继承自该对象的原本的类，并重写了被观察属性的 setter 方法。
3. 自然，重写的 setter 方法会负责在调用原 setter 方法之前和之后，通知所有观察对象值的更改。
4. 最后，把这个对象的 isa 指针 ( isa 指针告诉 Runtime 系统这个对象的类是什么 ) 指向这个新创建的子类，对象就神奇的变成了新创建的子类的实例。

### NSObject (KVO)

在 `NSObject+KVO.h/m` 文件中实现了一个 `KVO`。该 `KVO` 可以传递一个 `Block` 来对属性进行监听。

## References

* [XCTest 测试实战](https://www.objccn.io/issue-15-2/)

* [Key-Value Observing](http://nshipster.cn/key-value-observing/)

* [XCTKVOExpectation](https://developer.apple.com/documentation/xctest/xctkvoexpectation?language=objc)

* [如何自己动手实现 KVO](http://tech.glowing.com/cn/implement-kvo/)
