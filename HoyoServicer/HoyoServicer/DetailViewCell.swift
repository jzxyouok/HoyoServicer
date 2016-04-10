//
//  DetailViewCell.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 30/3/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
   //头像
    @IBOutlet weak var headView: UIImageView!
    
 
    //抢单
    @IBOutlet weak var robBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headView.layer.masksToBounds = true
        headView.layer.cornerRadius = 35
        headView.layer.borderWidth = 3.0
        headView.layer.borderColor = UIColor.whiteColor().CGColor
        
        robBtn.layer.masksToBounds = true
        robBtn.layer.cornerRadius = 6
      
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
