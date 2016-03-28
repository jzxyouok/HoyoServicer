//
//  LoginViewController.swift
//  OznerServer
//
//  Created by 赵兵 on 16/2/25.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    /// 变量
    var firstAppear=true//是不是第一次打开
    /// 视图类
    var guardView:UIView!//首次登录导航视图
    var loginView:UIView!//登录视图
    var registView:UIView!//注册视图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            firstAppear = false
            NetworkManager.defaultManager?.POST("AppLogin", parameters: ["phone":"15026981614","password":"123456"], success: { (dataDic) in
                    print(dataDic)
                }, failure: { (error) in
                    print(error)
            })
//            User.loginWithCookiesAndCacheInStorage(
//                success: {
//                    [weak self] user in
//                    User.currentUser = user
                    self.presentMainViewController()
//                },
//                failure: nil)
        }
    }

    func presentMainViewController() {
        appDelegate.mainViewController = MainViewController()
        appDelegate.mainViewController.modalTransitionStyle = .CrossDissolve
        presentViewController(appDelegate.mainViewController, animated: true, completion: nil)
        
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
