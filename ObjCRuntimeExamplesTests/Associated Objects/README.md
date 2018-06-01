
## Overview 

### Objective-C Category 添加属性

在 `Objective-C` 中类别（Category）可以给类添加方法，但却不能添加属性（Property）。为了解决这个问题可以使用 `Associated Objects` 来实现。

### 对象在被释放之前执行指定的 `block`

`- (void)runAtDealloc: (TSEmptyBlock)block;`


## References

* [Associated Objects](http://nshipster.cn/associated-objects/)

* [Fun With the Objective-C Runtime: Run Code at Deallocation of Any Object](https://blog.slaunchaman.com/2011/04/11/fun-with-the-objective-c-runtime-run-code-at-deallocation-of-any-object/)
