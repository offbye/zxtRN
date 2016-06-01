# React Native和Android，iOS原生项目集成实验项目

## 项目介绍
通过rnpm集成了CodePush， react-native-send-intent模块。
react-native-send-intent模块实现从React页面发起Intent发短信，打电话，添加日历事件等常见任务。进行简单扩展后可以支持启动任意原生Activity。
自己实现MyIntentModule模块通过Intent从MyAndroid传输数据到React界面。


## React Native Package Manager介绍
React Native Package Manager是为了简化React Native开发而生的包管理器。这个项目的想法来自CocoaPods, fastlane和react-native link。它的目标是让几乎全部可用的模块不需要额外配置就可以使用。
需要node4.0以上版本，基本安装和使用方法如下：

```ruby
# Installation
$ npm install rnpm -g
# Usage
$ npm install react-native-module --save
$ rnpm link react-native-module
```
下面我们看看实际如下使用rnpm吧，首先你要一个React Native项目啊，
没有就新建一个吧,
```
react-native init zxtRn
```
然后到https://js.coach/react-native/ 找需要的模块，以`react-native-send-intent` 为例吧。
[react-native-send-intent](https://github.com/lucasferreira/react-native-send-intent)模块提供在RN js代码中调用Android Intent发送短信，打电话的能力。
有了rnpm我们不需要通过模块github的说明一步一步配置了，只需要用下面的命令安装就行了。

```ruby
$ rnpm install react-native-send-intent
react-native-send-intent@1.0.10 node_modules/react-native-send-intent
rnpm-link info Linking react-native-send-intent android dependency
rnpm-link info Android module react-native-send-intent has been successfully linked
rnpm-install info Module react-native-send-intent has been successfully installed & linked
```

## MyIntentModule数据传输模块
