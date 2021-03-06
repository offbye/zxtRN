package com.zxtrn.myintent;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.JSApplicationIllegalArgumentException;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.zxtrn.MyConstants;

/**
 * Created by zhangxitao on 16/6/1.
 */
class MyIntentModule extends ReactContextBaseJavaModule {
    private ReactApplicationContext reactContext;

    public MyIntentModule(ReactApplicationContext reactContext) {
        super(reactContext);
        Log.i("MyIntentModule","MyIntentModule");

        this.reactContext = reactContext;
    }

    @ReactMethod
    public void getDataFromIntent(Callback successBack, Callback erroBack) {
        Log.i("MyIntentModule","getDataFromIntent");

        try {
            Activity currentActivity = getCurrentActivity();
            String result = currentActivity.getIntent().getStringExtra("result");//会有对应数据放入
            if (TextUtils.isEmpty(result)) {
                result = "No Data";
            }
            Log.i("MyIntentModule",result);
            successBack.invoke(result);
        } catch (Exception e) {
            erroBack.invoke(e.getMessage());
        }
    }

    @ReactMethod
    public void finishActivity(String result){
        Log.i("finishActivity",result);

        Activity currentActivity = getCurrentActivity();
        Intent intent = new Intent();
        intent.putExtra("result",result);
        currentActivity.setResult(11,intent);
        currentActivity.finish();
    }

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

    @ReactMethod
    public void startActivityForResult(String activityName, String data, int requestCode,Callback successCallback,Callback erroCallback){
        try {
            Activity currentActivity = getCurrentActivity();
            if ( null!= currentActivity) {
                Class aimActivity = Class.forName(activityName);
                Intent intent = new Intent(currentActivity,aimActivity);
                intent.putExtra("result", data);
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

    @Override
    public String getName() {
        return "MyIntentModule";
    }
}
