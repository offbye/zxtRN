//
//  SwiftRNViewController.swift
//  zxtRn
//  Swift版本的RN容器页面
//
//  Created by 张西涛 on 16/6/3.
//  Copyright © 2016年 Facebook. All rights reserved.
//

import UIKit

class SwiftRNViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsCodeLocation = NSURL(string: "http://localhost:8081/index.ios.bundle?platform=ios&dev=true")
    let rootView = RCTRootView(bundleURL: jsCodeLocation,
                               moduleName: "zxtRn",
                               initialProperties:nil,
                               launchOptions:nil)
    rootView.frame = UIScreen.mainScreen().bounds
    self.view = rootView

//    let myFrame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 100)
//    let myView = UIView(frame: myFrame)
//    myView.backgroundColor = UIColor.blueColor()
//    self.view.addSubview(myView)
//    rootView.frame = CGRect(x: 0, y: 100, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 100)
//    self.view.addSubview(rootView)
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    deinit {
      print("SwiftRNViewController deinit")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
