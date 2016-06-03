package com.zxtrn;

import android.content.Intent;
import android.text.TextUtils;

import com.facebook.react.ReactActivity;
//import com.reactnativenavigation.RnnPackage;
import com.burnweb.rnsendintent.RNSendIntentPackage;
import com.microsoft.codepush.react.CodePush;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.zxtrn.myintent.MyReactPackage;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;

public class MainActivity extends ReactActivity {

    private CodePush _codePush;

    @Override
    protected String getJSBundleFile() {
      return this._codePush.getBundleUrl("index.android.bundle");
    }

    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "zxtRn";
    }

    /**
     * Returns whether dev mode should be enabled.
     * This enables e.g. the dev menu.
     */
    @Override
    protected boolean getUseDeveloperSupport() {
        return BuildConfig.DEBUG;
    }

    /**
     * A list of packages used by the app. If the app uses additional views
     * or modules besides the default ones, add more packages here.
     */
    @Override
    protected List<ReactPackage> getPackages() {
      this._codePush = new CodePush("UAvQtR1CTph9a9b4axtv3rupnJigVklbZAwzW", this, BuildConfig.DEBUG);

        return Arrays.<ReactPackage>asList(
            new MainReactPackage(),
//            new RnnPackage(),
            new RNSendIntentPackage(),
                new MyReactPackage(),
        this._codePush
            //new CodePush(this.getResources().getString(R.strings.reactNativeCodePush_androidDeploymentKey), this, BuildConfig.DEBUG)
        );
    }



    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK && requestCode == 100){
            String result = data.getStringExtra("result");
            if (!TextUtils.isEmpty(result)){
                MyConstants.myBlockingQueue.add(result);
            } else {
                MyConstants.myBlockingQueue.add("无数据传回");
            }
        } else {
            MyConstants.myBlockingQueue.add("没有");
        }
    }

}

