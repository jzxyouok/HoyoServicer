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
        
        let c1=HomeTableViewController()
        c1.tabBarItem.title="首页"
        c1.tabBarItem.image=UIImage(named: "HomeIcon")
        c1.tabBarItem.selectedImage=UIImage(named: "HomeIcon_on")
        c1.tabBarItem.badgeValue=nil
        let nav1=UINavigationController(rootViewController: c1)
        nav1.navigationBar.loadBlackBgBar()
        let c2=ManageTableViewController()
        c2.tabBarItem.title="管理"
        c2.tabBarItem.image=UIImage(named: "ManageIcon")
        c2.tabBarItem.selectedImage=UIImage(named: "ManageIcon_on")
        c2.tabBarItem.badgeValue=nil
        let nav2=UINavigationController(rootViewController: c2)
        nav2.navigationBar.loadBlackBgBar()
        let c3=NewsTableViewController()
        c3.tabBarItem.title="消息"
        c3.tabBarItem.image=UIImage(named: "NewsIcon")
        c3.tabBarItem.selectedImage=UIImage(named: "NewsIcon_on")
        c3.tabBarItem.badgeValue="5"
        let nav3=UINavigationController(rootViewController: c3)
        nav3.navigationBar.loadBlackBgBar()
        let c4=MyCenterTableViewController()
        c4.tabBarItem.title="我的"
        c4.tabBarItem.image=UIImage(named: "MyCenterIcon")
        c4.tabBarItem.selectedImage=UIImage(named: "MyCenterIcon_on")
        c4.tabBarItem.badgeValue=nil
        let nav4=UINavigationController(rootViewController: c4)
        nav4.navigationBar.loadBlackBgBar()
        
        self.viewControllers=[nav1,nav2,nav3,nav4]
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