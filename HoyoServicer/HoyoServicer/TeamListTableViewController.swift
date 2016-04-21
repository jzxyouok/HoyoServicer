//
//  TeamListTableViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 20/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class TeamListTableViewController: UITableViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的团队"
        tableView.estimatedRowHeight = 60
        
        tableView.rowHeight = UITableViewAutomaticDimension
        self.automaticallyAdjustsScrollViewInsets=false
        //tableView.separatorStyle=UITableViewCellSeparatorStyle.None
      
//        teamListCell?.selectionStyle=UITableViewCellSelectionStyle.None
        tableView.registerNib(UINib(nibName: "TeamListTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TeamListTableViewCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 20
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      

        
        let cell = tableView.dequeueReusableCellWithIdentifier("TeamListTableViewCell") as! TeamListTableViewCell
        
        //设置点击颜色不变
        cell.selectionStyle = .None
        
        
        
        return cell    }
 

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
