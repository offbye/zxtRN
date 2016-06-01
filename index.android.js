/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';

import {
  AppRegistry,
  StyleSheet,
  Text,
  Image,
  TextInput,
  View,
	Platform,
	ToastAndroid,
	NativeModules
} from 'react-native';
import codePush from "react-native-code-push";
var SendIntentAndroid = require('react-native-send-intent');


class zxtRn extends Component {
  constructor(props) {
      super(props);
      this.state = {
   			TEXT: 'Input Text',//这里放你自己定义的state变量及初始值
      };

  }

  //在这里判断是否第一次进来，是则展示 Intro
  componentDidMount() {
		console.log("componentDidMount!");
		//获取intent extra传来的数据
		NativeModules.MyIntentModule.getDataFromIntent(
				 (successMsg) =>{
					 console.log("js getDataFromIntent");

					 console.log("successMsg" + successMsg);
				 this.setState({TEXT: successMsg,}); //状态改变的话重新绘制界面
					},
					(erroMsg) => {alert(erroMsg)}
		 );

		 
		setTimeout(function(){
			console.log("setTimeout!");

		},5000);

      codePush.checkForUpdate()
          .then((update) => {
              if (!update) {
                  console.log("The app is up to date!");
              } else {
                  console.log("An update is available! Should we download it?");
                  codePush.sync();
              }
          });


  }
  componentUnDidMount() {
		console.log("componentUnDidMount");

		NativeModules.MyIntentModule.finishActivity(this.state.TEXT);
	}

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.android.js
        </Text>
        <Text style={styles.instructions}>
          Shake or press menu button for dev menu
        </Text>
        <Image source={{uri: 'https://facebook.github.io/react/img/logo_og.png'}}
        style={{width: 400, height: 400}} />
        <Text style={styles.codepush}>
          code push test
        </Text>
        <TextInput
                style={{height: 40, borderColor: 'gray', borderWidth: 1,margin:20,}}
                onChangeText={(text) => this.setState({text})}
                value={this.state.TEXT} />

        <Text style={styles.button} onPress={() => this.sendSMS()} >
          Send SMS
        </Text>

      </View>
    );
  }

  sendSMS(){
		ToastAndroid.show("sendSMS!",ToastAndroid.SHORT);
    SendIntentAndroid.sendText({
      title: 'Please share this text',
      text: 'Lorem ipsum dolor sit amet, per error erant eu, antiopam intellegebat ne sed',
      type: SendIntentAndroid.TEXT_PLAIN
    });
  }

}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  codepush: {
    textAlign: 'center',
    color: '#00ff00',
    marginBottom: 5,
  },
  button: {
    textAlign: 'center',
    color: '#00ffff',
    margin: 20,
    padding:20
  },
});

AppRegistry.registerComponent('zxtRn', () => zxtRn);
