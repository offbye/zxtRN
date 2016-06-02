//
//  CalendarManagerBridge.m
//  zxtRn
//
//  Created by 张西涛 on 16/6/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
 
// CalendarManagerBridge.m
#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(CalendarManager, NSObject)

RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:nonnull (NSNumber *)date)

@end