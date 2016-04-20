//
//  RobListMianViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 11/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

var  isShow :Bool = true
class RobListMianViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView  :UITableView! = nil
     var currentData:NSMutableDictionary?
     var segSelectedIndex = 0
    //let segCon : UISegmentedControl = UISegmentedControl()
    lazy var segCon : UISegmentedControl = {
        let segCon = UISegmentedControl (frame: CGRectMake(60, 10, WIDTH_SCREEN-60*2, 35))
          segCon.tintColor = COLORRGBA(58, g: 58, b: 58, a: 1)
        segCon.insertSegmentWithTitle("按时间排序", atIndex: 0, animated: true)
        segCon.insertSegmentWithTitle("按距离排序", atIndex: 1, animated: true)
        return segCon
    }()
    @IBAction func back() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    var   IsSelectLeft  = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segCon.frame = CGRectMake(60, 10, WIDTH_SCREEN-60*2, 35)
self.automaticallyAdjustsScrollViewInsets = true
     
  tableView = UITableView(frame: CGRectMake(0, 64, WIDTH_SCREEN, HEIGHT_SCREEN-HEIGHT_NavBar))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        
        tableView.rowHeight = UITableViewAutomaticDimension
            tableView.registerNib(UINib(nibName: "RobListViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "RobListViewCell")
       self.view.addSubview(tableView)
        segCon.selectedSegmentIndex = 0
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RobListViewCell") as! RobListViewCell
    if (IsSelectLeft ) {
        cell.message.hidden = false
        
    }
    else
    {
      cell.message.hidden = true
    }
    
        // Configure the cell...
        cell.selectionStyle = .None
        return cell
    }
    
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        print("进来了")
        
        let view = UIView(frame: CGRectMake(0, 0, WIDTH_SCREEN, 60))
       

        
        
        
        view.addSubview(segCon)
        segCon.addTarget(self, action: #selector(RobListMianViewController.controlPressed(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(view)
        view.backgroundColor = UIColor.whiteColor()
        return view
    }
    
    func controlPressed(segCon :UISegmentedControl){
        if segCon.selectedSegmentIndex != segSelectedIndex{
            
        
        
        IsSelectLeft = (segCon.selectedSegmentIndex==0)
        print(IsSelectLeft)
       
            //isShow = true
            self.tableView.reloadData()
      segSelectedIndex = segCon.selectedSegmentIndex
        }
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let detail = ListsDetailViewController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
}
