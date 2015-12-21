//
//  ReadViewController.swift
//  zhucexiaofang
//
//  Created by shanghongzhi on 15/12/7.
//  Copyright © 2015年 shz. All rights reserved.
//

import UIKit


class ReadViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mainTextView: UITextView!
    @IBOutlet var mySlider: UISlider!
    @IBOutlet var buttomView: UIView!
    var textString = NSString()
    var number = 0.0
    var name = NSString()
    var mark = 0
    var myString = String()
    let userDef = NSUserDefaults.standardUserDefaults()
    var numString = AnyObject?()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainTextView.layoutManager.allowsNonContiguousLayout = false
//        mainTextView.scrollRangeToVisible(NSMakeRange(<#T##loc: Int##Int#>, <#T##len: Int##Int#>))
        mainTextView.text = textString as String
        mainTextView.editable = false
        mainTextView.font = UIFont.systemFontOfSize(17)
        mainTextView.backgroundColor = UIColor.grayColor()
        mainTextView.pagingEnabled = true
        mainTextView.delegate = self
        nameLabel.text = name as String
        mainTextView.bounces = false
        
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1
        mySlider.value = Float(self.number)
        mySlider.addTarget(self, action: "siliderValueChange", forControlEvents: UIControlEvents.ValueChanged)
        
        let tap = UITapGestureRecognizer.init(target: self, action: "hiddenAppear")
        self.mainTextView.addGestureRecognizer(tap)
        
        let leftButton = UIBarButtonItem.init(image: UIImage.init(named:"返回按钮@2x.png"), style: UIBarButtonItemStyle.Done, target: self, action: "getBack")
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem.init(image: UIImage.init(named: "分章节.png"), style: UIBarButtonItemStyle.Done, target: self, action: "getZhangJie")
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    func siliderValueChange(){
        
        let range = Float(mySlider.value) * Float(mainTextView.contentSize.height)
        mainTextView.scrollRectToVisible(CGRectMake(0, CGFloat(range),  mainTextView.frame.width, mainTextView.frame.height), animated: true)
        let page = range / Float(mainTextView.contentSize.height)
        percentageLabel.text = NSString.init(format: "%.2f", page)as String
        
    }
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        buttomView.hidden = true
        if numString == nil {
            numString = "0.00"
            return
        }
        let range = Float(numString as! String)! * Float(mainTextView.contentSize.height)
        mainTextView.scrollRectToVisible(CGRectMake(0, CGFloat(range), mainTextView.frame.width, mainTextView.frame.height), animated: true)
        percentageLabel.text = numString as? String
        switch self.mark {
        case 0: userDef.removeObjectForKey("jindu1")
        case 1: userDef.removeObjectForKey("jindu2")
        default:userDef.removeObjectForKey("jindu3")
        }
        userDef.synchronize()

    }
    func hiddenAppear(){
        if self.navigationController?.navigationBarHidden == true && buttomView.hidden == true{
            self.navigationController?.navigationBarHidden = false
            buttomView.hidden = false
            
        }else{
            self.navigationController?.navigationBarHidden = true
            buttomView.hidden = true
        }
    }
    func getBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func getZhangJie(){
    
        
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let percentage = (mainTextView.contentSize.height / mainTextView.frame.size.height) + 1
        let currentPage = percentage * (mainTextView.contentOffset.y / mainTextView.contentSize.height)
        self.number = Double(currentPage/percentage)
        mySlider.value = Float(self.number)
        percentageLabel.text = NSString.init(format: "%.2f",(number)) as String
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        myString = percentageLabel.text!
        switch self.mark {
        case 0: userDef.setObject(myString, forKey: "jindu1")
        case 1: userDef.setObject(myString, forKey: "jindu2")
        default:userDef.setObject(myString, forKey: "jindu3")
        }
        userDef.synchronize()
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


