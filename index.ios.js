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
  View,
  NativeModules
} from 'react-native';

class zxtRn extends Component {
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
        <Text style={styles.button} onPress={() => { NativeModules.CalendarManager.addEvent('One', 'Two', 3); } } >
           Call Swift Module
        </Text>
        <Text style={styles.button} onPress={() => { NativeModules.CalendarManager.pushNative('Test', 'page2',{}); } } >
          Enter Swift Page2
        </Text>
      </View>
    );
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
