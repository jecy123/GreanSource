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
    @IBOutlet var btnRememberPass:UIButton!
    @IBOutlet var btnAutoLogin:UIButton!
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
        
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
            gotoMainView()
            //self.performSegue(withIdentifier: "toMain", sender: self)
        }else if sender == btnRegister
        {
            self.performSegue(withIdentifier: "toRegister", sender: self)
        }else if sender == btnRefind{
            self.performSegue(withIdentifier: "toRefind", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

