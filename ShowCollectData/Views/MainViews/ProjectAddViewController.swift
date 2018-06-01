//
//  ProjectAddViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目添加界面
class ProjectAddViewController: BasePageViewController{

    let titles = ["项目名称","项目类别","项目地址","街道","设计处理量","设备列表","排放标准","运维人员姓名","运维人员联系方式"]
    let projectTypeNames = systemNames
    let capcityListNames = listToNames(list: capcityList)
    
    var newProject: ShowProject = ShowProject()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initTableItemView()
        
    }
    
    func initTableItemView(){
        let x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = (self.itemBgView.frame.height - 60) / CGFloat(self.titles.count)
        
        var dropBoxY1: CGFloat = 0
        var dropBoxY2: CGFloat = 0
        var dropBoxY3: CGFloat = 0
        
        var tableItemFrame: CGRect!
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[0], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[1], type: .typeText, withBottomLine: true)
        dropBoxY1 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[2], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[3], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[4], type: .typeText, withBottomLine: true)
        
        dropBoxY2 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[5], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[6], type: .typeText, withBottomLine: true)
        
        dropBoxY3 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[7], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.4, title: titles[8], type: .typeText, withBottomLine: true)
        
        let btnWidth: CGFloat = 100
        let btnHeight: CGFloat = 40
        let rect = CGRect(x: (self.itemBgView.frame.width - btnWidth) / 2, y: self.itemBgView.frame.height - btnHeight - 10, width: btnWidth, height: btnHeight)
        addButton(buttonframe: rect, title: "确认添加", target: self, action: #selector(onConfirm(_:)), for: UIControlEvents.touchUpInside)
        

        //下拉列表和下拉按钮之间的偏移量计算
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY1, width: w * 0.7, height: h - 1), names: self.projectTypeNames, dropBoxOffset: offset, dropBoxDidSelected: self.onProjectTypeSelected)
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY2, width: w * 0.7, height: h - 1), names: self.capcityListNames, dropBoxOffset: offset, dropBoxDidSelected: self.onCapcityListSelected)
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY3, width: w * 0.7, height: h - 1), names:emissionStdNames, dropBoxOffset: offset, dropBoxDidSelected: self.onEmissionStdSelected)
        
        self.tableItemViews[2].contentText.addTarget(self, action: #selector(onAddressItemClicked(_:)), for: UIControlEvents.editingDidBegin)
        self.tableItemViews[5].contentText.isEnabled = false
        self.tableItemViews[5].contentText.adjustsFontSizeToFitWidth = true
        self.tableItemViews[5].contentText.textColor = UIColor.gray
    }
    
    @objc func onAddressItemClicked(_ sender: UITextField){
        let addressPickerView = AddressPickerView(provinceItems: AddressUtils.addressItem.provinceItem, height: 200)
        addressPickerView.delegate = self
        addressPickerView.show()
    }
    
    @objc func onConfirm(_ sender: UIButton){
        if let text = self.tableItemViews[0].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写项目名！")
            return
        }
        if self.dropBoxViews[0].getIndex() == -1 {
            ToastHelper.showGlobalToast(message: "请选择项目类型")
            return
        }
        
        if let text = self.tableItemViews[2].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请选择地址")
            return
        }
        if let text = self.tableItemViews[3].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写街道！")
            return
        }
        
        if self.dropBoxViews[1].getIndex() == -1 {
            ToastHelper.showGlobalToast(message: "请选择设计处理量")
            return
        }
        if self.dropBoxViews[2].getIndex() == -1 {
            ToastHelper.showGlobalToast(message: "请选择排放标准")
            return
        }
        
        
        if let text = self.tableItemViews[7].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写运维人员姓名！")
            return
        }
        
        if let text = self.tableItemViews[8].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写运维人员联系方式！")
            return
        }
        
        self.newProject.projectName = self.tableItemViews[0].contentText.text
        self.newProject.street = self.tableItemViews[3].contentText.text
        self.newProject.workerName = self.tableItemViews[7].contentText.text
        self.newProject.workerPhone = self.tableItemViews[8].contentText.text
        
        ClientRequest.addProject(project: newProject){
            resProject in
            if let project = resProject{
                if project.retCode == 1{
                    let err: String = project.msg
                    let errMag = "添加失败：" + err
                    print(errMag)
                    ToastHelper.showGlobalToast(message: errMag)
                    return
                }
                print("添加成功")
                ToastHelper.showGlobalToast(message: "项目添加成功！")
            }else{
                print("添加失败！")
                ToastHelper.showGlobalToast(message: "数据获取失败， 添加失败！")
            }
        }
        print("确认添加")
        //print(newProject.toJSON())
        
    }
    
    func onProjectTypeSelected(row: Int){
        print("row = \(row)")
        guard row >= 0 && row <= ShowProject.projectType.count - 1 else{
            return
        }
        newProject.type = ShowProject.projectType[row]
        
    }
    
    func onCapcityListSelected(row: Int){
        guard row >= 0 && row <= capcityList.count - 1 else{
            return
        }
        print("capability = \(capcityList[row])")
        newProject.capability = capcityList[row]
        //计算设备列表
        let deviceListMsg = getDeviceCountMsg(index: row)
        self.tableItemViews[5].contentText.text = deviceListMsg
    }
    
    func onEmissionStdSelected(row: Int){
        guard row >= 0 && row <= emissionStd.count - 1 else{
            return
        }
        print("emissionStd = \(emissionStd[row])")
        newProject.emissionStandards = emissionStd[row]
    }

}

extension ProjectAddViewController: AddressPickerViewDelegate{
    func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String) {
        print("locationId = \(locationId)")
        print("locationName = \(locationName)")
        newProject.locationId = locationId
        newProject.locationName = locationName
        self.tableItemViews[2].contentText.text = locationName
    }
    
    func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?){
        //收起键盘
        self.tableItemViews[2].contentText.resignFirstResponder()
        self.tableItemViews[2].contentText.endEditing(true)
    }
}
