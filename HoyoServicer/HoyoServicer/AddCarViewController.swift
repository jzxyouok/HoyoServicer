//
//  AddCarViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 2/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class AddCarViewController: UIViewController,UITextFieldDelegate {

//持卡人
    @IBOutlet weak var cardOwner: UITextField!
    
    //持卡人卡号
    @IBOutlet weak var cardNumber: UITextField!
    
    //下一步

    

    @IBAction func next(sender: AnyObject) {
        
        if !cardNumber.text!.isAllNumber && (cardNumber.text! as NSString).length == 19{
            
           
        }
        else{
//            let alertView=UNAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入")
//            alertView.addButton("确定", action: {
//            })
//            alertView.show()
            let alert=UIAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确认")
            alert.show()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardOwner.placeholder = "持卡人姓名"
        cardNumber.placeholder  = "持卡人银行卡号"
cardOwner.delegate = self
        cardNumber.delegate = self
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    convenience  init() {
        var nibNameOrNil = String?("DetailOfNewsViewController")
        
        //考虑到xib文件可能不存在或被删，故加入判断
        
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil
            
        {
            nibNameOrNil = nil
            
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
// 
//        if (textField.tag == 10 && string.isAllNumber && (string as NSString).length != 19 ){
//            let alertView=UNAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入")
//            alertView.addButton("确定", action: {
//            })
//            alertView.show()
//           
//        }
//        return true
//    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        if [10].contains(textField.tag) && !string.isAllNumber {
            return false
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if !( (textField.text! as NSString).length == 19 ){
          //  let alertView=UNAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入")
            let alert=UIAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            alert.show()
            
        }
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if cardNumber.text != nil {
            
        
        if (  (cardNumber.text! as NSString).length != 19 ){
//            let alertView=UNAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入")
            let alert=UIAlertView(title: "", message: "您输入的银行卡号数字个数不正确，请重新输入", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            alert.show()
            
        }
        cardNumber.resignFirstResponder()
        }}

}
