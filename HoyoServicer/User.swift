//
//  User.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/5.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import Foundation
import CoreData


class User: DataObject {

// Insert code here to add functionality to your managed object subclass

    static var currentUser: User? = nil {
        didSet {
            //NSNotificationCenter.defaultCenter().postNotificationName(CurrentUserDidChangeNotificationName, object: nil)
        }
    }
    //获取验证码
    class func SendPhoneCode()
    {}
    //登录
    class func AppChenkPhone()
    {}
    class func AppRegister(realname: String, cardid: String, password: String,scope:String, success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("AppRegister",
                                            parameters: [
                                                "realname": realname,
                                                "cardid": cardid,
                                                "password": password,
                                                "scope":scope
            ],
                                            success: {
                                                data in
                                                //注册成功处理
                                                //self.autologin(success: success, failure: failure)
            },
                                            failure: failure)
    }
    

    
    class func AppLogin(phone: String, password: String, success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.clearCookies()
        NetworkManager.defaultManager!.POST("AppLogin",
                                            parameters: [
                                                "phone": phone,
                                                "password": password
            ],
                                            success: {
                                                data in
                                                

            },
                                            failure: failure)
    }
}
