//
//  HomeTableViewCell.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/28.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell,UIScrollViewDelegate {

    var buttonClickCallBack:((whichButton:Int)->Void)?
    @IBAction func buttonClick(sender: UIButton) {
        if buttonClickCallBack==nil{
            return
        }
        buttonClickCallBack!(whichButton: sender.tag)
    }
    @IBOutlet weak var personImg: UIImageView!
    
    
    //banner
    @IBOutlet weak var footerScrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    var bannerImgArr=["banner3","banner1","banner2","banner3","banner1"]
    override func awakeFromNib() {
        super.awakeFromNib()
        personImg.layer.cornerRadius=personImg.frame.width/2
        footerScrollView.contentSize=CGSize(width: WIDTH_SCREEN*5, height: footerScrollView.frame.height)
        footerScrollView.contentOffset=CGPoint(x: WIDTH_SCREEN, y: 0)
        for i in 0...4 {
            let tmpImgView=UIImageView(frame: CGRect(x: WIDTH_SCREEN*CGFloat(i), y: 0, width: WIDTH_SCREEN, height: footerScrollView.frame.height))
            tmpImgView.image=UIImage(named: bannerImgArr[i])
            footerScrollView.addSubview(tmpImgView)
        }
        footerScrollView.delegate = self
        //定时轮播
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(autoPlay), userInfo: nil, repeats: true)
    }
//    // scrollView 已经滑动
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
    func autoPlay(){
        //更改scrollView   countOffSet
        //如果偏移量>=contentSize.width 要先把偏移量置为（0， 0） 再加上一个width
        let tmpx = footerScrollView.contentOffset.x;//获取偏移量
        if (tmpx + WIDTH_SCREEN >= footerScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
            footerScrollView.setContentOffset(CGPointMake(0, 0), animated: false)//先把偏移量置为（0，0）
           footerScrollView.setContentOffset(CGPointMake(WIDTH_SCREEN, 0), animated: true)
           //再偏移width宽度
        }else {
            footerScrollView.setContentOffset(CGPointMake(tmpx + WIDTH_SCREEN, 0), animated: true)
        }
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    // scrollView 开始拖动
    private var xBeginDragging:CGFloat=0
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        xBeginDragging=scrollView.contentOffset.x
        print(scrollView.contentOffset)
    }
    
    // scrollView 结束拖动
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let xDidEndDragging=scrollView.contentOffset.x
        print(scrollView.contentOffset)
        //向左边缘拖动
        if fabs(xDidEndDragging-xBeginDragging)>WIDTH_SCREEN/3 {
            switch bannerPageIndex {
            case 0:
                bannerPageIndex=(xDidEndDragging-xBeginDragging)>0 ? 1:2
            case 1:
                bannerPageIndex=(xDidEndDragging-xBeginDragging)>0 ? 2:0
            default://2
                bannerPageIndex=(xDidEndDragging-xBeginDragging)>0 ? 0:1
            }
        }
        else
        {
            let tmpValue = bannerPageIndex
            bannerPageIndex=tmpValue
        }
        
    }
    private var bannerPageIndex=0{
        didSet{
            
            pageControll.currentPage=bannerPageIndex
            footerScrollView.contentOffset=CGPoint(x: WIDTH_SCREEN*CGFloat(bannerPageIndex+1), y: 0)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
