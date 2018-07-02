//
//  ProjectAddViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

enum ProjectAddFragmentType {
    case solar
    case water
}

//项目添加界面
class ProjectAddViewController: BasePageViewController{

    let titles = ["项目名称","项目类别","项目地址","街道","设计处理量","设备列表","排放标准","运维人员姓名","运维人员联系方式"]
    let projectTypeNames = systemNames
    let capcityListNames = listToNames(list: capcityList)
    
    var scrollBgView: UIScrollView!
    var confirmButton: UIButton!
    
    var solarSysFragment: SolarSysFragment!
    var waterSysFragment: WaterSysFragment!
    
    let maxTitleCnt: CGFloat = 11
    var itemH: CGFloat{
        return (self.itemBgView.frame.height - 60) / self.maxTitleCnt
    }
    
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
        initScrollView()
        
        //initTableItemView()
        
    }
    
    func initScrollView() {
        let x: CGFloat = 0
        let y: CGFloat = 0
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = self.itemBgView.frame.height
        
        scrollBgView = UIScrollView(frame: CGRect(x: x, y: y, width: w, height: h))
        self.itemBgView.addSubview(scrollBgView)
        
        addSolarSysFrgment()
        addWaterSysFrgment()
        
        addConfirmButton()
        
        addProjectTypeList()
        
        
        switchView(type: .solar)
    }
    
    func dropBoxWillShowOrHide(isShow: Bool) {
        if isShow {
            let offset = CGPoint(x: self.scrollBgView.contentOffset.x, y: -self.scrollBgView.contentOffset.y)
            for dropBoxView in solarSysFragment.dropBoxViews {
                dropBoxView.showOffset = offset
            }
            self.dropBoxViews[0].showOffset = offset
        }
    }
    
    func addSolarSysFrgment()  {
        let height = (itemH + 1) * 16
        
        //下拉列表和下拉按钮之间的偏移量计算
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        solarSysFragment = SolarSysFragment(parentVC: self, frame: CGRect(x: 0, y: 0, width: self.itemBgWidth, height: height), itemH: itemH, dropBoxOffset: offset)
        
        for dropBoxView in solarSysFragment.dropBoxViews {
            dropBoxView.willShowOrHideBoxListHandler = dropBoxWillShowOrHide
        }
        
        scrollBgView.addSubview(solarSysFragment)
    }
    
    
    
    func addWaterSysFrgment()  {
        let height = (itemH + 1) * 12
        waterSysFragment = WaterSysFragment(parentVC: self, frame: CGRect(x: 0, y: 0, width: self.itemBgWidth, height: height), itemH: itemH)
        scrollBgView.addSubview(waterSysFragment)
    }
    
    func addProjectTypeList(){
        //下拉列表和下拉按钮之间的偏移量计算
        let x = itemBgWidth * 0.4
        let w = itemBgWidth * 0.6
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        addDropBox(dropBoxFrame: CGRect(x: x, y: itemH + 1, width: w, height: itemH - 1), names: self.projectTypeNames, dropBoxOffset: offset, dropBoxDidSelected: self.onProjectTypeSelected)
        
        self.dropBoxViews[0].willShowOrHideBoxListHandler = self.dropBoxWillShowOrHide
    }
    
    func addConfirmButton()  {
        
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
        
        let paddingBottom = itemH - btnHeight / 2
        let x = (itemBgWidth - btnWidth) / 2
        let y = self.scrollBgView.contentSize.height - paddingBottom - btnHeight
        confirmButton = UIButton(frame: CGRect(x: x, y: y, width: btnWidth, height: btnHeight))
        confirmButton.setTitle("确认添加", for: .normal)
        //button.setTitleColor(UIColor.white, for: .normal)
        confirmButton.setTitleColor(UIColor.gray, for: .highlighted)
        confirmButton.layer.cornerRadius = 5
        confirmButton.titleLabel?.adjustFontByScreenHeight()
        confirmButton.titleLabel?.adjustsFontSizeToFitWidth = true
        confirmButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        confirmButton.addTarget(self, action: #selector(onConfirm(_:)), for: .touchUpInside)
        self.scrollBgView.addSubview(confirmButton)
        
    }
    
    func switchView(type: ProjectAddFragmentType) {
        
        let buttonH = self.confirmButton.bounds.height
        let padding = itemH - buttonH / 2
        
        switch type {
        case .solar:
            let contentH = (itemH + 1) * 18
            self.solarSysFragment.isHidden = false
            self.waterSysFragment.isHidden = true
            scrollBgView.contentSize = CGSize(width: 0, height: contentH)
            let y = contentH - padding - buttonH
            self.confirmButton.frame.origin.y = y
        case .water:
            let contentH = (itemH + 1) * 14
            self.solarSysFragment.isHidden = true
            self.waterSysFragment.isHidden = false
            scrollBgView.contentSize = CGSize(width: 0, height: contentH)
            let y = contentH - padding - buttonH
            self.confirmButton.frame.origin.y = y
            
        }
    }
    
    override func addDropBox(dropBoxFrame: CGRect, names: [String], dropBoxOffset: CGPoint, dropBoxDidSelected: @escaping (Int) -> Void){
        
        let dropBox = DropBoxView(title: "请选择", items: names, frame: dropBoxFrame, offset: dropBoxOffset)
        dropBox.isHightWhenShowList = true
        dropBox.didSelectBoxItemHandler = dropBoxDidSelected
        self.scrollBgView.addSubview(dropBox)
        self.dropBoxViews.append(dropBox)
    }
    
    @objc func onConfirm(_ sender: UIButton){
        //获取项目类型
        let projectTypeIndex = self.dropBoxViews[0].getIndex()
        guard projectTypeIndex != -1 else {
            ToastHelper.showGlobalToast(message: "请选择项目类型！")
            return
        }
        newProject = ShowProject()
        newProject.type = ShowProject.projectType[projectTypeIndex]
        
        //太阳能或者智慧系统
        if projectTypeIndex == 0 || projectTypeIndex == 1 {
            guard let projectName = self.solarSysFragment.tableItemViews[0].contentText.text, !projectName.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写项目名！")
                return
            }
            guard let locationId = self.solarSysFragment.locationId else {
                ToastHelper.showGlobalToast(message: "请选择项目地址！")
                return
            }
            guard let street = self.solarSysFragment.tableItemViews[3].contentText.text, !street.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写街道！")
                return
            }
            guard let deviceType = self.solarSysFragment.tableItemViews[4].contentText.text, !deviceType.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写设备型号！")
                return
            }
            let capcityListIndex = self.solarSysFragment.dropBoxViews[0].getIndex()
            guard capcityListIndex != -1 else {
                ToastHelper.showGlobalToast(message: "请选择设计处理量")
                return
            }
            guard let inwaterStd = self.solarSysFragment.tableItemViews[6].contentText.text, !inwaterStd.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准")
                return
            }
            guard let inwaterCod = self.solarSysFragment.tableItemViews[7].contentText.text, !inwaterCod.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-COD")
                return
            }
            guard let inwaterAndan = self.solarSysFragment.tableItemViews[8].contentText.text, !inwaterAndan.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-氨氮")
                return
            }
            guard let inwaterZonglin = self.solarSysFragment.tableItemViews[9].contentText.text, !inwaterZonglin.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-总磷")
                return
            }
            guard let inwaterZongdan = self.solarSysFragment.tableItemViews[10].contentText.text, !inwaterZongdan.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-总氮")
                return
            }
            guard let inwaterPhValue = self.solarSysFragment.tableItemViews[11].contentText.text, !inwaterPhValue.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-PH值！")
                return
            }
            guard let inwaterXuanfuwu = self.solarSysFragment.tableItemViews[12].contentText.text, !inwaterXuanfuwu.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入进水标准-悬浮物！")
                return
            }
            
            let emissionStdIndex = self.solarSysFragment.dropBoxViews[1].getIndex()
            guard emissionStdIndex != -1 else {
                ToastHelper.showGlobalToast(message: "请选择排放标准！")
                return
            }
            guard let workerName = self.solarSysFragment.tableItemViews[20].contentText.text, !workerName.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入运维人员姓名！")
                return
            }

            guard let workerPhone = self.solarSysFragment.tableItemViews[21].contentText.text, !workerPhone.isEmpty else{
                ToastHelper.showGlobalToast(message: "请输入运维人员联系方式！")
                return
            }
            
            newProject.projectName = projectName
            newProject.locationId = locationId
            newProject.street = street
            newProject.deviceType = deviceType
            newProject.capability = capcityList[capcityListIndex]
            newProject.emissionStandards = emissionStd[emissionStdIndex]
            
            newProject.inwaterStandard = inwaterStd
            newProject.inwaterCod = inwaterCod
            newProject.inwaterAndan = inwaterAndan
            newProject.inwaterZonglin = inwaterZonglin
            newProject.inwaterZongdan = inwaterZongdan
            newProject.inwaterPhValue = inwaterPhValue
            newProject.inwaterXuanfuwu = inwaterXuanfuwu
            
            newProject.outerCod = outStds[emissionStdIndex][0]
            newProject.outerAndan = outStds[emissionStdIndex][1]
            newProject.outerZonglin = outStds[emissionStdIndex][2]
            newProject.outerZongdan = outStds[emissionStdIndex][3]
            newProject.outerPhValue = outStds[emissionStdIndex][4]
            newProject.outerXuanfuwu = outStds[emissionStdIndex][5]
            
            newProject.workerName = workerName
            newProject.workerPhone = workerPhone
        }
        //水体
        else{
            guard let projectName = self.waterSysFragment.tableItemViews[0].contentText.text, !projectName.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写项目名！")
                return
            }
            guard let locationId = self.waterSysFragment.locationId else {
                ToastHelper.showGlobalToast(message: "请选择项目地址！")
                return
            }
            guard let street = self.waterSysFragment.tableItemViews[3].contentText.text, !street.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写街道！")
                return
            }
            guard let deviceType = self.waterSysFragment.tableItemViews[4].contentText.text, !deviceType.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写设备型号！")
                return
            }
            guard let waterOxyenW = self.waterSysFragment.tableItemViews[5].contentText.text, !waterOxyenW.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写增氧设备功率！")
                return
            }
            guard let waterOxyenKgoh = self.waterSysFragment.tableItemViews[4].contentText.text, !waterOxyenKgoh.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写增氧能力！")
                return
            }
            guard let waterOxyenKgokwh = self.waterSysFragment.tableItemViews[4].contentText.text, !waterOxyenKgokwh.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写动力效率！")
                return
            }
            guard let waterCycleMh = self.waterSysFragment.tableItemViews[4].contentText.text, !waterCycleMh.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写循环通量！")
                return
            }
            guard let wateFuseArea = self.waterSysFragment.tableItemViews[4].contentText.text, !wateFuseArea.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写辐射面积！")
                return
            }
            guard let workerName = self.waterSysFragment.tableItemViews[4].contentText.text, !workerName.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写运维人员姓名！")
                return
            }
            guard let workPhone = self.waterSysFragment.tableItemViews[4].contentText.text, !workPhone.isEmpty else {
                ToastHelper.showGlobalToast(message: "请填写运维人员联系方式！")
                return
            }
            
            newProject.projectName = projectName
            newProject.locationId = locationId
            newProject.street = street
            newProject.deviceType = deviceType
            newProject.waterOxyenW = waterOxyenW
            newProject.waterOxyenKgoh = waterOxyenKgoh
            newProject.waterOxyenKgokwh = waterOxyenKgokwh
            newProject.waterCycleMh = waterCycleMh
            newProject.wateFuseArea = wateFuseArea
            newProject.workerName = workerName
            newProject.workerPhone = workerName
            
            
        }
        
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
                //添加成功后从服务器中更新项目
                self.doRefreshProjectListFromNet()
                
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
        //newProject.type = ShowProject.projectType[row]
        if row == 0 || row == 1{
            switchView(type: .solar)
        }else {
            switchView(type: .water)
        }
    }
    
    func onCapcityListSelected(row: Int){
        guard row >= 0 && row <= capcityList.count - 1 else{
            return
        }
        print("capability = \(capcityList[row])")
        newProject.capability = capcityList[row]
        //计算设备列表
        let deviceListMsg = getDeviceCountMsg(index: row)
        self.tableItemViews[5].contentTextView.text = deviceListMsg
    }
    
    func onEmissionStdSelected(row: Int){
        guard row >= 0 && row <= emissionStd.count - 1 else{
            return
        }
        print("emissionStd = \(emissionStd[row])")
        newProject.emissionStandards = emissionStd[row]
    }

}

