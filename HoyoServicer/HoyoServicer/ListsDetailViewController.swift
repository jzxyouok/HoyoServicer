//
//  ListsDetailViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 11/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class ListsDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBAction func back() {
        self.navigationController?.navigationBar.hidden = false
        UIApplication.sharedApplication().statusBarHidden = false
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    var tableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        hideNavBarAndStatus()
        
       initView()
        tableView.estimatedRowHeight = 667
        
        tableView.rowHeight = UITableViewAutomaticDimension
// self.navigationController?.navigationBar.setBackgroundImage(UIImage color, forBarMetrics: <#T##UIBarMetrics#>)
        User.UploadImages("", success: {
            print("")
            }) { (error) in
                print(error)
        }
     
    }
    
    
    //设置navBar
    @IBOutlet weak var navBar: UIView!
    
    
    func initView(){
        // 初始化tableView的数据
        self.tableView=UITableView(frame:CGRectMake(0, 0, WIDTH_SCREEN,HEIGHT_SCREEN),style:UITableViewStyle.Plain)
        // 设置tableView的数据源
        self.tableView!.dataSource=self
        // 设置tableView的委托
        self.tableView!.delegate = self
        //
        self.tableView.registerNib(UINib(nibName:"DetailViewCell", bundle:nil), forCellReuseIdentifier:"DetailViewCell")
        self.view.addSubview(self.tableView!)
       // self.tableView.bounds =  CGRectMake(0, 6, WIDTH_SCREEN, HEIGHT_SCREEN)
       // self.tableView.bounds = CGRectMake(0, -64, WIDTH_SCREEN, HEIGHT_SCREEN)

       
        self.navBar.alpha  = 0.26
        self.view.bringSubviewToFront(navBar)
    }
  func   hideNavBarAndStatus(){
    
    UIApplication.sharedApplication().statusBarHidden = true
    self.navigationController?.navigationBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailViewCell") as! DetailViewCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.grayColor()
        cell.frame = CGRectMake(0, -64, WIDTH_SCREEN, cell.frame
            .size.height)
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    let y = self.tableView.bounds.origin.y
        
    
        if  y <= 0{
            self.navBar.alpha = 0.26
           
        }
        else{
      self.navBar.alpha = (self.tableView.bounds.origin.y+60)/230
        
        print(self.navBar.alpha)
        }
    }

}
