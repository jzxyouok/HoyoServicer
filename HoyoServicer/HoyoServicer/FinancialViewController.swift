//
//  FinancialViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 3/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class FinancialViewController: UIViewController{
//返回
    @IBAction func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    var backControl :UIControl!
    @IBOutlet weak var seg: UISegmentedControl!
    lazy  var selectTimeView :UIDatePicker = {
    
        let  picker = UIDatePicker()
      picker.datePickerMode = UIDatePickerMode.Date
   
        
      
        return  picker
    
    }()
    //选择时间
    @IBOutlet weak var selectTimeBtn: UIButton!
    //选择查看时间
    @IBAction func selectTime() {
        
     


        self.selectTimeView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.selectTimeView)
        self.backControl.frame = self.view.bounds
      self.view.bringSubviewToFront(backControl)
        
     self.view.bringSubviewToFront(selectTimeView)
        selectTimeView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(HEIGHT_SCREEN*0.28, 20, HEIGHT_SCREEN*0.28, 20))
        }
        selectTimeView.addTarget(self, action: #selector(FinancialViewController.select as (FinancialViewController) -> () -> ()), forControlEvents: .ValueChanged)

        
    }
   

    func select(){
        
             let select = selectTimeView.date
        let dataFormatter = NSDateFormatter()
        self.selectTimeView.datePickerMode = .Date
        dataFormatter.dateFormat="yyyy-MM-dd"
        let mon = dataFormatter.stringFromDate(select)
       var arr = NSArray()
        arr = mon.componentsSeparatedByString("-")
        print(arr[1])
            selectTimeBtn.titleLabel?.text = (arr[1] as! String)+"月"
        
    }
    
    
    var  seg_Detail : DetailFinancialTableViewController!
    
    var seg_Income : DetailFinancialTableViewController!
    
    var seg_Expend :DetailFinancialTableViewController!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
          addBackControl()
              seg.tintColor = COLORRGBA(58, g: 58, b: 58, a: 1)
        seg.addTarget(self, action: "segChange:", forControlEvents: .ValueChanged)
        //明细
seg_Detail = DetailFinancialTableViewController()
        //收入
seg_Income = DetailFinancialTableViewController()
      //支出
seg_Expend = DetailFinancialTableViewController()
        seg.selectedSegmentIndex = 0
        
      
        
        self.addChildViewController(seg_Detail)
       
        self.view.addSubview(seg_Detail.tableView)
        
        self.addChildViewController(seg_Income)
        
        self.view.addSubview(seg_Income.tableView)
        
        self.addChildViewController(seg_Expend)
        
        self.view.addSubview(self.seg_Expend.tableView)
          self.segChange(seg)


        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    
    }
    
    //添加选择时间的时候的背景效果
    func addBackControl() {
        
        if backControl == nil {
            let frame = CGRectZero
            backControl = UIControl(frame: frame)
            backControl.backgroundColor = UIColor.blackColor()
            backControl.alpha = 0.5
         
            backControl.addTarget(self, action: #selector(FinancialViewController.clickBackControl), forControlEvents: .TouchUpInside);
            
            
            self.view.addSubview(self.backControl)
            self.view.sendSubviewToBack(self.backControl)
            
        }
    }
 
    func clickBackControl(){
    
backControl.frame = CGRectZero

        selectTimeView.snp_removeConstraints()
        selectTimeView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(HEIGHT_SCREEN/2, WIDTH_SCREEN, HEIGHT_SCREEN, WIDTH_SCREEN/2))
        }
    }
    
    override func  awakeFromNib() {
        print("第一次")
    }
    func segChange(segCon : UISegmentedControl)
    {

    
        
        
        if (segCon.selectedSegmentIndex == 0) {
            //[self.view addSubview:self.one.tableView];
            self.seg_Detail.tableView.hidden = false

            self.seg_Detail.tableView.snp_makeConstraints(closure: { [weak self] make in
              if let  strongSelf = self{
                make.edges.equalTo((strongSelf.view)!).inset(UIEdgeInsetsMake(180, 0, 0, 0))
                }
                //make.edges.equalTo(srtrongself.view).inset(UIEdgeInsetsMake(60, 0, 0, 0))
            })
            
                    self.seg_Income.tableView.hidden = true
            self.seg_Expend.tableView.hidden = true
            
          
        }
        else if (segCon.selectedSegmentIndex == 1){
            
            //        [self.view addSubview:self.two.tableView];
                      self.seg_Income.tableView.hidden = false
            self.seg_Income.tableView.frame = CGRectMake(0, 180, WIDTH_SCREEN, HEIGHT_SCREEN - 180)
            self.seg_Detail.tableView.hidden = true
            self.seg_Expend.tableView.hidden = true
            
        }
        else if (segCon.selectedSegmentIndex == 2){
            //        [self.view addSubview:self.three.tableView];
       
            self.seg_Expend.tableView.hidden = false
            self.seg_Expend.tableView.frame = CGRectMake(0, 180, WIDTH_SCREEN  , HEIGHT_SCREEN - 180)
            self.seg_Detail.tableView.hidden = true
            self.seg_Income.tableView.hidden = true
            
        }

        
    }
    func disappear() {
        
        backControl.frame = CGRectZero
        self.selectTimeView.removeFromSuperview()
    }
}
