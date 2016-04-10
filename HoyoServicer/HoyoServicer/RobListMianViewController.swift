//
//  RobListMianViewController.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 30/3/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class RobListMianViewController: UIViewController {

    @IBOutlet  var segCon: UISegmentedControl!
    
    var robOneList: RobListOneController!
    var robTwoList: RobListOneController!
    
    
    override func viewDidLoad() {
        
       
        super.viewDidLoad()
        //设置左边
       
      setNavigationItem("back.png", selector: "doBack", isRight: false)
        
//设置右边
        setNavigationItem("上海", selector: nil, isRight: true)
        self.navigationItem.rightBarButtonItem?.enabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.title = "抢单"
        
  
     initSegmentedCon()
        
    
    }
    
    
  
    
    func initSegmentedCon()
    {
    
     //默认选择第一个
        segCon.selectedSegmentIndex = 0
   segCon.tintColor  = COLORRGBA(58, g: 58, b: 58, a: 1)
        
        robOneList = RobListOneController()
        robTwoList = RobListOneController()
      
        segCon.selectedSegmentIndex = 0
        
        self.addChildViewController(robOneList)
        self.addChildViewController(robTwoList)
        self.view.addSubview(robOneList.tableView)
        self.view.addSubview(robTwoList.tableView)
        
        change(segCon)
    }

//   override func awakeFromNib(){
//    super.awakeFromNib()
//    segCon.selectedSegmentIndex = 0
//    change(segCon)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func change(sender: AnyObject) {
 
        
   
        
        switch self.segCon.selectedSegmentIndex {
            
            // 0 , 1页面切换
        case 0:
         
        
          self.robOneList.tableView.hidden = false
          self.robOneList.tableView.snp_makeConstraints(closure: { [weak self] make in
            if let srtrongself=self
            {
                make.edges.equalTo(srtrongself.view).inset(UIEdgeInsetsMake(60, 0, 0, 0))
            }
            
          })
        self.robTwoList.tableView.hidden = true
        case 1:
          
            
            self.robTwoList.tableView.hidden = false
            self.robTwoList.tableView.frame = CGRectMake(0, 60, WIDTH_SCREEN, HEIGHT_SCREEN - 60)
            self.robOneList.tableView.hidden = true
            
        
        default: break
            
        }
      
    
    }
  
}
