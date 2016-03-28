//
//  MainViewController.swift
//  OznerServer
//
//  Created by 赵兵 on 16/2/25.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c1=UIViewController()
        c1.view.backgroundColor=UIColor.grayColor()
        c1.tabBarItem.title="首页"
        c1.tabBarItem.image=UIImage(named: "first")
        c1.tabBarItem.badgeValue=nil
        
        let c2=UIViewController()
        c2.view.backgroundColor=UIColor.redColor()
        c2.tabBarItem.title="管理"
        c2.tabBarItem.image=UIImage(named: "second")
        c2.tabBarItem.badgeValue=nil
        
        let c3=UIViewController()
        c3.view.backgroundColor=UIColor.whiteColor()
        c3.tabBarItem.title="消息"
        c3.tabBarItem.image=UIImage(named: "first")
        c3.tabBarItem.badgeValue="5"
        
        let c4=UIViewController()
        c4.view.backgroundColor=UIColor.blueColor()
        c4.tabBarItem.title="我的"
        c4.tabBarItem.image=UIImage(named: "second")
        c4.tabBarItem.badgeValue=nil
        
        self.viewControllers=[c1,c2,c3,c4]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
