//
//  ProjectModifyViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目信息修改界面
class ProjectModifyViewController: BasePageViewController {
    override var allProjects: [ShowProject]!{
        didSet{
            projectNames.removeAll()
            for project in allProjects {
                projectNames.append(project.projectName)
            }
            self.refreshNames()
        }
    }
    
    var isDataInit: Bool = false
    
    var projectNames:[String] = []
    
    var mProject: ShowProject = ShowProject()
    
    let titles = ["项目名称","项目类别","项目地址","运维人员姓名","运维人员联系方式"]
    
    let maxTitleCnt: CGFloat = 11
    var itemH: CGFloat{
        return (self.itemBgView.frame.height - 60) / self.maxTitleCnt
    }
    
    let capcityListNames = listToNames(list: capcityList)
    //let emissionStdNames = listToNames(list: emissionStd)
    
    
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
    
    override func refreshProject() {
        if !self.isDataInit {
            self.isDataInit = true
            
        }
        guard let project = self.selectedProject else {
            return
        }
        
        self.mProject = project
        
        self.tableItemViews[0].contentText.text = project.projectName
        var projectType:String = ""
        switch project.type {
        case ShowProject.PROJ_TYPE_SMART:
            projectType = "智慧运维系统"
        case ShowProject.PROJ_TYPE_SUNPOWER:
            projectType = "太阳能污水处理系统"
        case ShowProject.PROJ_TYPE_WATER:
            projectType = "水体太阳能曝气系统"
        default:
            break
        }
        self.tableItemViews[1].contentText.text = projectType
        self.tableItemViews[1].contentText.isEnabled = false
        self.tableItemViews[1].contentText.textColor = UIColor.gray
        
        self.tableItemViews[2].contentText.text = project.locationName
        self.tableItemViews[2].contentText.isEnabled = false
        self.tableItemViews[2].contentText.textColor = UIColor.gray
//
//        self.tableItemViews[3].contentText.text = project.street
//
//
//        self.tableItemViews[4].contentText.text = String(project.capability)+"D/T"
//
//        let c = project.capability
//        let index = getIndexOfCapcity(capcity: c!)
//        let deviceInfoStr = getDeviceCountMsg(index: index)
//        self.tableItemViews[5].contentTextView.text = deviceInfoStr
//
//
//        self.tableItemViews[6].contentText.text = emissionStdAccessment[project.emissionStandards]
        
        self.tableItemViews[3].contentText.text = project.workerName
        self.tableItemViews[4].contentText.text = project.workerPhone
        
        self.dropBoxViews[0].setBoxTitle(title: project.projectName)
        //self.dropBoxViews[1].setBoxTitle(title: String(project.capability)+"D/T")
        //self.dropBoxViews[2].setBoxTitle(title: emissionStdAccessment[project.emissionStandards])
        
    }
    
    
    func initTableItemView(){
        let x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = self.itemH
        
        var dropBoxY1: CGFloat = 0
        
        var tableItemFrame: CGRect!
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[0], type: .typeText, withBottomLine: true)
        dropBoxY1 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[1], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[2], type: .typeText, withBottomLine: true)
        
//        y += h
//        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
//        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[3], type: .typeText, withBottomLine: true)
//
//        y += h
//        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
//        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[4], type: .typeText, withBottomLine: true)
//
//        dropBoxY2 = y
//
//        y += h
//        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
//        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[5], type: .typeMultiLineText, withBottomLine: true)
//
//        y += h
//        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
//        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[6], type: .typeText, withBottomLine: true)
//
//        dropBoxY3 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[3], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.4, title: titles[4], type: .typeText, withBottomLine: true)
        
        
        
        var btnWidth: CGFloat = 100
        var btnHeight: CGFloat = 40
        
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667 {
            btnWidth = 67.5
            btnHeight = 27
        } else if screenH >= 667.0 && screenH < 736.0 {
            btnWidth = 82.5
            btnHeight = 33
        } else if screenH >= 736.0{
            btnWidth = 100
            btnHeight = 40
        }
        let rect = CGRect(x: (self.itemBgView.frame.width - btnWidth) / 2, y: self.itemBgView.frame.height - btnHeight - 10, width: btnWidth, height: btnHeight)
        addButton(buttonframe: rect, title: "确认修改", target: self, action: #selector(onConfirm(_:)), for: UIControlEvents.touchUpInside)
        
        
        //下拉列表和下拉按钮之间的偏移量计算
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY1, width: w * 0.7, height: h - 1), names: self.projectNames, dropBoxOffset: offset, dropBoxDidSelected: self.onProjectSelected)
        
    }
    
    func refreshNames() {
        guard dropBoxViews.count >= 1 else {
            return
        }
        self.dropBoxViews[0].refreshContentList(itemNames: self.projectNames)
    }
    
    @objc func onConfirm(_ sender: UIButton){
        if !isDataInit {
            ToastHelper.showGlobalToast(message: "请选择要修改的项目！")
            return
        }
//        if let text = self.tableItemViews[3].contentText.text, text.isEmpty {
//            ToastHelper.showGlobalToast(message: "请填写街道！")
//            return
//        }
        
        if let text = self.tableItemViews[3].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写运维人员姓名！")
            return
        }
        
        if let text = self.tableItemViews[4].contentText.text, text.isEmpty {
            ToastHelper.showGlobalToast(message: "请填写运维人员联系方式！")
            return
        }
        
        
        //mProject.street = self.tableItemViews[3].contentText.text
        mProject.workerName = self.tableItemViews[3].contentText.text
        mProject.workerPhone = self.tableItemViews[4].contentText.text
        ClientRequest.modifyProject(project: mProject){
            resProject in
            if let project = resProject{
                if project.retCode == 1 {
                    let error:String = project.msg
                    let errorMsg:String = "修改失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                print("修改成功！")
                ToastHelper.showGlobalToast(message: "运维人员更变成功！")
                
            }else{
                print("修改失败！")
                ToastHelper.showGlobalToast(message: "数据获取失败，修改失败！")
            }
        
        
        }
        
        //print("projectJSON = \(mProject.toJSON())")
        print("确认修改")
        
    }
    
    func onProjectSelected(row: Int){
        guard let projects = self.allProjects else {
            return
        }
        mProject = projects[row]
        print(projects[row].projectName + "已被选择")
        if let projectItem = AddressUtils.projectItemDic[projects[row].id]{
            self.addressNames = AddressUtils.queryLocationNames(itemNode: projectItem)
            self.selectedProject = projects[row]
        }
    }
    
    func onCapcityListSelected(row: Int){
        guard row >= 0 && row <= capcityList.count - 1 else{
            return
        }
        print("capability = \(capcityList[row])")
        mProject.capability = capcityList[row]
        //计算设备列表
        let deviceListMsg = getDeviceCountMsg(index: row)
        self.tableItemViews[5].contentTextView.text = deviceListMsg
        
    }
    
    func onEmissionStdSelected(row: Int){
        guard row >= 0 && row <= emissionStd.count - 1 else {
            return
        }
        
        print("std = \(emissionStd[row])")
        mProject.emissionStandards = emissionStd[row]
    }

}
