//
//  RobListViewCellTableViewCell.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 28/3/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class RobListViewCell: UITableViewCell {

    //用户地址
    @IBOutlet weak var address: UILabel!
    //用户反馈信息
    @IBOutlet weak var message: UILabel!
    //头像
    @IBOutlet weak var headImage: UIImageView!
    //背景
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
 
      
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }
    
}
