//
//  EditNameViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 21/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class EditNameViewController: UIViewController,UITextFieldDelegate {

    var tmpEditName = ""
    @IBOutlet weak var editName: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
self.title = "名字"
        
        editName.delegate = self
        setNavigationItem("取消", selector: #selector(UIViewController.doBack), isRight: false)
       setNavigationItem("保存", selector: #selector(UIViewController.doBack), isRight: true)
        self.navigationItem.rightBarButtonItem?.tintColor = COLORRGBA(50, g: 104, b: 51, a: 1)

    }
    override func doBack() {
        
        tmpEditName = self.editName.text!
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
   func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    print("修改中")
    
    self.navigationItem.rightBarButtonItem?.tintColor = COLORRGBA(47, g: 210, b: 50, a: 1)
        return  true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.editName.text =  tmpEditName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        editName.resignFirstResponder()
         self.navigationItem.rightBarButtonItem?.tintColor = COLORRGBA(50, g: 104, b: 51, a: 1)
    }
  

}
