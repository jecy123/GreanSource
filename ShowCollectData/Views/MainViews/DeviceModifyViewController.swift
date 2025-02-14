//
//  DeviceModifyViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//设备信息修改界面
class DeviceModifyViewController: BasePageViewController {
    
    override var allProjects: [ShowProject]!{
        didSet{
            projectNames.removeAll()
            for project in allProjects {
                projectNames.append(project.projectName)
            }
            self.refreshNames()
        }
    }
    
    var mProject: ShowProject = ShowProject()
    
    var isDataInit: Bool = false
    
    var deviceInfoListFragment: DeviceInfoListFragment!
    
    var projectNames:[String] = []
    let titles = ["项目名称","项目类别","项目地址"]
    let maxTitleCnt: CGFloat = 11
    var itemH: CGFloat{
        return (self.itemBgView.frame.height - 60) / self.maxTitleCnt
    }
    
    var addButton: UIButton!
    let addButtonWidth: CGFloat = 60
    let addButtonHeight: CGFloat = 30
    
    var addButtonYOffset: CGFloat {
        return (self.itemH - self.addButtonHeight) / 2
    }
    
    var addButtonX: CGFloat {
        return (self.itemBgView.frame.width - addButtonWidth) / 2
    }
    var addButtonY: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initTableItems()
        //initAddButton()
        addDeviceInfoListFragment()
    }
    
    
    func addDeviceInfoListFragment() {
        let fragmentY: CGFloat = CGFloat(self.titles.count) * self.itemH
        let fragmentX: CGFloat = 0
        let fragmentH: CGFloat = itemBgHeight - fragmentY - 50
        let fragmetnW: CGFloat = itemBgWidth

        let fragmentFrame = CGRect(x: fragmentX, y: fragmentY, width: fragmetnW, height: fragmentH)
        self.deviceInfoListFragment = DeviceInfoListFragment(frame: fragmentFrame, tableItemHeight: itemH)
        self.itemBgView.addSubview(deviceInfoListFragment)
    }
    
//    func initAddButton(){
//        addButtonY =  CGFloat(self.titles.count) * self.itemH + self.addButtonYOffset
//        let addButtonFrame = CGRect(x: addButtonX, y: addButtonY, width: addButtonWidth, height: addButtonHeight)
//        addButton = UIButton(frame: addButtonFrame)
//        addButton.setTitle("新增", for: .normal)
//        addButton.setTitleColor(UIColor.white, for: .normal)
//        addButton.setTitleColor(ColorUtils.itemTitleViewBgColor, for: .highlighted)
//        addButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
//        addButton.layer.cornerRadius = 4
//        addButton.addTarget(self, action: #selector(onAddButtonClicked(_:)), for: .touchUpInside)
//        self.itemBgView.addSubview(addButton)
//    }
    
    func initTableItems(){
        let x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = self.itemH
        
        var dropBoxY: CGFloat = 0
        
        var tableItemFrame:CGRect!
        
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[0], type: .typeText, withBottomLine: true)
        dropBoxY = y
        y += h
        
        
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[1], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[2], type: .typeText, withBottomLine: true)
        
        //添加按钮
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
        
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY, width: w * 0.7, height: h - 1), names: self.projectNames, dropBoxOffset: offset, dropBoxDidSelected: self.onProjectSelected)
    }
    
    func refreshNames() {
        guard self.dropBoxViews.count >= 1 else{
            return
        }
        self.dropBoxViews[0].refreshContentList(itemNames: self.projectNames)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            projectType = "智能运维系统"
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
        
        self.dropBoxViews[0].setBoxTitle(title: project.projectName)
        
        self.doGetDevicesInfoList()
        self.deviceInfoListFragment.resetDeviceList()
    }
    
    func doGetDevicesInfoList() {
        ClientRequest.getDeviceList(projectId: self.mProject.id) {
            resDevices in
            if let resDevices = resDevices{
                self.deviceInfoListFragment.mDevices = resDevices
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
    }
    
    @objc func onConfirm(_ sender: UIButton){
        print("修改设备")
        
        guard let projcet = self.selectedProject else {
            ToastHelper.showGlobalToast(message: "未选中项目！")
            return
        }
        if self.deviceInfoListFragment.refreshDevices(projectId: projcet.id, locationId: projcet.locationId) {
            //print("Add Count = \(self.deviceInfoListFragment.mAddDevices.count)")
            //print("Del Count = \(self.deviceInfoListFragment.mDelDevices.count)")
            
            let commitBatch = ShowCommitBatch(retCode: 0, msg: "success")
            commitBatch.batchAdds = self.deviceInfoListFragment.mAddDevices
            commitBatch.batchDels = self.deviceInfoListFragment.mDelDevices
            
            ClientRequest.modifyDevices(jsonData: commitBatch.toJSON()) { (resData) in
                if let data = resData {
                    if data.retCode == 1 {
                        let error:String = data.msg
                        let errorMsg:String = "修改失败：" + error
                        print(errorMsg)
                        ToastHelper.showGlobalToast(message: errorMsg)
                        return
                    }
                    print("修改成功！")
                    ToastHelper.showGlobalToast(message: "设备信息修改成功！")
                    //修改完成后刷新界面
                    self.refreshProject()
                    
                    
                }else{
                    print("设备信息修改失败！")
                    ToastHelper.showGlobalToast(message: "获取数据失败，设备信息修改失败！")
                }
            }
            
            
        } else {
            print("修改失败！")
            ToastHelper.showGlobalToast(message: "请填写完整的信息！")
        }
        
    }
    
    @objc func onAddButtonClicked(_ sender: UIButton){
        
        let x: CGFloat = 0
        let y: CGFloat = self.addButtonY - self.addButtonYOffset
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = self.itemH
        let frame = CGRect(x: x, y: y, width: w, height: h)
        addTableItemView(tableFrame: frame, titleRatio: 0.3, title: "设备名", type: .typeRemovableText, withBottomLine: true, delegate: self)
        
        self.addButtonY = self.addButtonY + self.itemH
        self.addButton.frame.origin.y = self.addButtonY
    }
    
}

extension DeviceModifyViewController: TableItemViewDelegate {
    func onDeleteBtnClicked(sender tableItem: TableItemView) {
        print("tag = \(tableItem.tag)")
        self.removeTableItemView(at: tableItem.tag)
        
        self.addButtonY = self.addButtonY - self.itemH
        self.addButton.frame.origin.y = self.addButtonY
    }
}
