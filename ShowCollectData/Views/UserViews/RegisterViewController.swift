//
//  RegisterViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/11.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class RegisterViewController: UserBaseController {
    
    //var menuNames:[String] = ["手机号：","验证码：","账  号：","邮箱地址：","用户姓名：","密  码：","确认密码：","用户类型：","环保局地址：","项目地址1：", "项目地址2：", "项目地址3："]
    var menuNames:[String] = ["*账  号：","*密  码：","*确认密码：","*用户姓名：","*用户类型：","*项目地址：","*项目地址1：", "项目地址2：", " 项目地址3：","*手机号：","*验证码："]
    let userTypes: [String] = ["环保监督人员","系统运维人员"]
    
    var addressDic: [String : String] = [:]
    
    var newAccount: ShowAccount!
    
    var telY1: CGFloat!
    var telY2: CGFloat!
    
    func initViews(){
        self.titleString = "用户注册"
        
        self.itemSize = CGFloat(menuNames.count)
        
        let screenH = UIScreen.main.bounds.height
        
        if screenH >= 568.0 && screenH < 667 {
            self.itemPadding = 4
        } else if screenH >= 667.0 && screenH < 736.0 {
             self.itemPadding = 8
        } else if screenH >= 736.0{
            self.itemPadding = 12
        }
        
        let startX: CGFloat = itemStartX - 10
        let itemnewWidth = itemWidth + 10
        
        var startY: CGFloat = self.topImageHeight + self.titleMarginTop + self.titleHeight + 10
        
        
        var items: [TableItem] = [TableItem]()
        
        var rect:CGRect!
        
        
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[0], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[1], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[2], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[3], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        //用户类型
        startY += itemHeight + itemPadding
        let userTypeY = startY
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[4], type: .typePopupRight, frame: rect, ratio: 0.3))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[5], type: .typeTextRight, frame: rect, ratio: 0.3))
        //“项目地址”和“项目地址1”共用同一个y
        //startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[6], type: .typeTextRight, frame: rect, ratio: 0.3, withBottomLine: false, isHidden: true))
        
        startY += itemHeight + itemPadding
        
        self.telY1 = startY
        
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[7], type: .typeTextRight, frame: rect, ratio: 0.3, withBottomLine: false, isHidden: true))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[8], type: .typeTextRight, frame: rect, ratio: 0.3, withBottomLine: false, isHidden: true))
        
