//
//  commonAttribute.swift
//  OznerServer
//
//  Created by 赵兵 on 16/2/26.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit
//状态栏高度
let StatusBar_HEIGHT:CGFloat=20
//导航栏高度
let NavBar_HEIGHT:CGFloat=64
//导航栏高度
let TabBar_HEIGHT:CGFloat=49
//获取当前屏幕 宽度、高度
let SCREEN_WIDTH:CGFloat = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:CGFloat = UIScreen.mainScreen().bounds.size.height
//参考的设计图纸尺寸
let WidthOfDesign:CGFloat=375.0
let HeightOfDesign:CGFloat=667.0
//宽比例尺寸换算
func WidthFromTranslat(width:CGFloat)->CGFloat
{
    return width*SCREEN_WIDTH/WidthOfDesign
}
//高比例尺寸换算
func HeightFromTranslat(height:CGFloat)->CGFloat
{
    return height*SCREEN_HEIGHT/HeightOfDesign
}
//系统版本号
let IOS_VERSION:Float = Float((UIDevice.currentDevice().systemVersion as NSString).substringToIndex(1))!


