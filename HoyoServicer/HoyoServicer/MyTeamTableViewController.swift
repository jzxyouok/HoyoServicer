//
//  MyTeamTableViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/19.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class MyTeamTableViewController: UITableViewController {

    var myTeamCell:MyTeamCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.estimatedRowHeight = 100
        
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title="我的团队"
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        myTeamCell=NSBundle.mainBundle().loadNibNamed("MyTeamCell", owner: self, options: nil).last as? MyTeamCell
        myTeamCell?.selectionStyle=UITableViewCellSelectionStyle.None
        //导航条右边按钮
        let rightBarButton = UIBarButtonItem(title: "成员列表", style: .Plain, target: self, action: #selector(ToMemberList))
        self.navigationItem.rightBarButtonItem=rightBarButton
    }
    //跳转到成员列表
    func ToMemberList() {
       let teamList  = TeamListTableViewController()
        
        self.navigationController?.pushViewController(teamList, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        //self.tabBarController?.tabBar.hidden=true
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

//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return max(HEIGHT_SCREEN-64, 780)
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        return myTeamCell!
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