//
//  NetworkManager.swift
//  WeCenterMobile
//
//  Created by Darren Liu on 15/10/7.
//  Copyright (c) 2015年 BetaTech. All rights reserved.
//


import Foundation

let UserDefaultsCookiesKey = "OznerServer_DefaultCookies"
let UserDefaultsUserIDKey = "OznerServer_DefaultUserID"

/// 网络访问基类
class NetworkManager: NSObject {
    required init?(NetworkConfig: NSDictionary) {
        print(NetworkConfig)
        self.NetworkConfig = NetworkConfig
        super.init()
        
    }
    static var defaultManager = NetworkManager(NetworkConfig: NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("NetworkConfig", ofType: "plist")!)!)

    func GET(key: String,
        parameters: NSDictionary?,
        success: ((AnyObject) -> Void)?,
        failure: ((NSError) -> Void)?) -> AFHTTPRequestOperation? {
            return request(key,
                GETParameters: parameters,
                POSTParameters: nil,
                constructingBodyWithBlock: nil,
                success: success,
                failure: failure)
    }
    func POST(key: String,
        parameters: NSDictionary?,
        success: ((AnyObject) -> Void)?,
        failure: ((NSError) -> Void)?) -> AFHTTPRequestOperation? {
            return request(key,
                GETParameters: nil,
                POSTParameters: parameters,
                constructingBodyWithBlock: nil,
                success: success,
                failure: failure)
    }
    func request(key: String,
        GETParameters: NSDictionary?,
        POSTParameters: NSDictionary?,
        constructingBodyWithBlock block: ((AFMultipartFormData?) -> Void)?,
        success: ((AnyObject) -> Void)?,
        failure: ((NSError) -> Void)?) -> AFHTTPRequestOperation? {
            var error: NSError? = nil
            let URLString = manager.requestSerializer.requestWithMethod("GET", URLString: paths[key]!, parameters: GETParameters, error: &error).URL?.absoluteString
            if error != nil || URLString == nil {
                failure?(error!) // Needs specification
                return nil
            }
            return manager.POST(URLString!,
                parameters: POSTParameters,
                constructingBodyWithBlock: block,
                success: {
                    [weak self] operation, data in
                    self?.handleSuccess(operation: operation, data: data as! NSData, success: success, failure: failure)
                },
                failure: {
                    operation, error in
                    failure?(error)
            })
    }
    private func handleSuccess(operation operation: AFHTTPRequestOperation, data: NSData, success: ((AnyObject) -> Void)?, failure: ((NSError) -> Void)?) {
        let error: NSError? = nil
        let object: AnyObject?
        do{
             object = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        }
        if error != nil || object == nil || !(object is NSDictionary) {
            var userInfo = [
                NSLocalizedDescriptionKey: "Failed to parse JSON.",
                NSLocalizedFailureReasonErrorKey: "The data returned from the server does not meet the JSON syntax.",
                NSURLErrorKey: operation.response!.URL!
            ]
            if operation.error != nil {
                userInfo[NSUnderlyingErrorKey] = operation.error
            }
            let error = NSError(
                domain: website,
                code: 404,
                userInfo: userInfo)
            NSLog("\(operation.response!.URL!)\n\(error)\n\(NSString(data: data, encoding: NSUTF8StringEncoding)))")
            failure?(error)
            return
        }
        let data = object as! NSDictionary
        let state=data["state"] as! Int
        if state > successCode {
            success?(data)
            //DataManager.defaultManager!.saveChanges()
        } else if(state==tokenFailCode){
            appDelegate.LoginOut()
            //token失效，返回到登录界面重新登录
        }
        else{
            var userInfo = [
                NSLocalizedDescriptionKey: getErrorState(state),
                NSURLErrorKey: operation.response!.URL!
            ]
            if operation.error != nil {
                userInfo[NSUnderlyingErrorKey] = operation.error
            }
            let error = NSError(
                domain: website,
                code: state,
                userInfo: userInfo)
            NSLog("\(error)")
            failure?(error)
        }
    }
    /**
     获取错误的中文描述
     
     - parameter state: 错误编码
     
     - returns: 中文描述信息
     */
    func getErrorState(state:Int)->String
    {
        var errorState=""
        if (self.ErrorCode.allKeys as! [String]).contains("\(state)")
        {
            errorState=self.ErrorCode["\(state)"] as! String
        }
        return errorState
    }
    /**
     清理cookies
     */
    class func clearCookies() {
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()//as! [NSHTTPCookie]
        for cookie in (storage.cookies)! {
            storage.deleteCookie(cookie)
        }
        NSUserDefaults.standardUserDefaults().removeObjectForKey(UserDefaultsCookiesKey)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(UserDefaultsUserIDKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }

    private let NetworkConfig: NSDictionary
    /// 借口前缀
    var website: String {
        return NetworkConfig["Website"] as! String
    }
    /// 接口后缀路径地址
    var paths: [String: String] {
        return NetworkConfig["Path"] as! [String: String]
    }
    private lazy var manager: AFHTTPRequestOperationManager = {
        [weak self] in
        print(self?.website)
        assert(self?.website != nil, "website不能为nil")
        let manager = AFHTTPRequestOperationManager(baseURL: NSURL(string: (self?.website)!))
        manager.responseSerializer = AFHTTPResponseSerializer()
        return manager
        }()

    /// 成功编码
    var successCode: Int {
        return Int((NetworkConfig["SuccessCode"] as! String))!
    }
    /// token失败的错误编码
    var tokenFailCode: Int {
        return Int((NetworkConfig["TokenFailCode"] as! String))!
    }
    /// 其他错误编码列表
    var ErrorCode: NSDictionary {
        return NetworkConfig["ErrorCode"] as! NSDictionary
    }
}
