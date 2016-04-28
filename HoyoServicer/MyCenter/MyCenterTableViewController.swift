//
//  MyCenterTableViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/28.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class MyCenterTableViewController: UITableViewController,MyCenterTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="我的"
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.registerNib(UINib(nibName: "MyCenterTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MyCenterTableViewCell")
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CurrentUserDidChange), name: CurrentUserDidChangeNotificationName, object: nil)
    
    }
    
    func CurrentUserDidChange() {
        self.tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return HEIGHT_SCREEN-HEIGHT_NavBar-HEIGHT_TabBar
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCenterTableViewCell", forIndexPath: indexPath) as! MyCenterTableViewCell
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        cell.delegate=self
        
        if User.currentUser?.headimageurl != nil
        {
            
            cell.headImg.image=UIImage(data: (User.currentUser?.headimageurl)!)

        }
        
        cell.phone.text=User.currentUser?.mobile
        cell.jobNo.text="(工号:"+(User.currentUser?.id)!+")"
        cell.name.text=User.currentUser?.name
        return cell
    }
    /**
     MyCenterTableViewCellDelegate 方法
     
     - parameter Whitch: 1...6,从上到下
     */
    func ToDetailController(Whitch: Int) {
        switch Whitch {
        case 1:
            self.navigationController?.pushViewController(UserInfoViewController(), animated: true)
            print("查看资料")
        case 2:
            presentViewController(AuthenticationController(dissCall: nil), animated: true, completion: nil)
        case 3:
            self.navigationController?.pushViewController(MyExamViewController(), animated: true)
            print("我的考试")
        case 4:
            self.navigationController?.pushViewController(SelectIDTableViewController(), animated: true)
            
            print("我的网点")
        case 5:
            self.navigationController?.pushViewController(MyEvaluatTableViewController(), animated: true)
            print("我的评价")
        case 6:
            
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            print("设置")
        default:
            break
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
