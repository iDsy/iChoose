//
//  ViewController.swift
//  选择
//
//  Created by 董思言 on 14/12/12.
//  Copyright (c) 2014年 董思言. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIAlertViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var names = NSMutableArray()
    var deleteIndRow: Int? = -1 //长按方法中 为何加？
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //监听添加
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addAObjct:", name: "add", object: nil)
        //长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        longPress.minimumPressDuration = 1.0; //设置长按时间
        self.collectionView.addGestureRecognizer(longPress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear(true)
        if NSFileManager.defaultManager().fileExistsAtPath(self.dataFilePath()) {
            names = NSMutableArray(contentsOfFile: self.dataFilePath())! //加叹号啥意思？
            self.collectionView.reloadData()
        }
    }

//collectionview
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return names.count + 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        if names.count == 0 {
            let addCell = collectionView.dequeueReusableCellWithReuseIdentifier("addCell", forIndexPath: indexPath) as AddCell
            addCell.layer.cornerRadius = 19
            return addCell
        }
        if indexPath.row == names.count {
            let addCell = collectionView.dequeueReusableCellWithReuseIdentifier("addCell", forIndexPath: indexPath) as AddCell
            addCell.layer.cornerRadius = 19
            return addCell
        }
        let listCell = collectionView.dequeueReusableCellWithReuseIdentifier("listCell", forIndexPath: indexPath) as ListCell
        
        listCell.layer.cornerRadius = 19
        let name = names[indexPath.row]["nameInfo"] as String
        listCell.nameLabel.text = name
        
        return listCell
    }
    
//segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "listToDetailSegue" {
            let indexPathArray = self.collectionView.indexPathsForSelectedItems()
            let indexPath = indexPathArray[0] as NSIndexPath
            let detailViewController = segue.destinationViewController as DetailViewController
            detailViewController.nameSegue = names[indexPath.row]["nameInfo"] as String
        }
    }

//返回沙盒中的plist
    func dataFilePath()->String{
        let path = NSHomeDirectory()
        let pathD = path + "/Documents" as String
        return pathD.stringByAppendingPathComponent("list.plist")
    }

//通知方法:添加
    func addAObjct(notification:NSNotification){
        let info = notification.userInfo
        names.addObject(info!) //叹号啥意思
        names.writeToFile(self.dataFilePath(), atomically: true)
    }

//长按方法
    func longPress(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            let pointSelected = gestureRecognizer.locationInView(self.collectionView)
            let indexPath = self.collectionView.indexPathForItemAtPoint(pointSelected)
            
            if indexPath == nil || indexPath?.row == names.count {return}
            deleteIndRow = indexPath?.row
            
            let alertView = UIAlertView(title: "", message: "是否删除该项", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "删除")
            alertView.show()
        }
    }

//alertview
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex + 1 {
            self.deleteAObjct()
        }
    }

//删除
    func deleteAObjct(){
        names.removeObjectAtIndex(deleteIndRow!)
        names.writeToFile(self.dataFilePath(), atomically: true)
        self.collectionView.reloadData()
        deleteIndRow = -1
    }









}

