## Overview

利用 Objective-C Runtime API，可以去做很多意想不到的事情。

* 获得一个对象其 SEL 对应的函数指针 IMP，并执行。

* 在运行过程中创建一个类的子类。

## Source Code

`SEL` 与 `IMP` 在 `<objc/objc.h>` 中定义如下：

```objective-c

/// An opaque type that represents a method selector.
typedef struct objc_selector *SEL;

/// A pointer to the function of a method implementation. 
#if !OBJC_OLD_DISPATCH_PROTOTYPES
typedef void (*IMP)(void /* id, SEL, ... */ ); 
#else
typedef id _Nullable (*IMP)(id _Nonnull, SEL _Nonnull, ...); 
#endif

```

## References


