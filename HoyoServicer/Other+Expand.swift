//
//  Other+Expand.swift
//  OznerServer
//
//  Created by 赵兵 on 16/3/5.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import Foundation
/**
 判断是不是空或null
 */
func MSRIsNilOrNull(object: AnyObject?) -> Bool {
    return object == nil || object is NSNull
    
}
extension UINavigationBar{
    //黑底白字
    func loadBlackBgBar() {
        self.setBackgroundImage(UIImage(named: "blackImgOfNavBg"), forBarMetrics: UIBarMetrics.Default)
        self.shadowImage =  UIImage(named: "blackImgOfNavBg")
       self.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.whiteColor()]
    }
    //
}