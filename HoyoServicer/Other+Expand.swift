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