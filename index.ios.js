/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TextInput,
  View,
  NativeModules
} from 'react-native';

class zxtRn extends Component {
  constructor(props) {
      super(props);
      this.state = {
        TEXT: 'Input Text',//这里放你自己定义的state变量及初始值
        tonative: 'test',
      };

  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions} onPress={() => { NativeModules.CalendarManager.addEvent('One', 'Two', 3); } } >
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <View style={{height: 40, }} />
        <TextInput
                style={{height: 40, borderColor: 'gray', borderWidth: 1,margin:20,}}
                onChangeText={(text) => this.setState({TEXT:text})}
                value={this.state.TEXT} />

        <Text style={styles.button} onPress={() => { NativeModules.CalendarManager.addEvent('One', 'Two', 3); } } >
           Call Swift Module
        </Text>

        <Text style={styles.button} onPress={() => { NativeModules.CalendarManager.pushView('Test', 'page2',"dddd"); } } >
           pushView
        </Text>

        <Text style={styles.button} onPress={() => this.pushPage2() } >
           push Page2 with callback
        </Text>

        <Text style={styles.button} onPress={() => { NativeModules.CalendarManager.pushNative('Test', 'page2',{}); } } >
          Enter Swift Page2
        </Text>
      </View>
    );
  }

  pushPage2() {
    NativeModules.CalendarManager.pushPage2('Test', 'page2', this.state.TEXT, (error, events) => {
      if (error) {
        console.error(error);
      } else {
        console.error(events);

        this.setState({TEXT: "events"});
      }
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
  button: {
    textAlign: 'center',
    color: 'teal',
    fontSize: 24,
    margin: 5,
    padding: 5,
    borderWidth:1, //安卓Text好像还不支持边框，需要View嵌套，坑
    borderColor:'blue',
   },
});

AppRegistry.registerComponent('zxtRn', () => zxtRn);
