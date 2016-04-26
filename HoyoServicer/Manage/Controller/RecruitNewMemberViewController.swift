//
//  RecruitNewMemberViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 1/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class RecruitNewMemberViewController: UIViewController {
//分享内容
    
    @IBOutlet weak var contanct: UITextView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var navBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.bringSubviewToFront(navBarView)
        contanct.layer.cornerRadius = 10
        contanct.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    convenience  init() {
        var nibNameOrNil = String?("RecruitNewMemberViewController")
        
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
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bringSubviewToFront(navBarView)
        self.view.sendSubviewToBack(backImageView)
    }
   
    @IBAction func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.contanct.resignFirstResponder()
    }

}
