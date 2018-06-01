//
//  UseRetrieveViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/15.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class UserRetrieveViewController: UserBaseController {
    
    let tableItemNames:[String] = ["用户姓名","用户类型","项目区域","输入原号码","输入新号码","验证码"]
    let userTypes: [String] = ["环保部门人员","系统运维维人员"]
    
    var locationDic: [String : String] = [:]
    
    var refindAccount: ShowAccount!
    
    func initViews(){
        self.titleString = "用户找回"
        self.itemPadding = 20
        self.itemSize = CGFloat(tableItemNames.count)
        
        let startX: CGFloat = self.itemStartX
        var startY: CGFloat = self.topImageHeight + self.titleMarginTop + self.titleHeight + 30
        
        let identiCodeY:CGFloat = startY + (itemHeight + itemPadding) * 5
        
        var items:[TableItem] = [TableItem]()
        
        var rect:CGRect
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tableItemNames[0], type: .typeText, frame: rect, ratio: 0.4))
        startY += itemHeight + itemPadding
        let dropBoxY = startY
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tableItemNames[1], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tableItemNames[2], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tableItemNames[3], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tableItemNames[4], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX + 100, y: startY, width: itemWidth - 100, height: itemHeight)
        items.append(TableItem(name: tableItemNames[5], type: .typeText, frame: rect, ratio: 0.4))
        
        self.tableItems = items
        
        let dropBoxFrame = CGRect(x: startX + itemWidth * 0.4 + 5, y: dropBoxY, width: itemWidth * 0.6 - 5, height: itemHeight)
        
        addDropBox(frame: dropBoxFrame, userTypeMenus: userTypes)
        
        addIdentiCodeButton(frame: CGRect(x: startX, y: identiCodeY, width: 100, height: itemHeight))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initTableViews()
        // Do any additional setup after loading the view.
    }
    
    func checkContent() -> Bool {
        guard let userName = self.tableItemViews[0].contentText.text, !userName.isEmpty else {
            ToastHelper.showGlobalToast(message: "用户名不能为空！")
            return false
        }
        let index = self.userTypeDropBox.getIndex()
        
        guard let address = self.tableItemViews[2].contentText.text, !address.isEmpty else {
            ToastHelper.showGlobalToast(message: "请选择项目地址！")
            return false
        }
        guard let oldPhone = self.tableItemViews[3].contentText.text, !oldPhone.isEmpty else {
            ToastHelper.showGlobalToast(message: "原手机号码不能为空！")
            return false
        }
        guard StringUtils.isPhone(number: oldPhone) else {
            ToastHelper.showGlobalToast(message: "原手机号格式错误！")
            return false
        }
        guard let newPhone = self.tableItemViews[4].contentText.text, !newPhone.isEmpty else {
            ToastHelper.showGlobalToast(message: "新手机号码不能为空！")
            return false
        }
        guard StringUtils.isPhone(number: newPhone) else {
            ToastHelper.showGlobalToast(message: "新手机号格式错误！")
            return false
        }
        guard let vcode = self.tableItemViews[5].contentText.text, !vcode.isEmpty else {
            ToastHelper.showGlobalToast(message: "验证码不能为空！")
            return false
        }
        guard self.checkVCode(vcode: vcode) else {
            return false
        }
        
        refindAccount = ShowAccount()
        refindAccount.name = userName
        refindAccount.oldPhone = oldPhone
        refindAccount.phone = newPhone
        refindAccount.vcode = vcode
        refindAccount.status = 0
        if index == 0 {
            refindAccount.type = AccountType.EP.rawValue
        }else if index == 1 {
            refindAccount.type = AccountType.mantainer.rawValue
        }
        
        refindAccount.locations = []
        if let locationId = locationDic[address] {
            let location = ShowLocation(locationId: locationId, retCode: 0, msg: "")
            refindAccount.locations.append(location)
        }
        return true
    }
    
    
    override func onConfirmButtonTapped(_ sender: Any) {
        guard checkContent() else {
            print("请填写完整的信息！")
            return
        }
        //print("account = \(self.refindAccount.toJSON())")
        ClientRequest.refindAccount(showAccount: self.refindAccount){
            resResponse in
            if let resResponse = resResponse {
                //失败的返回码是1
                if resResponse.retCode == 1{
                    
                    let error:String = resResponse.msg
                    let errorMsg:String = "找回失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    //self.view.tgc_makeToast(message: errorMsg)
                    return
                }
                print("找回成功！")
                if let msg = resResponse.msg {
                    ToastHelper.showGlobalToast(message: msg)
                }
            }else{
                print("找回失败！")
                ToastHelper.showGlobalToast(message: "找回失败！")
            }
        }
        
    }
    
    override func onIdentiCodeObtain(_ sender: Any){
        print("获取验证码")
        guard let text = self.tableItemViews[4].contentText.text, !text.isEmpty else{
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
        self.getVCode(phoneNumber: text, type: .typeRetrieve)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableViews(){
        self.tableItemViews[2].contentText.addTarget(self, action: #selector(onAddressChoosed(_:)) , for: .editingDidBegin)
        self.userTypeDropBox.setIndex(index: 0)
    }
    
    override func onDropBoxDidSelect(row: Int) {
        if row == 0 {
            self.tableItemViews[2].nameLabel.text = "项目区域"
        }else if row == 1 {
            self.tableItemViews[2].nameLabel.text = "项目地址"
        }
    }
    
    @objc func onAddressChoosed(_ sender: UITextField) {
        let addressPickerView = AddressPickerView(provinceItems: AddressUtils.addressItem.provinceItem, height: 200)
        addressPickerView.delegate = self
        addressPickerView.sender = sender
        addressPickerView.show()
    }

}

extension UserRetrieveViewController: AddressPickerViewDelegate {
    func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?) {
        guard let textField = sender as? UITextField else { return }
        textField.resignFirstResponder()
        textField.endEditing(true)
    }
    func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String) {
        guard let textField = sender as? UITextField else { return }
        textField.text = locationName
        
        self.locationDic[locationName] = locationId
    }
}
