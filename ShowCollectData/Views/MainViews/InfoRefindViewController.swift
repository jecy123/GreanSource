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

    var auditingFragment: AuditingFragment!
    var accountList: [ShowAccount]!
    
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
        let frame = CGRect(x: 0, y: 0, width: itemBgWidth, height: itemBgHeight - 50)
        auditingFragment = AuditingFragment(frame: frame)
        auditingFragment.delegate = self
        self.itemBgView.addSubview(auditingFragment)
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
        
        ClientRequest.getAuditList(commandCode: ConnectAPI.ACCOUNT_AUDIT_QUERY_COMMAND, responseCode: ConnectAPI.ACCOUNT_AUDIT_QUERY_RESPONSE, pageJson: page.toJSON()) {
            resPage in
            if let resPage = resPage {
                //失败的返回码是1
                if resPage.retCode == 1{
                    let error:String = resPage.msg
                    let errorMsg:String = "更新失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                
                self.accountList = resPage.resList
                
                self.auditingFragment.mAccounts = resPage.resList
                
                print("成功获取到审核数据")
            }else{
                print("获取失败！")
                
                ToastHelper.showGlobalToast(message: "数据获取失败！")
            }
        }
        
    }
    //获取找回信息审核
    func doGetFindUserAuditList(){
        let page = ShowPage()
        page.retCode = 0
        
        ClientRequest.getAuditList(commandCode: ConnectAPI.ACCOUNT_FINDBACK_QUERY_COMMAND, responseCode: ConnectAPI.ACCOUNT_FINDBACK_QUERY_RESPONSE, pageJson: page.toJSON()) {
            resPage in
            if let resPage = resPage {
                //失败的返回码是1
                if resPage.retCode == 1{
                    let error:String = resPage.msg
                    let errorMsg:String = "获取审核列表失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                
                self.accountList = resPage.resList
                self.auditingFragment.mAccounts = resPage.resList
                
                print("成功获取到审核数据")
            }else{
                print("获取失败！")
                
                ToastHelper.showGlobalToast(message: "数据获取失败！")
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension InfoRefindViewController: AuditingFragmentDelegate {
    
    func doAudit(jsonData: String, commandCode: Int32, responseCode: Int32){
        ClientRequest.sendAcceptAndRejectAudit(commandCode: commandCode, responseCode: responseCode, pageJson: jsonData) {
            res in
            if let response = res{
                //失败的返回码是1
                if response.retCode == 1{
                    let error:String = response.msg
                    let errorMsg:String = "审核失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                print("审核成功")
                ToastHelper.showGlobalToast(message: response.msg)
                //self.refreshProject()
            }else{
                print("审核失败！")
                ToastHelper.showGlobalToast(message: "数据获取失败！")
                
            }
            
        }
    }
    
    func doAcceptAudit(cell id: Int) {
        print("第" + String(id) + "项审核通过！")
        guard id >= 0 && id <= self.accountList.count-1 else {
            return
        }
        let account = self.accountList[id]
        account.status = AuditStatus.agree.rawValue
        //注册审核
        if selectedButtonIndex == 0 {
            doAudit(jsonData: account.toJSON(), commandCode: ConnectAPI.ACCOUNT_AUDIT_COMMAND, responseCode: ConnectAPI.ACCOUNT_AUDIT_RESPONSE)
        }
        //找回审核
        else if selectedButtonIndex == 1 {
            doAudit(jsonData: account.toJSON(), commandCode: ConnectAPI.ACCOUNT_FINDBACK_AUDIT_COMMAND, responseCode: ConnectAPI.ACCOUNT_FINDBACK_AUDIT_RESPONSE)
            
        }
    }
    
    func doRejectAudit(cell id: Int) {
        print("第" + String(id) + "项审核驳回！")
        guard id >= 0 && id <= self.accountList.count-1 else {
            return
        }
        
        let account = self.accountList[id]
        account.status = AuditStatus.reject.rawValue
        //注册审核
        if selectedButtonIndex == 0 {
            doAudit(jsonData: account.toJSON(), commandCode: ConnectAPI.ACCOUNT_AUDIT_COMMAND, responseCode: ConnectAPI.ACCOUNT_AUDIT_RESPONSE)
        }
            //找回审核
        else if selectedButtonIndex == 1 {
            doAudit(jsonData: account.toJSON(), commandCode: ConnectAPI.ACCOUNT_FINDBACK_AUDIT_COMMAND, responseCode: ConnectAPI.ACCOUNT_FINDBACK_AUDIT_RESPONSE)
            
        }
        
    }
}
