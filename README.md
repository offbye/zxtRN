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
###原生界面调用React界面

1.只是启动React界面的话很简单，同原生界面间的启动一样，直接用startActivity即可。

2.在启动React界面时传递数据给React界面。

先来捋下思路，原生界面启动是没问题的，同原生一样；关键是React界面如何获取到传递过来的值：从前面的学习中我们知道原生模块是有很大自由度的，只要能得到React界面所在activity就可以顺着得到传递的来的intent，而JS端想得到数据就要利用回调函数了。

接下来是实现思路，从后往前来：首先先要按之前构建原生模块的步骤一步步来构建我们这次需要的功能
```
public class MyIntentModule extends ReactContextBaseJavaModule
@ReactMethod
public void getDataFromIntent(Callback successBack,Callback erroBack){
    try{
        Activity currentActivity = getCurrentActivity();
        String result = currentActivity.getIntent().getStringExtra("result");//会有对应数据放入
        if (TextUtils.isEmpty(result)){
            result = "No Data";
        }
        successBack.invoke(result);
    }catch (Exception e){
        erroBack.invoke(e.getMessage());
    }
}
public class MyReactPackage implements ReactPackage
@Override
public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    return Arrays.<NativeModule>asList(
            new MyIntentModule(reactContext)
    );
}
public class MyReactActivity  extends ReactActivity
@Override
    protected List<ReactPackage> getPackages() {
        return Arrays.<ReactPackage>asList(
                new MainReactPackage(),
                new MyReactPackage()
        );
    }
```

在JS端配置相应代码

```
.......
class myreactactivity extends React.Component {
constructor(props) {
    super(props);   //这一句不能省略，照抄即可
    this.state = {
        TEXT: 'Input Text',//这里放你自己定义的state变量及初始值
    };
  }
  render() {
    return (
     <View style={styles.container}>
             <TextInput
                 style={{height: 40, borderColor: 'gray', borderWidth: 1,}}
                 onChangeText={(text) => this.setState({text})}
                 value={this.state.TEXT} />
     </View>
    )
  }
     componentDidMount(){   //这是React的生命周期函数，会在界面加载完成后执行一次
        React.NativeModules.MyIntentModule.getDataFromIntent(
            (successMsg) =>{
            this.setState({TEXT: successMsg,}); //状态改变的话重新绘制界面
             },
             (erroMsg) => {alert(erroMsg)}
        );
      }
}
.......
```

最后在原生界面将数据存放在intent里，然后用startActivity启动；

```
Intent intent =new Intent(this,MyReactActivity.class);
 intent.putExtra("result","haha");
 startActivity(intent,10);
```

3.原生界面启动React界面后等待回调数据。

在原生应用里是通过intent来传递数据，有 startActivityForResult和onAcitvityResult来满足启动和回调，回传数据的用setResult设置intent。同上面一样，由于可以得到当前activity，这些问题也迎刃而解了。

先在MyIntentModule里添加方法

```java
    @ReactMethod
    public void finishActivity(String result){
        Activity currentActivity = getCurrentActivity();
        Intent intent = new Intent();
        intent.putExtra("result",result);
        currentActivity.setResult(11,intent);
        currentActivity.finish();
    }
```

在JS端配置相应代码

`React.NativeModules.MyIntentModule.finishActivity(this.state.TEXT);`

至于原生界面里代码就略去不写了，会安卓的人都可以写出来了。

###React界面调用原生界面

1.只是启动原生界面

安卓中启动activity有隐式和显式，这里只考虑显示启动。显式启动需要指定目的activity的类，而我们虽然可以定制原生模块供JS调用，但并不能直接指定类或字节码为参数。一些特殊的情况下时可以用swtich的思路来解决，适用性更好的方法有没有呢，如何用允许的参数来得到目的类呢。这里就要要到反射了。

先在MyIntentModule里添加方法

```java
    @ReactMethod
    public void startActivityByString(String activityName){
        try {
            Activity currentActivity = getCurrentActivity();
            if (null != currentActivity) {

                       Class aimActivity = Class.forName(activityName);
                Intent intent = new Intent(currentActivity,aimActivity);
                currentActivity.startActivity(intent);
            }
        } catch (Exception e) {
            throw new JSApplicationIllegalArgumentException(
                    "Could not open the activity : " + e.getMessage());
        }
    }
```

在JS里调用

`React.NativeModules.MyIntentModule.startActivityByString("com.zxtrn.SecondActivity")`

2.启动原生界面并传递进数据

这和上面相比就是多了几个参数的事，没有啥好讲的，只是只能传递基本数据类型的参数。要想做到和原生一样在intent里任意传递基本数据和类还做不到，而且要想自己用的方便一点的话还需要再考虑封装模块方法，在此不赘述。

3.React界面启动原生界面后等待回调数据

启动原生界面是同2一样的，问题在于原生界面返回的数据是在React界面所在Activity的onActvityResult里接受的，而JS端接受原生模块传回的数据是通过调用原生模块方法时设置的回调函数接受到的，如何将onActivityResult里的数据实时传递到原生模块里方法设置的回调函数里呢？如果不考虑这些回调只是把数据存在变量或者文件里，用一个类似messageQueue的思路应该可以解决，不过那样需要可能效率上不太高，我们自己实现起来也不太方便。幸运的是在Java里已经有BlockingQueue了。

先在MyReactActivity里添加代码

```java
public static ArrayBlockingQueue<String> myBlockingQueue = new ArrayBlockingQueue<String>(1);

@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK && requestCode == 100){
            String result = data.getStringExtra("result");
            if (！TextUtils.isEmpty(result)){
                    MyConstants.myBlockingQueue.add(result);
                } else {
                    MyConstants.myBlockingQueue.add("无数据传回");
                }
            }
        }else{
            MyConstants.myBlockingQueue.add("没有");
        }
    }
```

在MyIntentModule里添加方法

```
@ReactMethod
    public void startActivityForResult(String activityName,int requestCode,Callback successCallback,Callback erroCallback){
        try {
            Activity currentActivity = getCurrentActivity();
            if ( null!= currentActivity) {
                Class aimActivity = Class.forName(activityName);
                Intent intent = new Intent(currentActivity,aimActivity);
                currentActivity.startActivityForResult(intent,requestCode);
                String result = MyConstants.myBlockingQueue.take();
                successCallback.invoke(result);
            }
        } catch (Exception e) {
            erroCallback.invoke(e.getMessage());
            throw new JSApplicationIllegalArgumentException(
                    "Could not open the activity : " + e.getMessage());
        }
    }
```

在JS端调用

```
React.NativeModules.MyIntentModule.startActivityForResult(
      "com.zxtrn.SecondActivity",100,
      (successMsg) => {
            this.setState({TEXT: successMsg, });
      },
      (erroMsg) => {alert(erroMsg)}
      );
```

原生界面的代码也要记得写，不过也没啥好说的了，按原生安卓一样写个setResult就可以了。
```java
      fab.setOnClickListener(new View.OnClickListener() {
           @Override
           public void onClick(View view) {
               Snackbar.make(view, "finish with SecondActivity data", Snackbar.LENGTH_LONG)
                       .setAction("Action", null).show();
               Intent intent = new Intent();
               intent.putExtra("result","SecondActivity data");
               setResult(RESULT_OK,intent);
               finish();
           }
       });
```


参考文章
* https://js.coach/react-native/
* https://github.com/ipk2015/RN-Resource-ipk/tree/master/react-native-docs