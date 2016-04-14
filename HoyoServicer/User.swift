//
//  User.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/5.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import Foundation
import CoreData

let UserDefaultsUserTokenKey = "usertoken"
let UserDefaultsUserIDKey = "userid"

class User: DataObject {

// Insert code here to add functionality to your managed object subclass

    static var currentUser: User? = nil {
        didSet {
            //NSNotificationCenter.defaultCenter().postNotificationName(CurrentUserDidChangeNotificationName, object: nil)
        }
    }
    //检查是否自动登录
    class func loginWithLocalUserInfo(success success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        
        let UserToken = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsUserTokenKey) as? NSString
        let UserID = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsUserIDKey) as? NSString
        var error: NSError? = nil
        if UserToken == nil || UserID==nil  {
            let userInfo = [
                NSLocalizedDescriptionKey: "本地usertoken或UserID不存在不存在",
                NSLocalizedFailureReasonErrorKey: ""
            ]
            failure?(NSError(
                domain: NetworkManager.defaultManager!.website,
                code: NetworkManager.defaultManager!.tokenFailCode,
                userInfo: userInfo))
        } else {
            if let user = DataManager.defaultManager?.fetch("User", ID: UserID!, error: &error) as? User {
                success?(user)
            } else {
                let userInfo: NSMutableDictionary = [
                    NSLocalizedDescriptionKey: "数据库用户信息不存在",
                    NSLocalizedFailureReasonErrorKey: "",
                    NSLocalizedRecoverySuggestionErrorKey: ""
                ]
                if error != nil {
                    userInfo[NSUnderlyingErrorKey] = error
                }
                failure?(NSError(
                    domain: NetworkManager.defaultManager!.website,
                    code: 404,
                    userInfo: userInfo as [NSObject: AnyObject]))
            }
        }
    }
    //  /FamilyAccount/ResetPassword     APP忘记/修改密码
    class func ResetPassword(phone: String,code: String,password: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("ResetPassword",
                                            parameters: [
                                                "phone": phone,
                                                "code": code,
                                                "password": password
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //获取验证码
    class func SendPhoneCode(mobile: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("SendPhoneCode",
                                            parameters: [
                                                "mobile": mobile,
                                                "order": "register",
                                                "scope":"engineer"
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //验证验证码
    class func AppChenkPhone(phone: String,code: String, success: ((String) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("AppChenkPhone",
                                            parameters: [
                                                "phone": phone,
                                                "code": code
            ],
                                            success: {
                                                data in
                                                success!(data.objectForKey("msg") as! String)
            },
                                            failure: failure)
    }
    // /FamilyAccount/AppRegister       APP端注册用户
    class func AppRegister(realname: String, cardid: String, password: String, success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("AppRegister",
                                            parameters: [
                                                "realname": realname,
                                                "cardid": cardid,
                                                "password": password,
                                                "scope":"engineer"
            ],
                                            success: {
                                                data in
                                                print(data)
                                                let user = User.cachedObjectWithID(data.objectForKey("data") as! NSString)//userId
                                                user.usertoken = data.objectForKey("msg") as? String//usertoken
                                                
                                                let defaults = NSUserDefaults.standardUserDefaults()
                                                defaults.setObject(data.objectForKey("msg"), forKey: UserDefaultsUserTokenKey)
                                                defaults.setObject(data.objectForKey("data"), forKey: UserDefaultsUserIDKey)
                                                defaults.synchronize()
                                                loginWithLocalUserInfo(success: success, failure: failure)
            },
                                            failure: failure)
    }
    //登录
    class func loginWithPhone(phone: String, password: String, success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.clearCookies()
        NetworkManager.defaultManager!.POST("AppLogin",
                                            parameters: [
                                                "phone": phone,
                                                "password": password
            ],
                                            success: {
                                                data in
                                                
                                                let tmpUserID=data.objectForKey("data") as! NSNumber
                                                let user = User.cachedObjectWithID(tmpUserID.stringValue)
                                                user.userid =  tmpUserID.stringValue//userId
                                                user.usertoken = data.objectForKey("msg") as? String//usertoken
                                                
                                                let defaults = NSUserDefaults.standardUserDefaults()
                                                defaults.setObject(user.usertoken, forKey: UserDefaultsUserTokenKey)
                                                defaults.setObject(tmpUserID.stringValue, forKey: UserDefaultsUserIDKey)
                                                defaults.synchronize()
                                                loginWithLocalUserInfo(success: success, failure: failure)
                                                
            },
                                            failure: failure)
    }
    //获取当前用户信息
    class func GetCurrentUserInfo(success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetCurrentUserInfo",
                                            parameters: NSDictionary(),
                                            success: {
                                                data in
                                                print(data)
                                                let tmpData=data.objectForKey("data")
                                                let user = User.cachedObjectWithID((tmpData!.objectForKey("userid") as! NSNumber).stringValue)
                                                user.city=(tmpData!.objectForKey("city") as? String) ?? ""
                                                user.country=(tmpData!.objectForKey("country") as? String) ?? ""
                                                user.headimageurl=(tmpData!.objectForKey("headimageurl") as? String) ?? ""
                                                user.language=(tmpData!.objectForKey("language") as? String) ?? ""
                                                user.mobile=(tmpData!.objectForKey("mobile") as? String) ?? ""
                                                user.name=(tmpData!.objectForKey("name") as? String) ?? ""
                                                user.openid=(tmpData!.objectForKey("openid") as? String) ?? ""
                                                user.province=(tmpData!.objectForKey("province") as? String) ?? ""
                                                user.scope=(tmpData!.objectForKey("scope") as? String) ?? ""
                                                user.sex=(tmpData!.objectForKey("sex") as? String) ?? ""
                                        
                                                let tmpDic=tmpData!.objectForKey("GroupDetails")
                                                let object:NSData?
                                                do{
                                                    object = try? NSJSONSerialization.dataWithJSONObject(tmpDic!, options: NSJSONWritingOptions.PrettyPrinted)
                                                }
                                                
                                                user.groupdetails=object
                                                
                                                success!(user)
            },
                                            failure:
            failure
        )
    }
    
    
    //以下是未解析的借口
    
    
    
    //  /FamilyAccount/UpdateUserInfo    更新用户个人信息
    class func UpdateUserInfo(dataDic:NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("UpdateUserInfo",
                                            parameters:dataDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /Command/SendMessage             APP发送消息
    class func SendMessage(recvuserid: String, message: String,messagetype: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("SendMessage",
                                            parameters:[
                                                "recvuserid":recvuserid,
                                                "message":message,
                                                "messagetype":messagetype
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /Command/BingJgNotifyId          绑定极光通知ID
    class func BingJgNotifyId(notifyid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("BingJgNotifyId",
                                            parameters:[
                                                "notifyid":notifyid
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /Upload/Images                   上传图片接口
    class func UploadImages(order: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("UploadImages",
                                            parameters:[
                                                "order":order
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /AppInterface/GetOrderList       分页获取可抢订单列表
    class func GetOrderList(paramDic: NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetOrderList",
                                            parameters:paramDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /AppInterface/RobOrder           抢订单
    class func RobOrder(orderid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("RobOrder",
                                            parameters:[
                                                "orderid":orderid
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /AppInterface/FinshOrder         提交完成订单
    class func FinshOrder(orderid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("FinshOrder",
                                            parameters:[
                                                "orderid":orderid
            ],
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //  /AppInterface/GetOrderDetails获取订单详细信息
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    
}
