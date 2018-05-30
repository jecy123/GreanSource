//
//  InfoRefindViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//找回信息审核界面
class InfoRefindViewController: BasePageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addAuditingFragment()
        
        addSelectedButtons(buttonTitles: ["注册信息审核", "找回信息审核"], buttonWidth: 120, buttonHeight: 40)
        
    }
    
    func addAuditingFragment()  {
        
    }
    
    //两个按钮切换
    override func onSelectedButtonClicked(_ sender: UIButton) {
        super.onSelectedButtonClicked(sender)
        
        switch sender.tag {
        case 0:
            print("注册信息审核")
            doGetRegisterAuditList()
        case 1:
            print("找回信息审核")
            doGetFindUserAuditList()
        default:
            break
        }
    }
    
    override func refreshProject() {
        switch self.selectedButtonIndex {
        case 0:
            //获取注册信息审核
            doGetRegisterAuditList()
        case 1:
            //获取找回信息审核
            doGetFindUserAuditList()
        default:
            break
        }
    }
    
    //获取注册信息审核
    func doGetRegisterAuditList(){
        let account = ShowAccount()
        account.status = 10
        account.type = 0
        account.retCode = 0
        let page = ShowPage(c: account)
        page.retCode = 0
        
        
    }
    //获取找回信息审核
    func doGetFindUserAuditList(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
