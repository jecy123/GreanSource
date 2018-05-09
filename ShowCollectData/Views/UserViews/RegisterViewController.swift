//
//  RegisterViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/11.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class RegisterViewController: UserBaseController {
    
    var menuNames:[String] = ["手机号：","验证码：","账  号：","邮箱地址：","用户姓名：","密  码：","确认密码：","用户类型：","环保局地址：","项目地址1：", "项目地址2：", "项目地址3："]
    let userTypes: [String] = ["环保部门人员","系统运维维人员"]
    
    var addressDic: [String : String] = [:]
    
    var newAccount: ShowAccount!
    
    func initViews(){
        self.titleString = "用户注册"
        
        self.itemSize = CGFloat(menuNames.count)
        
        self.itemPadding = 8
        
        let startX: CGFloat = itemStartX
        var startY: CGFloat = self.topImageHeight + self.titleMarginTop + self.titleHeight + 10
        
        let identiCodeY = startY + itemHeight + itemPadding
        
        var items: [TableItem] = [TableItem]()
        
        var rect:CGRect!
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[0], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX + 100, y: startY, width: itemWidth - 100, height: itemHeight)
        items.append(TableItem(name: menuNames[1], type: .typeText, frame: rect, ratio: 0.5))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[2], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[3], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[4], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[5], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[6], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        let userTypeY = startY
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[7], type: .typePopup, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[8], type: .typeText, frame: rect, ratio: 0.4))
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[9], type: .typeText, frame: rect, ratio: 0.4, withBottomLine: false, isHidden: true))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[10], type: .typeText, frame: rect, ratio: 0.4, withBottomLine: false, isHidden: true))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[11], type: .typeText, frame: rect, ratio: 0.4, withBottomLine: false, isHidden: true))
        
        self.tableItems = items
        
        let r = CGRect(x: startX + itemWidth * 0.4 + 5, y: userTypeY, width: itemWidth * 0.6 - 5, height: itemHeight)
        addDropBox(frame: r, userTypeMenus: userTypes)
        self.userTypeDropBox.setIndex(index: 0)
        
        addIdentiCodeButton(frame: CGRect(x: startX, y: identiCodeY, width: 100, height: itemHeight))
        
        startY += itemHeight + itemPadding
        self.confirm.frame.origin.y = startY + 10
        self.back.frame.origin.y = startY + 10
    }
    
    func initTableViews(){
        //密码和确认密码输入框小圆点加密显示
        self.tableItemViews[5].contentText.isSecureTextEntry = true
        self.tableItemViews[6].contentText.isSecureTextEntry = true
        
        self.tableItemViews[8].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[9].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[10].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        self.tableItemViews[11].contentText.addTarget(self, action: #selector(onAddressSelected(_:)), for: .editingDidBegin)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initTableViews()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableItemViews[9].isHidden = true
        self.tableItemViews[10].isHidden = true
        self.tableItemViews[11].isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkContent() -> Bool{
        
        guard let phone = self.tableItemViews[0].contentText.text, !phone.isEmpty else {
            ToastHelper.showGlobalToast(message: "手机号不能为空！")
            return false
        }
        guard StringUtils.isPhone(number: phone) else {
            ToastHelper.showGlobalToast(message: "手机号格式错误！")
            return false
        }
        guard let vcode = self.tableItemViews[1].contentText.text, !vcode.isEmpty else {
            ToastHelper.showGlobalToast(message: "验证码不能为空！")
            return false
        }
        guard self.checkVCode(vcode: vcode) else {
            return false
        }
        
        guard let account = self.tableItemViews[2].contentText.text, !account.isEmpty else {
            ToastHelper.showGlobalToast(message: "账号不能为空！")
            return false
        }
        guard let email = self.tableItemViews[3].contentText.text, !email.isEmpty else {
            ToastHelper.showGlobalToast(message: "邮箱地址不能为空！")
            return false
        }
        guard StringUtils.isEmail(email: email) else {
            ToastHelper.showGlobalToast(message: "邮箱地址格式错误！")
            return false
        }
        guard let userName = self.tableItemViews[4].contentText.text, !userName.isEmpty else {
            ToastHelper.showGlobalToast(message: "用户名不能为空！")
            return false
        }
        guard let password = self.tableItemViews[5].contentText.text, !password.isEmpty else {
            ToastHelper.showGlobalToast(message: "请输入密码!")
            return false
        }
        guard let rePassword = self.tableItemViews[6].contentText.text, !rePassword.isEmpty else {
            ToastHelper.showGlobalToast(message: "请再次输入密码!")
            return false
        }
        guard password == rePassword else {
            ToastHelper.showGlobalToast(message: "两次输入的密码不一致！")
            return false
        }
        guard self.userTypeDropBox.getIndex() != -1 else {
            ToastHelper.showGlobalToast(message: "请选择用户类型！")
            return false
        }
        
        newAccount = ShowAccount()
        newAccount.retCode = 0
        newAccount.status = 0
        newAccount.account = account
        newAccount.email = email
        newAccount.name = userName
        newAccount.password = password
        newAccount.vcode = vcode
        newAccount.phone = phone
        newAccount.locations = []
        
        let index = self.userTypeDropBox.getIndex()
        if index == 0 {
            
            newAccount.type = AccountType.EP.rawValue
            
            guard let address = self.tableItemViews[8].contentText.text, !address.isEmpty else {
                ToastHelper.showGlobalToast(message: "请选择环保地址！")
                return false
            }
            if let addressId = self.addressDic[address] {
                let location = ShowLocation(locationId: addressId, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            
        }else if index == 1 {
            
            newAccount.type = AccountType.mantainer.rawValue
            
            guard let address1 = self.tableItemViews[9].contentText.text, !address1.isEmpty else{
                ToastHelper.showGlobalToast(message: "请选择项目地址1！")
                return false
            }
            
            guard let address2 = self.tableItemViews[10].contentText.text, !address2.isEmpty else{
                ToastHelper.showGlobalToast(message: "请选择项目地址2！")
                return false
            }
            guard let address3 = self.tableItemViews[11].contentText.text, !address3.isEmpty else{
                ToastHelper.showGlobalToast(message: "请选择项目地址3！")
                return false
            }
            
            
            if let addressId1 = self.addressDic[address1] {
                let location = ShowLocation(locationId: addressId1, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            if let addressId2 = self.addressDic[address2] {
                let location = ShowLocation(locationId: addressId2, retCode: 0, msg: "")
                newAccount.locations.append(location)
            }
            if let addressId3 = self.addressDic[address3] {
                let location = ShowLocation(locationId: addressId3, retCode: 0, msg: "")
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
        
        print("account = \(newAccount.toJSON())")
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
        guard let text = self.tableItemViews[0].contentText.text, !text.isEmpty else{
            ToastHelper.showGlobalToast(message: "手机号不能为空！")
            print("手机号码选项为空")
            return
        }
        
        guard StringUtils.isPhone(number: text) else {
            ToastHelper.showGlobalToast(message: "手机号码格式错误！")
            print("手机号码格式错误！")
            return
        }
        self.startTimer(repeateCnts: 120)
        self.getVCode(phoneNumber: text, type: .typeRegister)
    }
    
    override func onDropBoxDidSelect(row: Int) {
        if row == 0 {
            self.tableItemViews[8].isHidden = false
            self.tableItemViews[9].isHidden = true
            self.tableItemViews[10].isHidden = true
            self.tableItemViews[11].isHidden = true
        }else if row == 1{
            self.tableItemViews[8].isHidden = true
            self.tableItemViews[9].isHidden = false
            self.tableItemViews[10].isHidden = false
            self.tableItemViews[11].isHidden = false
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