//        startY += itemHeight + itemPadding
//        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
//        items.append(TableItem(name: menuNames[9], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        self.telY2 = startY
        rect = CGRect(x: startX, y: startY, width: itemnewWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[9], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        startY += itemHeight + itemPadding
        
        rect = CGRect(x: startX , y: startY, width: itemnewWidth , height: itemHeight)
        //rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[10], type: .typeTextRight, frame: rect, ratio: 0.3))
        
        self.tableItems = items
        
        let r = CGRect(x: startX + itemnewWidth * 0.3 + 5, y: userTypeY, width: itemnewWidth * 0.7 - 5, height: itemHeight)
        addDropBox(frame: r, userTypeMenus: userTypes)
        self.userTypeDropBox.setIndex(index: 0)
        
        
        startY += itemHeight + itemPadding
        addIdentiCodeButton(frame: CGRect(x: itemnewWidth - 90, y: startY, width: 100, height: itemHeight))
      
        startY += itemHeight + itemPadding
        self.confirm.frame.origin.y = startY + 10
        self.back.frame.origin.y = startY + 10
    }
    
    func initTableViews(){
        self.tableItemViews[0].contentText.placeholder = "英文或数字不超过12个字符"
        //密码和确认密码输入框小圆点加密显示
        self.tableItemViews[1].contentText.isSecureTextEntry = true
        self.tableItemViews[1].contentText.placeholder = "英文或数字6-12个字符"
        
        self.tableItemViews[2].contentText.isSecureTextEntry = true
        
        self.tableItemViews[3].contentText.placeholder = "务必填写真实姓名"
        
        self.tableItemViews[5].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[6].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[7].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[8].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initTableViews()

        // Do any additional setup after loading the view.
    }
    
    func adjustLayout(userType: AccountType){
        //环境监督人员
        if userType == .EP {
            self.tableItemViews[5].isHidden = false
            self.tableItemViews[6].isHidden = true
            self.tableItemViews[7].isHidden = true
            self.tableItemViews[8].isHidden = true
            
            //修改第9、10项（手机号，验证码）选项以及获取验证码按钮的高度
            self.tableItemViews[9].frame.origin.y = telY1
            self.tableItemViews[10].frame.origin.y = telY1 + itemHeight + itemPadding
            self.identiCodeConfirm.frame.origin.y = telY1 + itemHeight + itemPadding + itemHeight + itemPadding
        }
        else if userType == .mantainer {
            self.tableItemViews[5].isHidden = true
            self.tableItemViews[6].isHidden = false
            self.tableItemViews[7].isHidden = false
            self.tableItemViews[8].isHidden = false
            
            //修改第9、10项（手机号，验证码）选项以及获取验证码按钮的高度
            self.tableItemViews[9].frame.origin.y = telY2
            self.tableItemViews[10].frame.origin.y = telY2 + itemHeight + itemPadding
            self.identiCodeConfirm.frame.origin.y = telY2 + itemHeight + itemPadding + itemHeight + itemPadding
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        adjustLayout(userType: .EP)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkContent() -> Bool{
        
        
        guard let account = self.tableItemViews[0].contentText.text, !account.isEmpty else {
            ToastHelper.showGlobalToast(message: "账号不能为空！")
            return false
        }
        guard StringUtils.isCharacterAndNumber(string: account, minLen: 1, maxLen: 12) else {
            ToastHelper.showGlobalToast(message: "账号格式错误！")
            return false
        }
        guard let password = self.tableItemViews[1].contentText.text, !password.isEmpty else {
            ToastHelper.showGlobalToast(message: "请输入密码!")
            return false
        }
        
        guard StringUtils.isCharacterAndNumber(string: password, minLen: 6, maxLen: 12) else {
            ToastHelper.showGlobalToast(message: "密码格式错误！")
            return false
        }
        
        guard let rePassword = self.tableItemViews[2].contentText.text, !rePassword.isEmpty else {
            ToastHelper.showGlobalToast(message: "请再次输入密码!")
            return false
        }
        guard password == rePassword else {
            ToastHelper.showGlobalToast(message: "两次输入的密码不一致！")
            return false
        }
        guard let userName = self.tableItemViews[3].contentText.text, !userName.isEmpty else {
            ToastHelper.showGlobalToast(message: "用户名不能为空！")
            return false
        }
        guard self.userTypeDropBox.getIndex() != -1 else {
            ToastHelper.showGlobalToast(message: "请选择用户类型！")
            return false
        }
        
        guard let phone = self.tableItemViews[9].contentText.text, !phone.isEmpty else {
            ToastHelper.showGlobalToast(message: "手机号不能为空！")
            return false
        }
        guard StringUtils.isPhone(number: phone) else {
            ToastHelper.showGlobalToast(message: "手机号格式错误！")
            return false
        }
        guard let vcode = self.tableItemViews[10].contentText.text, !vcode.isEmpty else {
            ToastHelper.showGlobalToast(message: "验证码不能为空！")
            return false
        }
        guard self.checkVCode(vcode: vcode) else {
            return false
        }
        
        newAccount = ShowAccount()
        newAccount.retCode = 0
        newAccount.status = 0
        newAccount.account = account
        newAccount.name = userName
        newAccount.password = password
        newAccount.vcode = vcode
        newAccount.phone = phone
        newAccount.locations = []
        
        let index = self.userTypeDropBox.getIndex()
        if index == 0 {
            
            newAccount.type = AccountType.EP.rawValue
            
            guard let address = self.tableItemViews[5].contentText.text, !address.isEmpty else {
                ToastHelper.showGlobalToast(message: "请选择环保地址！")
                return false
            }
            if let addressId = self.addressDic[address] {
                let location = ShowLocation(locationId: addressId, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            
        }else if index == 1 {
            
            newAccount.type = AccountType.mantainer.rawValue
            
            guard let address1 = self.tableItemViews[6].contentText.text, !address1.isEmpty else{
                ToastHelper.showGlobalToast(message: "请选择项目地址1！")
                return false
            }
            
            if let addressId1 = self.addressDic[address1] {
                let location = ShowLocation(locationId: addressId1, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            
            
            if let address2 = self.tableItemViews[7].contentText.text , !address2.isEmpty {
                let addressId2 = self.addressDic[address2]
                let location = ShowLocation(locationId: addressId2!, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            
            
            if let address3 = self.tableItemViews[8].contentText.text ,!address3.isEmpty{
                let addressId3 = self.addressDic[address3]
                let location = ShowLocation(locationId: addressId3!, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            
        }
        
        return true
    }
    
    override func onConfirmButtonTapped(_ sender: Any) {
        guard self.checkContent() else {
            print("检测未通过 ！")
            return
        }
        
   //print("account = \(newAccount.toJSON())")
        print("确认按钮按下")
        
        ClientRequest.registerAccount(showAccount: self.newAccount){
            resResponse in
            if let resResponse = resResponse{
                //失败的返回码是1
                if resResponse.retCode == 1{
                    
                    let error:String = resResponse.msg
                    let errorMsg:String = "注册失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    //self.view.tgc_makeToast(message: errorMsg)
                    return
                }
                print("注册成功！")
                if let msg = resResponse.msg {
                    ToastHelper.showGlobalToast(message: msg)
                }
            }else{
                
                print("注册失败！")
                ToastHelper.showGlobalToast(message: "注册失败！")
            }
            
        }
        
    }
    
    override func onIdentiCodeObtain(_ sender: Any) {
        guard let text = self.tableItemViews[9].contentText.text, !text.isEmpty else{
            ToastHelper.showGlobalToast(message: "手机号不能为空！")
            print("手机号码选项为空")
            return
        }
        //print("text = \(text)");
        guard StringUtils.isPhone(number: text) else {
            ToastHelper.showGlobalToast(message: "手机号码格式错误！")
            print("手机号码格式错误！")
            return
        }
        self.startTimer(repeateCnts: 120)
        self.getVCode(phoneNumber: text, type: .typeRegister)
    }
    
    override func onDropBoxDidSelect(row: Int) {
        //环保人员
        if row == 0 {
            adjustLayout(userType: .EP)
        }
        //维护人员
        else if row == 1{
            adjustLayout(userType: .mantainer)
        }
        
    }
    
    @objc func onAddressSelected(_ sender: UITextField){
        let addressPickerView = AddressPickerView(provinceItems: AddressUtils.addressItem.provinceItem, height: 200)
        addressPickerView.delegate = self
        addressPickerView.sender = sender
        addressPickerView.show()
    }
}

extension RegisterViewController: AddressPickerViewDelegate{
    func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?) {
        guard let textField = sender as? UITextField else { return  }
        textField.resignFirstResponder()
        textField.endEditing(true)
    }
    
    func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String) {
        guard let textField = sender as? UITextField else{
            return
        }
        textField.text = locationName
        self.addressDic[locationName] = locationId
    }
    
}

