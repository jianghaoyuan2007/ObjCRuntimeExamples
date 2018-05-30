## Objective-C Runtime Examples

该项目主要用于对 `Objective-C` 的 `Runtime` 特性相关的应用进行整理。

## Features

目前涉及到的相关特性如下：

* Dynamic Property 

* KVO

* KVC

* Message Forwarding

* Method Swizzling

* Multiple Inheritance

## Resources

* [RetVal/objc-runtime](https://github.com/RetVal/objc-runtime)

Objective-C Runtime 相关的代码已经开源，这个 GitHub 项目是可以在 macOS 上直接编译运行的。

## Tips

* 启用 `objc_msgSend` 相关的方法

若要在工程中使用 `objc_msgSend` 相关的方法，需要进行如下设置：`Build Settings -> Enable Strict Checking of objc_msgSend Calls -> No`


 
 

## References

* [Effective Objective-C 2.0](https://www.amazon.com/Effective-Objective-C-2-0-Specific-Development-ebook/dp/B00CUG5MZA)

* [该如何阅读 Objective-C runtime源码?](https://www.zhihu.com/question/33634266)


