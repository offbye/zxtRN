//
//  Page2ViewController.swift
//  zxtRn
//
//  Created by 张西涛 on 16/6/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController {

  var data:String?
  var callback : RCTResponseSenderBlock?
  @IBOutlet weak var inputText: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if let data = data {
        inputText.text =  data
      }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func submit(sender: AnyObject) {
    print("submit ")
    if let callback = callback {
      print("callback ")

      callback(["",inputText.text!])
    }
    self.navigationController?.popViewControllerAnimated(true)

  }

  @IBAction func exit(sender: AnyObject) {
    self.navigationController?.popViewControllerAnimated(true)
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
