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
  View
} from 'react-native';
import codePush from "react-native-code-push";

class zxtRn extends Component {
  constructor(props) {
      super(props);
  }

  //在这里判断是否第一次进来，是则展示 Intro
  componentDidMount() {
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
  codepush: {
    textAlign: 'center',
    color: '#00ff00',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('zxtRn', () => zxtRn);
