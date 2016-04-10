//
//  BoundBankCardViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 2/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class BoundBankCardViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    initView()
       }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    convenience  init() {
        var nibNameOrNil = String?("DetailOfNewsViewController")
        
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
    
    func initView(){
        // 初始化tableView的数据
        self.tableView=UITableView(frame:CGRectMake(0, HEIGHT_NavBar, WIDTH_SCREEN,HEIGHT_SCREEN-HEIGHT_NavBar),style:UITableViewStyle.Plain)
        // 设置tableView的数据源
        self.tableView!.dataSource=self
        // 设置tableView的委托
        self.tableView!.delegate = self
        //
       self.tableView.registerNib(UINib(nibName:"BoundCarViewCell", bundle:nil), forCellReuseIdentifier:"BoundCarViewCell")
        self.view.addSubview(self.tableView!)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    func  tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView .dequeueReusableCellWithIdentifier("BoundCarViewCell") as! BoundCarViewCell
        
        
    
        return cell
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


  //返回
    @IBAction func back() {
       self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //添加银行卡
    @IBAction func addCards(sender: AnyObject) {
        
        let addCar = AddCarViewController()
        
        self.navigationController?.pushViewController(addCar, animated: true)
    }
    
    //删除一行
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
   
       
    }
    //选择一行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let alert = UIAlertView()
        alert.title = "提示"
        
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    
    


}
