//
//  ShakeViewController.swift
//  选择
//
//  Created by 董思言 on 14/12/14.
//  Copyright (c) 2014年 董思言. All rights reserved.
//

import UIKit

class ShakeViewController: UIViewController {

    var names: NSMutableArray!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        mainLabel.text = "摇动手机进行选择"
        if NSFileManager.defaultManager().fileExistsAtPath(self.dataFilePath()) {
            names = NSMutableArray(contentsOfFile: self.dataFilePath())
        }
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake {
            if names.count == 0 {
                let msgView = UIAlertView(title: nil, message: nil, delegate: nil, cancelButtonTitle: "列表为空")
                msgView.show()
            }
            else{
                let msgView = UIAlertView(title: nil, message: nil, delegate: nil, cancelButtonTitle: "检测到摇动")
                msgView.show()
                let count = UInt32(names.count)
                let ran = Int(arc4random()%count)
                mainLabel.text = names[ran]["nameInfo"] as? String
            }
        }
    }
    
//返回沙盒中的plist
    func dataFilePath()->String{
        let path = NSHomeDirectory() //返回主目录，还需进入Documents目录下，路径后面直接加上/Documents就哦可
        let pathD = path + "/Documents" as String
        return pathD.stringByAppendingPathComponent("list.plist")
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
