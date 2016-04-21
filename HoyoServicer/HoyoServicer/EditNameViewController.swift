//
//  EditNameViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 21/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class EditNameViewController: UIViewController {

    @IBOutlet weak var editName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
self.title = "名字"
        setNavigationItem("取消", selector: "doBack", isRight: false)
       setNavigationItem("保存", selector: "doBack", isRight: true)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.grayColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        editName.resignFirstResponder()
    }
  

}
