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
  
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    convenience  init() {
        var nibNameOrNil = String?("MyTeamTableViewController")
        
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

  
}
