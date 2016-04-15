//
//  RobListViewCellTableViewCell.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 28/3/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit
//protocol RobListViewCellDelegate {
//    func isShowMessage()
//}
   

class RobListViewCell : UITableViewCell {
    var  tableView : RobListOneController?
    //用户地址
    @IBOutlet weak var address: UILabel!
    //用户反馈信息
    @IBOutlet weak var message: UILabel!
    //头像
    @IBOutlet weak var headImage: UIImageView!
    //背景
    @IBOutlet weak var backView: UIView!
    var IsShow = true{
        didSet{
            message.hidden = !IsShow
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
//
//        if  isShow  {
//            
//            print("显示")
//            message.snp_makeConstraints(closure: { (make) in
//                make.size.equalTo(CGSizeMake(50,21))
//            })
//        }
//        else
//        {
//            print("隐藏")
//       message.snp_makeConstraints(closure: { (make) in
//                make.size.equalTo(CGSizeMake(50,0))
//            })
//            
//        }

 
      
    }


    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }
    
}
