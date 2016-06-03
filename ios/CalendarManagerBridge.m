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
RCT_EXTERN_METHOD(pushView:(NSString *)storyboadName storyboadId:(NSString *)storyboadId data: (NSString *)data)

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


RCT_EXPORT_METHOD(startPage2:(NSString *)name location:(NSString *)location)
{
  NSLog(@"name %@ location %@", name, location);
  UINavigationController *controller = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];

  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Test" bundle:nil];
  UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"page2"];
  vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  [controller pushViewController:vc animated:YES];
//  [self.navigationController presentViewController: vc animated:YES completion:nil];

  
//  Page2ViewController *TestVC = [[Page2ViewController alloc] init];
//  [self.navigationController pushViewController:TestVC animated:YES];
  
}


RCT_EXPORT_METHOD(pushNative:(NSString *)storyName controllerId:(NSString *)controllerId params:(NSDictionary *)json)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:storyName bundle:nil];
    UIViewController *suitViewControllers = [secondStoryBoard instantiateViewControllerWithIdentifier:controllerId];
    [suitViewControllers setHidesBottomBarWhenPushed:YES];
//    [self setproperties:suitViewControllers andParams:json];
    [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController pushViewController:suitViewControllers animated:YES];
    
  });
}


@end