//
//  RunningDataViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//运行数据界面
class RunningDataViewController: BasePageViewController {
    
    var deviceListFragment: DeviceListFragment!
    var runningDataFragment: RunningDataFragment!
    var timingRunFragment: TimingRunFragment!
    var emergencyFragment: EmergencyFragment!
    
    var currentDeviceList: [ShowDevice]!
    
    var selectedProjectWorkingMode: ProjectWorkingMode!
    
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
        addTitleView()
        
        addDeviceFragment()
        addRunningDataFragment()
        addTimingRunFragment()
        addEmergencyFragment()
        
        initSelectedButtons()
    }
    
    func addDeviceFragment()  {
        let x: CGFloat = 0
        let y: CGFloat = itemBgTitleHeight + itemBgTitleHeight
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - y - 20
        deviceListFragment = DeviceListFragment(frame: CGRect(x: x, y: y, width: w, height: h))
        deviceListFragment.delegate = self
        self.itemBgView.addSubview(deviceListFragment)
        self.deviceListFragment.isHidden = false
    }
    
    func addRunningDataFragment(){
        
        let x: CGFloat = 0
        let y: CGFloat = itemBgTitleHeight + itemBgTitleHeight + 10
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - y - 40
        runningDataFragment = RunningDataFragment(frame: CGRect(x: x, y: y, width: w, height: h), target: self, onBackBtnClickAction: #selector(onBack(_:)))
        self.itemBgView.addSubview(runningDataFragment)
        self.runningDataFragment.isHidden = true
    }
    //添加定时运行界面
    func addTimingRunFragment() {
        let x: CGFloat = 0
        let y: CGFloat = itemBgTitleHeight + itemBgTitleHeight + 10
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - y - 40
        timingRunFragment = TimingRunFragment(frame: CGRect(x: x, y: y, width: w, height: h), target: self, action: #selector(onSubmmit(_:)), events: .touchUpInside)
        self.itemBgView.addSubview(timingRunFragment)
        self.timingRunFragment.isHidden = true
    }
    
    //添加紧急启停界面
    func addEmergencyFragment(){
        let x: CGFloat = 0
        let y: CGFloat = itemBgTitleHeight + itemBgTitleHeight + 10
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - y - 40
        
        emergencyFragment = EmergencyFragment(frame: CGRect(x: x, y: y, width: w, height: h))
        emergencyFragment.delegate = self
        
        self.itemBgView.addSubview(emergencyFragment)
        self.emergencyFragment.isHidden = true
    }
    
    
    @objc func onBack(_ sender: UIButton){
        self.runningDataFragment.isHidden = true
        self.deviceListFragment.isHidden = false
    }
    
    ///提交定时运行数据配置
    @objc func onSubmmit(_ sender: UIButton) {
        guard self.selectedProjectWorkingMode != nil else {
            ToastHelper.showGlobalToast(message: "未选择项目")
            return }
        
        self.selectedProjectWorkingMode.updateProjectWorkingMode(with: self.timingRunFragment.checked)
        
        ClientRequest.updateTimingRunData(workingMode: self.selectedProjectWorkingMode){
            resData in
            if let resData = resData{
                //失败
                if resData.retCode == 1{
                    
                    let error:String = resData.msg
                    let errorMsg:String = "获取定时运行数据失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                //成功
                ToastHelper.showGlobalToast(message: "配置成功")
                
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
        
        
    }
    
    func initSelectedButtons(){
        
        guard let type = self.viewType else {
            return
        }
        
        let screenH = UIScreen.main.bounds.height
        var buttonW: CGFloat = 0
        var buttonH: CGFloat = 0
        
        //屏幕适配
        if screenH >= 568.0 && screenH < 667 {
            buttonW = 70
            buttonH = 26
        } else if screenH >= 667.0 && screenH < 736.0 {
            buttonW = 75
            buttonH = 28
        } else if screenH >= 736.0{
            buttonW = 80
            buttonH = 30
        }
        
        
        switch type {
        case .adminitor:
            addSelectedButtons(buttonTitles: ["设备信息", "定时运行", "紧急启停"], buttonWidth: buttonW, buttonHeight: buttonH)
        case .EP:
            addSelectedButtons(buttonTitles: ["设备信息"], buttonWidth: buttonW, buttonHeight: buttonH)
        case .mantainer:
            addSelectedButtons(buttonTitles: ["设备信息", "紧急启停"], buttonWidth: buttonW, buttonHeight: buttonH)
        default:
            break
        }
    }
    
    override func refreshProject() {
        self.runningDataFragment.projectType = self.selectedProject.type
        self.deviceListFragment.projectType = self.selectedProject.type
        guard let type = self.viewType else {
            return
        }
        
        switch type {
        //管理员
        case .adminitor:
            switch self.selectedButtonIndex {
            //设备信息
            case 0:
                self.doGetDeviceList()
            //定时运行
            case 1:
                self.doGetTimingRunData()
            //紧急启停
            case 2:
                self.doGetDeviceList()
            default:break
            }
        //环保人员
        case .EP:
            //设备信息
            doGetDeviceList()
        //维修人员
        case .mantainer:
            switch self.selectedButtonIndex {
            //设备信息
            case 0:
                self.doGetDeviceList()
            //紧急启停
            case 1:
                self.doGetDeviceList()
            default:
                break
            }
        default:
            break
        }
        
    }
    
    override func onSelectedButtonClicked(_ sender: UIButton) {
        super.onSelectedButtonClicked(sender)
        guard let title = sender.title(for: .normal) else {
            return
        }
        if title == "设备信息" {
            self.deviceListFragment.isHidden = false
            self.runningDataFragment.isHidden = true
            self.timingRunFragment.isHidden = true
            self.emergencyFragment.isHidden = true
            
            doGetDeviceList()
        }
        if title == "定时运行" {
            
            self.deviceListFragment.isHidden = true
            self.runningDataFragment.isHidden = true
            self.timingRunFragment.isHidden = false
            self.emergencyFragment.isHidden = true
            
            doGetTimingRunData()
        }else if title == "紧急启停" {
            
            self.deviceListFragment.isHidden = true
            self.runningDataFragment.isHidden = true
            self.timingRunFragment.isHidden = true
            self.emergencyFragment.isHidden = false
        }
        
    }
    //获取设备列表信息
    func doGetDeviceList() {
        guard let project = self.selectedProject else {
            return
        }
        let projectId: Int = project.id
        ClientRequest.getDeviceList(projectId: projectId){
            resDevices in
            if let resDevices = resDevices{
                self.currentDeviceList = resDevices
                self.deviceListFragment.setDevices(devices: resDevices)
                self.emergencyFragment.refreshDeviceData(devices: resDevices)
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
        }
    }
    
    //获取定时运行的数据
    func doGetTimingRunData(){
        guard let project = self.selectedProject else {
            return
        }
        ClientRequest.getTimingRunData(projectId: project.id){
            resWorkMode in
            if let resWorkMode = resWorkMode{
                //失败
                if resWorkMode.retCode == 1{
                    
                    let error:String = resWorkMode.msg
                    let errorMsg:String = "获取定时运行数据失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                //成功
                self.selectedProjectWorkingMode = resWorkMode
                self.timingRunFragment.refreshTimingRunData(mode: resWorkMode)
                
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
        }
    }
}

extension RunningDataViewController: DeviceListFragmentDelegate {
    func onDeviceListSelected(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String(indexPath.row) + "被选中")
        
        self.deviceListFragment.isHidden = true
        self.runningDataFragment.isHidden = false
        self.runningDataFragment.projectType = self.selectedProject.type
        
        self.runningDataFragment.resetDeviceData()
        
        let deviceTableView = tableView as! DevicesTableView
        let uuid:String =  deviceTableView.mDevices[indexPath.row].devNo
        ClientRequest.getDeviceData(uuid: uuid){
            resDeviceDatas in
            if let resDeviceDatas = resDeviceDatas {
                self.refreshDeviceData(deviceDatas: resDeviceDatas)
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
        
    }
    
    func refreshDeviceData(deviceDatas: [ShowDeviceData]) {
        guard deviceDatas.count > 0 else { return }
        let data = deviceDatas[0]
        self.runningDataFragment.refreshDeviceData(deviceData: data)
    }
}


extension RunningDataViewController: EmergencyFragmentDelegate {
    func totalStateChange(fragment: EmergencyFragment, state: OnOrOffState) {
        guard let deviceList = self.currentDeviceList else {
            return
        }
        print ("1111state.rawValue = \(state.rawValue)")
        self.emergencyFragment.refreshdata(state0: state.rawValue)
        for i in 0..<deviceList.count {
            switch(state.rawValue){
                case 0:
                    deviceList[i].sw0 = 0
                    deviceList[i].sw1 = 0
                    deviceList[i].sw2 = 0
                    deviceList[i].sw3 = 0
                case 1:
                    deviceList[i].sw0 = 2
                    deviceList[i].sw1 = 2
                    deviceList[i].sw2 = 2
                    deviceList[i].sw3 = 2
            default:
                    break
            }
        }
        let listJson = ShowDevice.arrayToJSON(list: deviceList)
     //   print("Device List = \(listJson)")
        ClientRequest.setProjectEmergencyStartOrStop(devicelistJson: listJson){
            resDevices in
            if let resDevices = resDevices{
                var msg = ""
                for device in resDevices {
                    if device.msg == "此设备未连接" {
                        msg += device.devNo + ","
                    }
                }
                
                if msg == "" {
                    ToastHelper.showGlobalToast(message: "成功！")
                }else {
                    msg += "设备未连接"
                    ToastHelper.showGlobalToast(message: msg)
                }
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
        
    }
    
    func fanStateChange(fragment: EmergencyFragment, index: Int, state: OnOrOffState) {
        guard let deviceList = self.currentDeviceList else {
            return
        }
         print ("2222state.rawValue = \(state.rawValue)")
        for i in 0..<deviceList.count {
            switch index {
            case 0:
                deviceList[i].sw0 = Int16(state.rawValue)
            case 1:
                deviceList[i].sw1 = Int16(state.rawValue)
            case 2:
                deviceList[i].sw2 = Int16(state.rawValue)
            case 3:
                deviceList[i].sw3 = Int16(state.rawValue)
            default:
                break
            }
        }
        let listJson = ShowDevice.arrayToJSON(list: deviceList)
  //      print("Device List = \(listJson)")
        ClientRequest.setProjectEmergencyStartOrStop(devicelistJson: listJson){
            resDevices in
            if let resDevices = resDevices{
                var msg = ""
                for device in resDevices {
                    if device.msg == "此设备未连接" {
                        msg += device.devNo + ","
                    }
                }
                
                if msg == "" {
                    ToastHelper.showGlobalToast(message: "成功！")
                }else {
                    msg += "设备未连接"
                    ToastHelper.showGlobalToast(message: msg)
                }
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }

        }
        
    }
}
