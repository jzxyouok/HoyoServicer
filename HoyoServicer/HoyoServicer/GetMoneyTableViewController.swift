//
//  GetMoneyTableViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 12/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class GetMoneyTableViewController: UITableViewController,GetMoneyCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "GetMoneyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "GetMoneyCell")
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
    setNavigationItem("back.png", selector: Selector("doBack"), isRight: false)
        
    self.title = "提现"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         self.navigationController?.navigationBarHidden=false
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
        
        return HEIGHT_SCREEN-HEIGHT_NavBar
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GetMoneyCell") as! GetMoneyCell

        // Configure the cell...
    cell.selectionStyle = .None
        cell.delegate = self
        return cell
    }
 
    func pushToDetailView() {
    let getMoneyDetail = GetMoneyDetailTableViewController()
        
        self.navigationController?.pushViewController(getMoneyDetail, animated: true)
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