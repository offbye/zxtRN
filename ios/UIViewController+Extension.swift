//
//  UIViewController+Extension.swift
//  zxtRn
//
//  Created by 张西涛 on 16/6/3.
//  Copyright © 2016年 Facebook. All rights reserved.
//

import Foundation

var globalData : String? = "tedddddd"
extension UIViewController {

  func setParam(param:String? ) {
    globalData = param
  }
  
  func getParam() -> String? {
    return globalData
  }
  
}