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
  
  
}
