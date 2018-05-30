
## Unit Tests for Objective-C Runtime Examples 

* 该目录下所有的目录内容都是为了描述一些特定的主题。最终都是以一个单元测试的实例存在的。

* 每个目录的名称表示了其特定的主题内容。

## The Rules of Unit Testing

### 组成元素

* 项目：创建一个名为 `[ProjectUnderTest].UnitTests` 的测试项目。

* 类：对应被测试项目中的类，创建一个名为 `[ClassName]Tests` 的类。

* 工作单元：对每个工作单元，创建一个如下命名的测试方法：`[UnitOfWorkName]_[ScenarioUnderTest]_[ExpectedBehavior]`。

### 测试方法名称

* UnitOfWorkName：被测试的方法、一组方法或一组类。

* Scenario：测试进行的假设条件。

* ExpectedBehavior：在测试场景指定的条件下，你对被测试方行为的预期。


## References

* 《单元测试的艺术》- 2.3 NUnit 初步


