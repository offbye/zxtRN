//
//  IBHelper.swift
//  Shine
//
//  Created by haojunhua on 16/3/4.
//  Copyright © 2016年 qianmi. All rights reserved.
//

import Foundation
enum StoryboardNames : String {
  case Home = "Main"
  case Test = "Test"

}
enum VCStoryboardIdentifier : String {
  case Page1ViewController = "page1"
  case Page2ViewController = "page2"
}

class IBHelper {
    
    class func presentViewController(current:UIViewController?,storyBoard:StoryboardNames, controller:VCStoryboardIdentifier){
        IBHelper.presentViewController(current, storyBoard: storyBoard.rawValue, controller: controller.rawValue)
    }
    
    class func presentViewController(current:UIViewController?,storyBoard:String, controller:String) {
        if let current = current {
            let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
            let controller = storyBoard.instantiateViewControllerWithIdentifier(controller)
            current.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    
    class func pushStoryBoard(navi:UINavigationController?,storyBoard:StoryboardNames, controller:VCStoryboardIdentifier) {
        IBHelper.pushStoryBoard(navi, storyBoard: storyBoard.rawValue, controller: controller.rawValue,param: nil)
    }
    
  class func pushStoryBoard(navi:UINavigationController?,storyBoard:String, controller:String, param:String?) {
        if let navi = navi {
            let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
            let controller = storyBoard.instantiateViewControllerWithIdentifier(controller)
            controller.setParam(param)
            controller.hidesBottomBarWhenPushed=true
            navi.pushViewController(controller, animated: true)
        }
    }
  
  
  
    class func controllerFromStoryBoard(storyBoard:StoryboardNames, controller:VCStoryboardIdentifier) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier(controller.rawValue)
        return controller
    }
}
