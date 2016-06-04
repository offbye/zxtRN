//
//  CalendarManager.swift
//  zxtRn
//
//  Created by 张西涛 on 16/6/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

import Foundation
// CalendarManager.swift

@objc(CalendarManager)
class CalendarManager: NSObject {
 
  
  @objc func addEvent(name: String, location: String, date: NSNumber!) -> Void {
    print("addEvent  \(name), \(location), \(date)");
    
  }
  
  @objc func pushView(storyBoard: String, controller: String, data : String) -> Void {
    print("pushView  \(storyBoard), \(controller), \(data)")
    IBHelper.pushStoryBoard(UIApplication.sharedApplication().keyWindow?.rootViewController as? UINavigationController, storyBoard: storyBoard, controller: controller, param: data)
  }
 
  @objc func pushPage2(storyBoard: String, controller: String, data : String, callback: RCTResponseSenderBlock) -> Void {
    print("pushView  \(storyBoard), \(controller), \(data)");
    
    let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
    let controller = storyBoard.instantiateViewControllerWithIdentifier(controller) as! Page2ViewController
    controller.data = data
    controller.hidesBottomBarWhenPushed = true
    controller.callback = callback
    if let navi = UIApplication.sharedApplication().keyWindow?.rootViewController as? UINavigationController {
      navi.pushViewController(controller, animated: true)
    }

  
  }
  
  
  
}
