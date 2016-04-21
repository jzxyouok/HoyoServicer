//
//  UserInfoViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/8.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    var setSexController :SetSexViewController?
    
    @IBAction func toDetailController(sender: UIButton) {
        switch sender.tag {
        case 1:
            let alert = SCLAlertView()
            alert.addButton("相册") {
                [weak self] in
                let libraryViewController = CameraViewController.imagePickerViewController(true) { [weak self] image, asset in
                    self!.headImg.image = image
                    //headImg.setImage(image, forState: .Normal)// = image
                    self!.dismissViewControllerAnimated(true, completion: nil)
                }
                
                self!.presentViewController(libraryViewController, animated: true, completion: nil)
            }
            alert.addButton("拍摄") {
                [weak self] in
                let cameraViewController = CameraViewController(croppingEnabled: true, allowsLibraryAccess: true) { [weak self] image, asset in
                  // headImg.setImage(image, forState: .Normal)
                    self!.headImg.image = image
                   // headImg.image = UIImage(CGImage: image)
                    self!.dismissViewControllerAnimated(true, completion: nil)
                }
                self!.presentViewController(cameraViewController, animated: true, completion: nil)
            }
            alert.addButton("取消", action: {})
            alert.showInfo("", subTitle: "请选择")
           // alert.showInfo("", subTitle: "请选择")
        break
        case 2:
            
            let editName = EditNameViewController()
            
            self.navigationController?.pushViewController(editName, animated: true)
          

            
            break
        case 3:

            
        setSexController     = SetSexViewController(nibName: "SetSexViewController", bundle: nil)
            
            setSexController!.tmpSex = User.currentUser?.sex == "" ? "男":User.currentUser?.sex

         
            setSexController!.backClosure={ (inputText:String) -> Void in
               self.sex.text = inputText
               
            }
            self.navigationController?.pushViewController(setSexController!, animated: true)
            
           // self.navigationController?.pushViewController(selectSexCon!, animated: true)
            break
        default: break
            
        }
        
        print(sender.tag)
    }
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var level: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="个人信息"
            setNavigationItem("back.pbg", selector: #selector(UIViewController.doBack), isRight: false)
        // Do any additional setup after loading the view.
    }
    
    //返回
    override func doBack() {
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true
        if User.currentUser?.headimageurl != ""
        {
            headImg.sd_setImageWithURL(NSURL(string: (User.currentUser?.headimageurl)!), placeholderImage: headImg.image)
        }
        name.text=User.currentUser?.name
        phone.text=User.currentUser?.mobile
        
        //判断程序是不是第一次进入该页面
        
       if  setSexController?.backClosure == nil
       {
        
        print("第一次进来")
        sex.text=User.currentUser?.sex == "" ? "男":User.currentUser?.sex
        }
        else
       {
        print("不是第一次")
       sex.text = setSexController?.tmpSex
        User.currentUser?.sex = setSexController?.tmpSex
        }
     
        
        address.text=(User.currentUser?.province)!+"  "+(User.currentUser?.city)!
        level.text=User.currentUser?.score//mei
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience  init() {
        
        var nibNameOrNil = String?("UserInfoViewController")
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil
        {
            nibNameOrNil = nil
        }
        self.init(nibName: nibNameOrNil, bundle: nil)
        
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
