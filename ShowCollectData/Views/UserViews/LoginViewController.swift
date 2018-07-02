//
//  ViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/10.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

struct UIButtonCheckState {
    static let btnChecked: Int = 1
    static let btnUnchecked: Int = -1
}

struct Keys {
    static let selectedProjectId = "selectedProjectId"
    static let isAutoLogin = "isAutoLogin"
    static let isRemberPwd = "isRemberPwb"
    static let username = "userName"
    static let password = "passWord"
}

class ViewController: UIViewController {

    @IBOutlet var btnLogin:UIButton!
    
    @IBOutlet var btnRegister:UIButton!
    @IBOutlet var btnRefind:UIButton!
    
    @IBOutlet weak var btnRememberPass:UIButton!
    @IBOutlet weak var btnAutoLogin:UIButton!
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPwd: UITextField!
    
    
    var btnAutoLoginFlag: Int!{
        didSet{
            if btnAutoLogin != nil {
                //自动登录选中的时候，必定会记住密码
                if self.btnAutoLoginFlag == UIButtonCheckState.btnChecked{
                    btnRememberPwdFlag = UIButtonCheckState.btnChecked
                    btnAutoLogin.setImage(UIImage(named: "btn_check_on") , for: .normal)
                }else if self.btnAutoLoginFlag == UIButtonCheckState.btnUnchecked{
                    btnAutoLogin.setImage(UIImage(named: "btn_check_off") , for: .normal)
                }
            }
        }
    }
    var btnRememberPwdFlag: Int!{
        didSet{
            if btnRememberPass != nil {
                if self.btnRememberPwdFlag == UIButtonCheckState.btnChecked{
                    btnRememberPass.setImage(UIImage(named: "btn_check_on") , for: .normal)
                }else if self.btnRememberPwdFlag == UIButtonCheckState.btnUnchecked{
                    btnRememberPass.setImage(UIImage(named: "btn_check_off") , for: .normal)
                }
            }
        }
    }
    
    //var color:UIColor!
    
    func initViews() {
        //btnLogin.layer.borderWidth = 1
        btnLogin.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor //  UIColor.green.cgColor
        btnLogin.layer.cornerRadius = 5
        
        //btnLogin.layer.masksToBounds = true
        
        btnLogin.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        btnRegister.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        btnRefind.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        
        btnRegister.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        btnRefind.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        btnRememberPass.imageView?.contentMode = .scaleAspectFill
        btnAutoLogin.imageView?.contentMode = .scaleAspectFill
        
        btnRememberPass.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        btnAutoLogin.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
        
        let accountDefaults = UserDefaults.standard
        if let retLogin = accountDefaults.value(forKey: Keys.isAutoLogin){
            btnAutoLoginFlag = retLogin as! Int
        }else{
            btnAutoLoginFlag = UIButtonCheckState.btnUnchecked
            
        }
        
        if let retPwd = accountDefaults.value(forKey: Keys.isRemberPwd){
            btnRememberPwdFlag = retPwd as! Int
        }else{
            btnRememberPwdFlag = UIButtonCheckState.btnUnchecked
        }
        
        var name:String? = nil
        var pwd:String? = nil
        if let retUserName = accountDefaults.value(forKey: Keys.username) {
            name = retUserName as? String
        }
        if let retPassword = accountDefaults.value(forKey: Keys.password) {
            pwd = retPassword as? String
        }
        self.textName.text = name
        self.textPwd.text = pwd
        
        if btnAutoLoginFlag == UIButtonCheckState.btnChecked {
            if let name = name, let pwd = pwd{
                doLogin(accountName: name, password: pwd)
            }else{
                print("未获取到保存的用户数据")
                ToastHelper.showGlobalToast(message: "未获取到保存的用户数据")
            }
        }
    }
    
