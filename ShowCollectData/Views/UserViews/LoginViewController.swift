//
//  ViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/10.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnLogin:UIButton!
    
    @IBOutlet var btnRegister:UIButton!
    @IBOutlet var btnRefind:UIButton!
    
    @IBOutlet weak var btnRememberPass:UIButton!
    @IBOutlet weak var btnAutoLogin:UIButton!
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPwd: UITextField!
    
    var btnRememberPwdFlag: Int!
    var btnAutoLoginFlag: Int!
    
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
        btnRememberPass.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        btnAutoLogin.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
        btnRememberPwdFlag = -1
        btnAutoLoginFlag = -1
    }
    
    func gotoMainView(){
        let titles = ["项目信息","运行状态","运行数据","标题四","标题五","标题六","标题七","标题八","标题九","标题十"]
        var pages = [BasePageViewController]()
        //let infoViewController = ProjectInfoViewController(title: titles[0])
        //pages.append(infoViewController)
        
        for title in titles{
            let page = ProjectInfoViewController(title:title)
            pages.append(page)
        }
        let pagesOptions:[UIViewPagerOption] = [
            .TitleBarHeight(50),
            .TitleBarBackgroudColor(ColorUtils.mainThemeColor),
            .TitleBarScrollType(UIViewPagerTitleBarScrollType.UIViewControllerMenuScroll),
            .TitleFont(UIFont.systemFont(ofSize: 15)),
            .TitleColor(UIColor.black),
            .TitleSelectedColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .TitleItemWidth(90),
            .IndicatorColor(ColorUtils.mainThemeColor/*#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)*/),
            .IndicatorHeight(5),
            .BottomlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            .BottomlineHeight(1),
            .TitleBarPosition(UIViewPageTitlePosition.bottom)
            
        ]
        
        let rootView:ISViewPagerContainer = ISViewPagerContainer()
        let baseVc = UINavigationController(rootViewController: rootView)
        
        rootView.titles = titles
        rootView.viewPages = pages
        rootView.options = pagesOptions
        // let pages = ISViewPagerContainer(titles: titles, viewPages:viewPages,options: pagesOptions)
        rootView.view.backgroundColor = UIColor.white
        
        //baseVc.navigationBar.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        baseVc.isNavigationBarHidden = true
        
        self.show(baseVc, sender: self)
    }
    
    @objc func onClick(_ sender : UIButton) {
        if sender == btnLogin {
            if let name = textName.text, let pwd = textPwd.text{
                
                if name.isEmpty || pwd.isEmpty{
                    print("用户名密码不能为空")
                    self.view.tgc_makeToast(message: "用户名或密码不能为空")
                    return
                }
                
                ClientRequest.login(accountName: name, password: pwd){
                    resAccount in
                    if let resAccount = resAccount{
                        //登陆失败的返回码是1
                        if resAccount.retCode == 1{
                            let errorMsg = "登陆失败：\(resAccount.msg)"
                            print(errorMsg)
                            UIApplication.shared.keyWindow?.tgc_makeToast(message: errorMsg)
                            //self.view.tgc_makeToast(message: errorMsg)
                            return
                        }
                        DispatchQueue.main.async {
                            self.gotoMainView()
                        }
                    }else{
                        
                        print("登录失败！")
                        self.view.tgc_makeToast(message: "数据获取失败，登录失败！")
                    }
                }
                
            }else{
                print("用户名或密码不能为空")
                self.view.tgc_makeToast(message: "用户名或密码不能为空！")
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
            if self.btnAutoLoginFlag == 1{
                btnAutoLogin.setImage(UIImage(named: "btn_check_on") , for: .normal)
            }else if self.btnAutoLoginFlag == -1{
                btnAutoLogin.setImage(UIImage(named: "btn_check_off") , for: .normal)
            }
            
        }else if sender == btnRememberPass{
            self.btnRememberPwdFlag = -self.btnRememberPwdFlag
            if self.btnRememberPwdFlag == 1{
                btnRememberPass.setImage(UIImage(named: "btn_check_on") , for: .normal)
            }else if self.btnRememberPwdFlag == -1{
                btnRememberPass.setImage(UIImage(named: "btn_check_off") , for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

