//
//  ManageTableViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/28.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class ManageTableViewController: UITableViewController,ManageTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.registerNib(UINib(nibName: "ManageTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ManageTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=true
    }
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HEIGHT_SCREEN-HEIGHT_TabBar
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ManageTableViewCell", forIndexPath: indexPath) as!  ManageTableViewCell
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        cell.delegate=self
        // Configure the cell...

        return cell
    }
    /**
     ManageTableViewCellDelegate代理方法，从左到右，从上到下,button的tag分别为，1...8
     
     - parameter Tag: button的tag
     */
    func ButtonOfManageCell(Tag: Int) {
        switch Tag {
        case 1:
            
            let  financialManager = FinancialViewController()
            financialManager.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(financialManager, animated: true)
            break
        case 2:
            let getMoney = GetMoneyTableViewController()
            getMoney.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(getMoney, animated: true)
            break
        case 3:
            let boundBank = BoundBankCardViewController()
            boundBank.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(boundBank, animated: true)
            
            break
        case 4:
            
            let achievement = AchievementControllerViewController()
            achievement.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(achievement, animated: true)
            break
        case 5:
            let financialManager = FinancialViewController()
            financialManager.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(financialManager, animated: true)
            
            break
        case 6:
            let newMember = RecruitNewMemberViewController()
            newMember.hidesBottomBarWhenPushed  = true
            self.navigationController?.pushViewController(newMember, animated: true)
            break
            
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
