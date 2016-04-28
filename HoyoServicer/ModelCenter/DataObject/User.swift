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
let CurrentUserDidChangeNotificationName = "CurrentUserDidChangeNotificationName"

class User: DataObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    static var currentUser: User? = nil {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(CurrentUserDidChangeNotificationName, object: nil)
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
    class func SendPhoneCode(mobile: String,order: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("SendPhoneCode",
                                            parameters: [
                                                "mobile": mobile,
                                                "order": order,
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
                                                user.id =  tmpUserID.stringValue//userId
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
                                                var tmpUrl=(tmpData!.objectForKey("headimageurl") as? String) ?? ""
                                                if (tmpUrl != "")
                                                {
                                                    if (tmpUrl.containsString("http"))==false
                                                    {
                                                        tmpUrl=(NetworkManager.defaultManager?.website)!+tmpUrl
                                                    }
                                                    user.headimageurl=NSData(contentsOfURL: NSURL(string: tmpUrl)!)
                                                }
                                                
                                                user.language=(tmpData!.objectForKey("language") as? String) ?? ""
                                                user.mobile=(tmpData!.objectForKey("mobile") as? String) ?? ""
                                                user.name=(tmpData!.objectForKey("nickname") as? String) ?? ""
                                                user.openid=(tmpData!.objectForKey("openid") as? String) ?? ""
                                                user.province=(tmpData!.objectForKey("province") as? String) ?? ""
                                                user.scope=(tmpData!.objectForKey("scope") as? String) ?? ""
                                                let tmpSex=tmpData!.objectForKey("sex")
                                                if ((tmpSex?.isKindOfClass(NSNumber.classForCoder())) == true)
                                                {
                                                    user.sex=(tmpSex as! NSNumber).stringValue
                                                }
                                                else{
                                                    user.sex=""
                                                }
                                                let tmpDic=tmpData!.objectForKey("GroupDetails")
                                                if ((tmpDic?.isKindOfClass(NSDictionary.classForCoder())) == true)
                                                {
                                                    print(tmpDic)
                                                    let object:NSData?
                                                    do{
                                                        object = try? NSJSONSerialization.dataWithJSONObject(tmpDic!, options: NSJSONWritingOptions.PrettyPrinted)
                                                    }
                                                    user.groupdetails=object
                                                }
                                                
                                                
                                                success!(user)
            },
                                            failure:
            failure
        )
    }
    
    
    //  /FamilyAccount/UpdateUserInfo    更新用户个人信息
    class func UpdateUserInfo(dataDic:NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        var constructingBlock:((AFMultipartFormData?) -> Void)?=nil
        if let tmpdata=dataDic["headImage"] {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let str = formatter.stringFromDate(NSDate())
            let fileName = NSString(format: "%@", str)
            constructingBlock={
                data in
                var _ = data!.appendPartWithFileData((tmpdata as! NSData), name: (fileName as String), fileName: "headImage", mimeType: "image/png")
            }
        }
        NetworkManager.defaultManager!.request("UpdateUserInfo", GETParameters: nil, POSTParameters: dataDic, constructingBodyWithBlock: constructingBlock, success: {
            data in
          print(data)
            let tmpData=data.objectForKey("data")
            print(tmpData)
            let user = User.cachedObjectWithID((tmpData!.objectForKey("userid") as! NSNumber).stringValue)
            user.city=(tmpData!.objectForKey("city") as? String) ?? ""
            user.country=(tmpData!.objectForKey("country") as? String) ?? ""
            var tmpUrl=(tmpData!.objectForKey("headimageurl") as? String) ?? ""
            if (tmpUrl != "")
            {
                if (tmpUrl.containsString("http"))==false
                {
                    tmpUrl=(NetworkManager.defaultManager?.website)!+tmpUrl
                }
                user.headimageurl=NSData(contentsOfURL: NSURL(string: tmpUrl)!)
            }
            user.language=(tmpData!.objectForKey("language") as? String) ?? ""
            user.mobile=(tmpData!.objectForKey("mobile") as? String) ?? ""
            user.name=(tmpData!.objectForKey("nickname") as? String) ?? ""
            user.openid=(tmpData!.objectForKey("openid") as? String) ?? ""
            user.province=(tmpData!.objectForKey("province") as? String) ?? ""
            user.scope=(tmpData!.objectForKey("scope") as? String) ?? ""
            let tmpSex=tmpData!.objectForKey("sex")
            if ((tmpSex?.isKindOfClass(NSNumber.classForCoder())) == true)
            {
                user.sex=(tmpSex as! NSNumber).stringValue
            }
            else{
               user.sex=""
            }

            let tmpDic=tmpData!.objectForKey("GroupDetails")
            if ((tmpDic?.isKindOfClass(NSDictionary.classForCoder())) == true)
            {
                print(tmpDic)
                let object:NSData?
                do{
                    object = try? NSJSONSerialization.dataWithJSONObject(tmpDic!, options: NSJSONWritingOptions.PrettyPrinted)
                }
                user.groupdetails=object
            }
            User.currentUser=user
            
            success!()
            }, failure: failure)
        
        
    }
    //以下是未解析的借口
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
    class func UploadImages(frontImg:NSData,backImg:NSData, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        var constructingBlock:((AFMultipartFormData?) -> Void)?=nil
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let str = formatter.stringFromDate(NSDate())
        let fileName = NSString(format: "%@", str)
        constructingBlock={
            data in
            var _ = data!.appendPartWithFileData((frontImg), name: (fileName as String), fileName: "frontImg", mimeType: "image/png")
            data!.appendPartWithFileData((backImg), name: (fileName as String), fileName: "backImg", mimeType: "image/png")
        }
        
        NetworkManager.defaultManager!.request("UploadImages", GETParameters: nil, POSTParameters: ["order":"cardvf"], constructingBodyWithBlock: constructingBlock, success: {
            data in
            print(data)
            success!()
            }, failure: failure)
        
    }
    //  /AppInterface/GetOrderList       分页获取可抢订单列表
    class func GetOrderList(paramDic: NSDictionary, success: (([Order]) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetOrderList",
                                                 parameters:paramDic,
                                            success: {
                                                data in
                                             print(data)
                                                var orders=[Order]()
                                                let order=Order()
                                                order.action = data.objectForKey("action") as? String
                                                order.city = data .objectForKey("city") as? String
                                                orders.append(order)

                                                success!(orders)
            },
                                            failure:
            failure)
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
    //  /AppInterface/GetOrderDetails    获取订单详细信息
    class func GetOrderDetails(orderid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetOrderDetails",
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
    
    
    
    //GetPost/Command/NewVersion获取版本更新
    class func NewVersion(paramDic: NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("NewVersion",
                                            parameters:paramDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //GetPost/AppInterface/RefreshIndex   APP刷新首页获取数据
    class func RefreshIndex(success: ((User) -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("RefreshIndex",
                                            parameters:NSDictionary(),
                                            success: {
                                                data in
                                                
                                                print(data)
                                                let tmpData=data.objectForKey("data")
                                                let tmpUser=tmpData!.objectForKey("user")
                                                let user = User.cachedObjectWithID((tmpUser!.objectForKey("userid") as! NSNumber).stringValue)
                                                user.city=(tmpUser!.objectForKey("city") as? String) ?? ""
                                                user.country=(tmpUser!.objectForKey("country") as? String) ?? ""
                                                var tmpUrl=(tmpData!.objectForKey("headimageurl") as? String) ?? ""
                                                if (tmpUrl != "")
                                                {
                                                    if (tmpUrl.containsString("http"))==false
                                                    {
                                                        tmpUrl=(NetworkManager.defaultManager?.website)!+tmpUrl
                                                    }
                                                    user.headimageurl=NSData(contentsOfURL: NSURL(string: tmpUrl)!)
                                                }
                                                user.language=(tmpUser!.objectForKey("language") as? String) ?? ""
                                                user.mobile=(tmpUser!.objectForKey("mobile") as? String) ?? ""
                                                user.name=(tmpUser!.objectForKey("nickname") as? String) ?? ""
                                                user.openid=(tmpUser!.objectForKey("openid") as? String) ?? ""
                                                user.province=(tmpUser!.objectForKey("province") as? String) ?? ""
                                                user.scope=(tmpUser!.objectForKey("scope") as? String) ?? ""
                                                let tmpSex=tmpUser!.objectForKey("sex")
                                                if ((tmpSex?.isKindOfClass(NSNumber.classForCoder())) == true)
                                                {
                                                    user.sex=(tmpSex as! NSNumber).stringValue
                                                }
                                                else{
                                                    user.sex=""
                                                }
                                                user.score=(tmpData!.objectForKey("score") as? String) ?? ""
                                                user.bdimgs=(tmpData!.objectForKey("bdimgs") as? String) ?? ""
                                                user.bannerimgs=(tmpData!.objectForKey("bannerimgs") as? String) ?? ""
                                                
                                                do{
                                                    user.realname = try? NSJSONSerialization.dataWithJSONObject(tmpData!.objectForKey("realname")!, options: NSJSONWritingOptions.PrettyPrinted)
                                                    user.orderabout = try? NSJSONSerialization.dataWithJSONObject(tmpData!.objectForKey("orderabout")!, options: NSJSONWritingOptions.PrettyPrinted)
                                                    let tmpDic=tmpUser!.objectForKey("GroupDetails")
                                                    if ((tmpDic?.isKindOfClass(NSDictionary.classForCoder())) == true)
                                                    {
                                                        user.groupdetails = try? NSJSONSerialization.dataWithJSONObject(tmpDic!, options: NSJSONWritingOptions.PrettyPrinted)
                                                    }
                                                    
                                                }
                                                success!(user)
            },
                                            failure: failure)
    }
    
    //GetPost/AppInterface/SubmitTime提交上门时间
    class func SubmitTime(paramDic: NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("SubmitTime",
                                            parameters:paramDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //GetPost/AppInterface/GetHomeTimeList获取历史提交的上门时间
    class func GetHomeTimeList(orderid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetHomeTimeList",
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
    //GetPost/AppInterface/PartnerCommand组(合伙人)成员操作
    class func PartnerCommand(orderid: String, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("PartnerCommand",
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
    //GetPost/AppInterface/UpgradeAuthority升级权限
    class func UpgradeAuthority(paramDic: NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("UpgradeAuthority",
                                            parameters:paramDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    
    //GetPost/AppInterface/GetNowAuthorityDetail获取当前权限的信息或者审核进度，获取团队成员信息
    class func GetNowAuthorityDetail
        (success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetNowAuthorityDetail",
                                            parameters:nil,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    
    
    //GetPost/AppInterface/GetMyScoreDetails获取个人的所有评价
    class func GetMyScoreDetails (success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetMyScoreDetails",
                                            parameters:nil,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    //GetPost/Command/GetOwenBindBlankCard获取所有我的绑定银行卡列表
    class func GetOwenBindBlankCard (success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetMyScoreDetails",
                                            parameters:nil,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    
    //GetPost/Command/BindNewBlankCard绑定银行卡
    class func BindNewBlankCard(paramDic: NSDictionary, success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("BindNewBlankCard",
                                            parameters:paramDic,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    
    //GetPost/AppInterface/GetOwenMoney获取我的账户余额
    
    class func GetOwenMoney (success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager!.POST("GetOwenMoney",
                                            parameters:nil,
                                            success: {
                                                data in
                                                print(data)
                                                success!()
            },
                                            failure: failure)
    }
    
    
    //GetPost/AppInterface/GetOwenMoneyDetails分页获取我的账户明细
    class func GetOwenMoneyDetails (index : Int,pagesize : Int,success: (() -> Void)?, failure: ((NSError) -> Void)?) {
        NetworkManager.defaultManager?.POST("GetOwenMoneyDetails", parameters: ["index":index ,"pagesize" :pagesize],
                                            success: { (data) in
                                                print(data)
                                                success!()
            }, failure: failure)
    }
    
    
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
