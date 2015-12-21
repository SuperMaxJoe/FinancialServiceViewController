//
//  MuLuViewController.swift
//  zhucexiaofang
//
//  Created by shanghongzhi on 15/12/7.
//  Copyright © 2015年 shz. All rights reserved.
//

import UIKit

class MuLuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myTableView: UITableView!
    var mainString = NSString()
    var number = 0.0
    var cellString = ""
    var cell = UITableViewCell()
    let userDef = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消防师考试必备"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.backgroundColor = UIColor.clearColor()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.registerNib(UINib(nibName: "myCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "myCell")
        myTableView.tableFooterView = UIView.init(frame: CGRectZero)
        myTableView.bounces = false
        let rightButton = UIBarButtonItem.init(title:"上次阅读", style: UIBarButtonItemStyle.Done, target: self, action: "lastTimeReading")
        let dic = NSDictionary(object:UIFont.systemFontOfSize(13),forKey:NSFontAttributeName)
        rightButton.setTitleTextAttributes(dic as? [String : AnyObject], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)as! myCell
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        let readVC = ReadViewController()
//        readVC.addCellText { (text, mark) -> Void in
//            if indexPath.row == mark{
//                cell.numLabel.text = text
//                print(text)
//            }
//        }
        switch indexPath.row{
        case 0:cell.pageImageView.image = UIImage.init(named: "zonghe.png")
               cell.nameLabel.text = "消防安全技术综合能力"
        case 1:cell.pageImageView.image = UIImage.init(named: "shiwu")
               cell.nameLabel.text = "消防安全技术实务 "
        default:cell.pageImageView.image = UIImage.init(named: "anli")
                cell.nameLabel.text = "消防安全案例 "
            
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let readVC = ReadViewController()
        switch indexPath.row {
        case 0: let str = self.addFirstText()as String
                readVC.textString = str
                readVC.name = "消防安全技术综合能力"
                readVC.mark  = 0
                readVC.numString = userDef.objectForKey("jindu1")
            
        case 1:let str = self.addSecondText()as String
               readVC.textString = str
               readVC.name = "消防安全技术实务"
               readVC.mark = 1
               readVC.numString = userDef.objectForKey("jindu2")
        default:let str = self.addThirdText()as String
                readVC.textString = str
                readVC.name = "消防安全案例"
                readVC.mark = 2
                readVC.numString = userDef.objectForKey("jindu3")
        }
        self.navigationController?.pushViewController(readVC, animated: true)
        
    }
    
    func addFirstText() ->NSString {
        let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("消防安全技术综合能力", ofType: "txt")!)
        let str = NSString (data: data!, encoding: NSUTF8StringEncoding)as! String
        return str
    }
    func addSecondText() ->NSString {
        let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("消防安全技术实务", ofType: "txt")!)
        let str = NSString (data: data!, encoding: NSUTF8StringEncoding)as! String
        return str
    }
    func addThirdText() ->NSString {
        let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("消防安全案例", ofType: "txt")!)
        let str = NSString (data: data!, encoding: NSUTF8StringEncoding)as! String
        return str
    }
    func lastTimeReading(){
        print(123)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        myTableView.reloadData()
    }
  

}

