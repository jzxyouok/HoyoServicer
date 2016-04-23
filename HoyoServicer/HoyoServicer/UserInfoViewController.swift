//
//  UserInfoViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/8.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController,SelectIDTableViewControllerDelegate{

    
   
    lazy var setSexController: SetSexViewController = {
        
        let setSexController = SetSexViewController (nibName: "SetSexViewController", bundle: nil)
     
        return setSexController
    }()
    lazy var editNameCon: EditNameViewController = {
        
        let editNameCon = EditNameViewController (nibName: "EditNameViewController", bundle: nil)
        
        return editNameCon
    }()
    
    @IBAction func toDetailController(sender: UIButton) {
        switch sender.tag {
        case 1:
            let alert = SCLAlertView()
            alert.addButton("相册") {
                [weak self] in
                let libraryViewController = CameraViewController.imagePickerViewController(true) { [weak self] image, asset in
                    if let  strongSelf = self{
                        strongSelf.headImg.image = image
                        User.currentUser?.headimageurl=UIImageJPEGRepresentation(image!, 0.001)! as NSData
                    }
                    
                    self!.dismissViewControllerAnimated(true, completion: nil)
                }
                
                self!.presentViewController(libraryViewController, animated: true, completion: nil)
            }
            alert.addButton("拍摄") {
                [weak self] in
                let cameraViewController = CameraViewController(croppingEnabled: true, allowsLibraryAccess: true) { [weak self] image, asset in
                    if let  strongSelf = self{
                        strongSelf.headImg.image = image
                        User.currentUser?.headimageurl=UIImageJPEGRepresentation(image!, 0.001)! as NSData
                    }
                    self!.dismissViewControllerAnimated(true, completion: nil)
                }
                self!.presentViewController(cameraViewController, animated: true, completion: nil)
            }
            alert.addButton("取消", action: {})
            alert.showInfo("", subTitle: "请选择以下方式更新个人头像")
           
        break
        case 2:
            editNameCon.tmpEditName = self.name.text!
            self.navigationController?.pushViewController(editNameCon, animated: true)
            break
        case 3:

            setSexController.tmpSex = self.sex.text
            self.navigationController?.pushViewController(setSexController, animated: true)
            
            break
        case 4:
            
        
//            let adressControll = SelectAdressTableViewController(adressData: adressDic, firstSelectRow: -1)
//            adressControll.delegate=self
//            self.navigationController?.pushViewController(adressControll, animated: true)
//            
            let jsonPath = NSBundle.mainBundle().pathForResource("china_citys", ofType: "json")
            let jsonData = NSData(contentsOfFile: jsonPath!)! as NSData
            let tmpObject: AnyObject?
            do{
                tmpObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            }
            let adressDic = tmpObject as! NSMutableArray
            let adressControll = SelectAdressTableViewController(adressData: adressDic, firstSelectRow: -1)
            adressControll.delegate = self
            self.navigationController?.pushViewController(adressControll, animated: true)

            break
        default: break
            
        }
     
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
            setNavigationItem("back.png", selector: #selector(UIViewController.doBack), isRight: false)
        // Do any additional setup after loading the view.
    }
    
    //------代理-----
    func SelectAdressFinished(adress:String)
    {
        
        User.currentUser?.province =   adress.componentsSeparatedByString(" ").first
        User.currentUser?.city = adress.componentsSeparatedByString(" ").last
        self.address.text = adress
        
    }
   func selectButtonChange(index:Int)
   {
    
    }
    func ToSelectAdressController() {
        
    }
    
    
    //返回
    override func doBack() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
     let parames = ["headImage": (User.currentUser?.headimageurl)!,"province":(User.currentUser?.province)!,"city":(User.currentUser?.city)!,"sex":(User.currentUser?.sex)!]
        User.UpdateUserInfo(parames, success: {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.navigationController?.popViewControllerAnimated(true)
        }) { (error) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            let alertView=SCLAlertView()
            alertView.addButton("重新试一下", action: {
                [weak self] in
                self?.doBack()
            })
            alertView.addButton("取消", action: {
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertView.showError("错误提示", subTitle: error.localizedDescription)
        }
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        if User.currentUser?.province != "" && User.currentUser?.city != ""
        {
      self.address.text = "\(User.currentUser?.province)"  + " " + "\(User.currentUser?.city)"
        }
        self.tabBarController?.tabBar.hidden=true
        
        if User.currentUser?.headimageurl != nil
        {
            headImg.image=UIImage(data: (User.currentUser?.headimageurl)!)
        }
       
        phone.text=User.currentUser?.mobile
        
         name.text=User.currentUser?.name
        sex.text=User.currentUser?.sex == "0" ? "女":"男"

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
