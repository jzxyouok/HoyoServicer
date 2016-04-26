//
//  GetMoneyCell.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 12/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

protocol GetMoneyCellDelegate {
    func pushToDetailView()
}

class GetMoneyCell: UITableViewCell {
    var delegate :GetMoneyCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //全部提现
    @IBAction func getAllMoney() {
        
        
    }
    
    //提现
    @IBAction func getMoney() {
        delegate?.pushToDetailView()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