    func gotoMainView(accountType: AccountType, projects: [ShowProject], account: ShowAccount){
        
        let titleBarHeight : CGFloat = {
            let screenH = UIScreen.main.bounds.height
            var size: CGFloat = 0
            if screenH >= 568.0 && screenH < 667.0 {
                size = 40
            } else if screenH >= 667.0 && screenH < 736.0 {
                size = 45
            } else if screenH >= 736.0 {
                size = 50
            }
            return size
        }()
        
        let titleFontSize: CGFloat = {
            let screenH = UIScreen.main.bounds.height
            var size: CGFloat = 0
            if screenH >= 568.0 && screenH < 667.0 {
                size = 12
            } else if screenH >= 667.0 && screenH < 736.0 {
                size = 15
            } else if screenH >= 736.0 {
                size = 17
            }
            return size
        }()
        
        let pagesOptions:[UIViewPagerOption] = [
            .TitleBarHeight(titleBarHeight),
            .TitleBarBackgroundColor(ColorUtils.mainViewBackgroudColor),
            .TitleViewBackgroundColor(ColorUtils.mainThemeColor),
            .TitleBarScrollType(UIViewPagerTitleBarScrollType.UIViewControllerMenuScroll),
            .TitleFont(UIFont.systemFont(ofSize: titleFontSize)),
            .TitleColor(UIColor.black),
            .TitleSelectedColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .TitleSelectedBgColor(ColorUtils.selectedBtnColor),
            .TitleItemWidth(self.view.frame.width / 3),
            .IndicatorColor(ColorUtils.selectedBtnColor),
            .IndicatorHeight(5),
            .IsIndicatorScrollAnimated(false),
            .IsIndicatorArrow(true),
            .BottomlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .BottomlineHeight(1),
            .TitleBarPosition(UIViewPageTitlePosition.bottom),
            .IsTitleBarHidden(accountType == AccountType.guest)
            
        ]
        
        let rootView:MainViewController = MainViewController()
        let baseVc = UINavigationController(rootViewController: rootView)
        rootView.options = pagesOptions
        rootView.viewType = accountType
        rootView.projects = projects
        rootView.account = account
        
        let accountDefaults = UserDefaults.standard
        if let projectId = accountDefaults.value(forKey: account.account+"_"+Keys.selectedProjectId) {
            rootView.selectedProjectId = projectId as! Int
        }        
        
        //baseVc.navigationBar.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        baseVc.isNavigationBarHidden = true
        
        self.show(baseVc, sender: self)
    }
    
    @objc func onClick(_ sender : UIButton) {
        if sender == btnLogin {
            if let name = textName.text, let pwd = textPwd.text{
                doLogin(accountName: name, password: pwd)
            }else{
                print("用户名或密码不能为空2")
                ToastHelper.showGlobalToast(message: "用户名或密码不能为空")
                //UIApplication.shared.keyWindow?.tgc_makeToast(message: "用户名或密码不能为空！")
            }
            //gotoMainView()
            //self.performSegue(withIdentifier: "toMain", sender: self)
        }else if sender == btnRegister
        {
            self.performSegue(withIdentifier: "toRegister", sender: self)
        }else if sender == btnRefind{
            self.performSegue(withIdentifier: "toRefind", sender: self)
        }else if sender == btnAutoLogin{
            self.btnAutoLoginFlag = -self.btnAutoLoginFlag
            
        }else if sender == btnRememberPass{
            self.btnRememberPwdFlag = -self.btnRememberPwdFlag
        }
    }

    
    func doLogin(accountName:String, password:String){
        
        if accountName.isEmpty || password.isEmpty{
            print("用户名密码不能为空1")
            ToastHelper.showGlobalToast(message: "用户名或密码不能为空")
            return
        }
        
        
        ClientRequest.login(accountName: accountName, password: password){
            resAccount in
            if let resAccount = resAccount{
                //登陆失败的返回码是1
                if resAccount.retCode == 1{
                    
                    let error:String = resAccount.msg
                    let errorMsg:String = "登陆失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    //self.view.tgc_makeToast(message: errorMsg)
                    return
                }
                
                self.doRecordNameAndPwd(isRecord: self.btnRememberPwdFlag, name: accountName, password: password)
                print("\(resAccount.account) 已经登录")
                loginAccount = resAccount.account
                
                AddressUtils.getItems(projects: resAccount.projects)
                //print("projects = \(resAccount.projects)")
                self.gotoMainView(accountType: AccountType(rawValue: resAccount.role!)!, projects: resAccount.projects, account: resAccount)
            }else{
                
                print("登录失败！")
                ToastHelper.showGlobalToast(message: "数据获取失败，登录失败！")
            }
            
        }
    }
    
    func doRecordNameAndPwd(isRecord: Int, name: String, password: String){
        
        let accountDefaults = UserDefaults.standard
        accountDefaults.set(self.btnAutoLoginFlag, forKey: Keys.isAutoLogin)
        accountDefaults.set(self.btnRememberPwdFlag, forKey: Keys.isRemberPwd)
        if isRecord == UIButtonCheckState.btnChecked {
            accountDefaults.set(name, forKey: Keys.username)
            accountDefaults.set(password, forKey: Keys.password)
            
        }else if isRecord == UIButtonCheckState.btnUnchecked{
            accountDefaults.removeObject(forKey: Keys.username)
            accountDefaults.removeObject(forKey: Keys.password)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

