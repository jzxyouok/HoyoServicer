//
//  AuthenticationController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/30.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class AuthenticationController: UIViewController {

    var dissCallBack:(()->Void)?//对注册进来用的
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerViewContainer: UIView!
    @IBOutlet weak var firstViewContainer: UIView!
    @IBOutlet weak var verifyButton: UIButton!
    @IBAction func verifyClick(sender: AnyObject) {
        
        secondViewContainer?.hidden = !((secondViewContainer?.hidden)!)
        verifyButton.setTitle(((secondViewContainer?.hidden)!)==true ? "身份验证":"提交", forState: .Normal)
        if dissCallBack != nil {
            leftButton.hidden = ((secondViewContainer?.hidden)!)
        }
    }
    var secondViewContainer:AuthDetailView?
    override func viewDidLoad() {
        super.viewDidLoad()
        secondViewContainer=NSBundle.mainBundle().loadNibNamed("AuthDetailView", owner: nil, options: nil).last as? AuthDetailView
        centerViewContainer.addSubview(secondViewContainer!)
        secondViewContainer?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(centerViewContainer).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        secondViewContainer?.hidden=true
        leftButton.addTarget(self, action: #selector(barButtonClick), forControlEvents: .TouchUpInside)
        rightButton.addTarget(self, action: #selector(barButtonClick), forControlEvents: .TouchUpInside)
        secondViewContainer?.imageButton1.addTarget(self, action: #selector(cameraClick), forControlEvents: .TouchUpInside)
        secondViewContainer?.imageButton2.addTarget(self, action: #selector(cameraClick), forControlEvents: .TouchUpInside)
        leftButton.hidden = !(dissCallBack == nil)
        rightButton.hidden = (dissCallBack == nil)
        User.GetNowAuthorityDetail({
            print("")
            }) { (error) in
                print(error)
        }
        // Do any additional setup after loading the view.
    }
    func barButtonClick(button:UIButton)
    {
        if secondViewContainer?.hidden==false&&button.tag==1 {
            secondViewContainer?.hidden = !(secondViewContainer?.hidden)!
            verifyButton.setTitle("身份验证", forState: .Normal)
            if dissCallBack != nil {
                leftButton.hidden = ((secondViewContainer?.hidden)!)
            }
        }
        else{
            self.dismissViewControllerAnimated(dissCallBack==nil, completion: dissCallBack)
        }
        
        
    }
    func cameraClick(button:UIButton) {
        let alert = SCLAlertView()
        alert.addButton("相册") {
            [weak self] in
            let libraryViewController = CameraViewController.imagePickerViewController(true) { [weak self] image, asset in
                button.setImage(image, forState: .Normal)// = image
                self!.dismissViewControllerAnimated(true, completion: nil)
            }
            
            self!.presentViewController(libraryViewController, animated: true, completion: nil)
        }
        alert.addButton("拍摄") {
            [weak self] in
            let cameraViewController = CameraViewController(croppingEnabled: true, allowsLibraryAccess: true) { [weak self] image, asset in
                button.setImage(image, forState: .Normal)
                
                self!.dismissViewControllerAnimated(true, completion: nil)
            }
            self!.presentViewController(cameraViewController, animated: true, completion: nil)
        }
        alert.addButton("取消", action: {})
        alert.showInfo("", subTitle: "请选择")
        
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //dissCall不等于nil，是从注册跳过来的，否则，从个人中心过来的
    convenience  init(dissCall:(()->Void)?) {
        
        var nibNameOrNil = String?("AuthenticationController")
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil
        {
            nibNameOrNil = nil
        }
        self.init(nibName: nibNameOrNil, bundle: nil)
        dissCallBack=dissCall
        
    }
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
