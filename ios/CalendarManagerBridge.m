//
//  CalendarManagerBridge.m
//  zxtRn
//
//  Created by 张西涛 on 16/6/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIStoryboard.h>
#import <UIKit/UIViewController.h>


// CalendarManagerBridge.m
#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(CalendarManager, NSObject)

RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:nonnull (NSNumber *)date)
RCT_EXTERN_METHOD(pushView:(NSString *)storyBoard controller:(NSString *)controller data: (NSString *)data)

RCT_EXTERN_METHOD(pushPage2:(NSString *)storyBoard controller:(NSString *)controller data: (NSString *)data callback: (RCTResponseSenderBlock *)callback)

static CalendarManager *_instance = nil;
+(instancetype)sharedInstance
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [CalendarManager new];
  });
  return _instance;
}

-(instancetype)init
{
  if(_instance == nil)
  {
    return [super init];
  }
  return _instance;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}



RCT_EXPORT_METHOD(pushNative:(NSString *)storyName controllerId:(NSString *)controllerId params:(NSDictionary *)json)
{
  NSLog(@"pushNative storyName %@ controllerId %@", storyName, controllerId);

  dispatch_async(dispatch_get_main_queue(), ^{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:storyName bundle:nil];
    UIViewController *suitViewControllers = [secondStoryBoard instantiateViewControllerWithIdentifier:controllerId];
    [suitViewControllers setHidesBottomBarWhenPushed:YES];
//    [self setproperties:suitViewControllers andParams:json];
    [(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController)  pushViewController:suitViewControllers animated:YES];
    
//    UIViewController *root = [[[[UIApplication sharedApplication] delegate]
//                               window] rootViewController];
//    [root presentViewController:suitViewControllers animated:YES completion:NULL];
    
    
  });
}


RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  NSArray *events = [NSArray init ];
  [events arrayByAddingObject: @"aaaa"];
  [events arrayByAddingObject: @"bbbb"];

  callback(@[[NSNull null], events]);
}


//RN传参数调用原生OC,并且返回数据给RN  通过Promise
RCT_EXPORT_METHOD(RNInvokeOCPromise:(NSDictionary *)dictionary resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  NSLog(@"接收到RN传过来的数据为:%@",dictionary);
  NSString *value=[dictionary objectForKey:@"name"];
  if([value isEqualToString:@"jiangqq"]){
    resolve(@"回调成功啦,Promise...");
  }else{
    NSError *error=[NSError errorWithDomain:@"传入的name不符合要求,回调失败啦,Promise..." code:100 userInfo:nil];
    reject(@"100",@"传入的name不符合要求,回调失败啦,Promise...",error);
  }
}

@end