//
//  NSDate+expand.swift
//  OznerServer
//
//  Created by 赵兵 on 16/2/26.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import Foundation
///日期操作类
class DateTool
{
    /**
     服务器时间戳转换成ios日期格式：例如："\Date(121300032190)\"->NSDate
     
     - parameter TimeStamp: "\Date(121300032190)\"
     
     - returns: NSDate
     */
    class func dateFromServiceTimeStamp(TimeStamp:String)->NSDate? {
        if  MSRIsNilOrNull(TimeStamp)
        {
            return nil
        }
        var tmpStr=TimeStamp as NSString
        tmpStr=tmpStr.substringFromIndex(6)
        tmpStr=tmpStr.substringToIndex(tmpStr.length-2)
        let tmpTimeStr=NSTimeInterval(tmpStr.intValue/1000)
        return NSDate(timeIntervalSince1970: tmpTimeStr)
    }
    /**
     服务器时间戳转换成ios时间戳：例如："\Date(121300032190)\"->121300032
     
     - parameter TimeStamp: "\Date(121300032190)\"
     
     - returns: NSTimeInterval
     */
    class func TimeIntervalFromServiceTimeStamp(TimeStamp:String)->NSTimeInterval? {
        if  MSRIsNilOrNull(TimeStamp)
        {
            return nil
        }
        var tmpStr=TimeStamp as NSString
        tmpStr=tmpStr.substringFromIndex(6)
        tmpStr=tmpStr.substringToIndex(tmpStr.length-2)
        let tmpTimeStr=NSTimeInterval(tmpStr.intValue/1000)
        return tmpTimeStr
    }
    
    class func stringFromDate(date:NSDate,dateFormat:String)->String {
        let tmpDate=NSDateFormatter()
        tmpDate.dateFormat=dateFormat
        return tmpDate.stringFromDate(date)
    }
    
    class func dateFromString(dateString:String,dateFormat:String)->NSDate {
        let tmpDate=NSDateFormatter()
        tmpDate.dateFormat=dateFormat
        return tmpDate.dateFromString(dateString)!
    }
    
}