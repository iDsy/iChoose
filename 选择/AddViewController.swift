//
//  AddViewController.swift
//  选择
//
//  Created by 董思言 on 14/12/13.
//  Copyright (c) 2014年 董思言. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    var nameInfo: String!
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBAction func backgroundButtonClicked(sender: AnyObject) {
        nameTextField.resignFirstResponder()
    }
    @IBAction func finishButtonClicked(sender: AnyObject) {
        nameInfo = nameTextField.text
        if nameInfo.isEmpty {
            let msgView = UIAlertView(title: "", message: "名称不能为空", delegate: nil, cancelButtonTitle: "重新输入")
            msgView.show()
            return
        }
        self.save()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save(){
        let info = ["nameInfo": nameInfo]
        NSNotificationCenter.defaultCenter().postNotificationName("add", object: nil, userInfo: info)
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
