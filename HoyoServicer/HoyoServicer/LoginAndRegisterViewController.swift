//
//  LoginAndRegisterViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/28.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit
enum LoginStateEnum:Int {
    case Login=0
    case Register1=1
    case Register2=2
    case Register3=3
}
class LoginAndRegisterViewController: UIViewController,UITextFieldDelegate {

    //视图类
    var loginFooterView:LoginFooterView?
    var registFooterView1:RegistFooterView1?
    var registFooterView2:RegistFooterView2?
    var registFooterView3:RegistFooterView3?
    @IBOutlet weak var bottomImgOfLogin: UIImageView!
    @IBOutlet weak var bottomImgOfRegister: UIImageView!
    @IBOutlet weak var footerViewContainer: UIView!
    @IBAction func loginOrRegistButtonClick(sender: UIButton) {
        print(sender.tag)
        currentLoginState = (sender.tag==1) ? .Login:.Register1
    }
    
    /// 变量
    var firstAppear=true//是不是第一次打开
    /// 视图类
    var guardView:UIView!//首次登录导航视图
    var loginView:UIView!//登录视图
    var registView:UIView!//注册视图
    var currentLoginState = LoginStateEnum.Login{
        didSet{
            loginFooterView?.hidden = (currentLoginState == .Login) ? false:true
            registFooterView1?.hidden = (currentLoginState == .Register1) ? false:true
            registFooterView2?.hidden = (currentLoginState == .Register2) ? false:true
            registFooterView3?.hidden = (currentLoginState == .Register3) ? false:true
            bottomImgOfLogin.hidden=(currentLoginState == .Login) ? false:true
            bottomImgOfRegister.hidden=(currentLoginState != .Login) ? false:true
            switch currentLoginState {
            case .Login:
                print("Login")
            case .Register1:
                print("Register1")
            case .Register2:
                print("Register2")
            default:
                print("Register3")
                break
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化视图
        loginFooterView=NSBundle.mainBundle().loadNibNamed("LoginFooterView", owner: nil, options: nil).last as? LoginFooterView
        registFooterView1=NSBundle.mainBundle().loadNibNamed("RegistFooterView1", owner: nil, options: nil).last as? RegistFooterView1
        registFooterView2=NSBundle.mainBundle().loadNibNamed("RegistFooterView2", owner: nil, options: nil).last as? RegistFooterView2
        registFooterView3=NSBundle.mainBundle().loadNibNamed("RegistFooterView3", owner: nil, options: nil).last as? RegistFooterView3
        loginFooterView?.phoneTextField.delegate=self
        loginFooterView?.passWordTextField.delegate=self
        registFooterView1?.phoneTextField.delegate=self
        registFooterView2?.codeTextField.delegate=self
        registFooterView3?.nameTextField.delegate=self
        registFooterView3?.IDCardTextField.delegate=self
        registFooterView3?.passWordTextField.delegate=self
        registFooterView3?.invitationCodeTextField.delegate=self
        loginFooterView?.foregetPassWordButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        loginFooterView?.loginButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        registFooterView1?.nextButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        registFooterView1?.agreeImgButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        registFooterView1?.agreeTextButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        registFooterView2?.nextButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        registFooterView3?.nextButton.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        footerViewContainer.addSubview(loginFooterView!)
        footerViewContainer.addSubview(registFooterView1!)
        footerViewContainer.addSubview(registFooterView2!)
        footerViewContainer.addSubview(registFooterView3!)
        loginFooterView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(footerViewContainer).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        registFooterView1?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(footerViewContainer).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        registFooterView2?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(footerViewContainer).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        registFooterView3?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(footerViewContainer).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        currentLoginState = .Login
    }

    func buttonClick(button:UIButton){
        print(button.tag)
        switch button.tag {
        case 1://登录页面：忘记密码
            print("忘记密码")
        case 2://登录页面：登录
            presentMainViewController()
        case 3://注册页面一：下一步
            currentLoginState = .Register2
        case 4://注册页面一：小对号图标
            print("小对号图标")
        case 5://注册页面一：同意浩优服务家协议
            print("同意浩优服务家协议")
        case 6://注册页面二：下一步
            currentLoginState = .Register3
        case 7://注册页面三：下一步
            let authController = AuthenticationController(dissCall: {
                [weak self] in
                if let StrongSelf=self
                {
                    StrongSelf.presentMainViewController()
                }
            })
            
            presentViewController(authController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            firstAppear = false
            
            NetworkManager.defaultManager?.POST("AppLogin", parameters: ["phone":"15026981614","password":"123456"], success: { (dataDic) in
                print(dataDic)
                }, failure: { (error) in
                    print(error)
            })
            //            User.loginWithCookiesAndCacheInStorage(
            //                success: {
            //                    [weak self] user in
            //                    User.currentUser = user
            //self.presentMainViewController()
            //                },
            //                failure: nil)
        }
    }
    /**
     呈现主视图
     
     - parameter isPresentAuth: 是否弹出身份验证视图
     */
    func presentMainViewController() {
        appDelegate.mainViewController = MainViewController()
        appDelegate.mainViewController.modalTransitionStyle = .CrossDissolve
        presentViewController(appDelegate.mainViewController, animated: true, completion: nil)
        
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if [1,3,4,7].contains(textField.tag) && !string.isAllNumber {
            return false
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience  init() {
        var nibNameOrNil = String?("LoginAndRegisterViewController")
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil
        {
            nibNameOrNil = nil
        }
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
