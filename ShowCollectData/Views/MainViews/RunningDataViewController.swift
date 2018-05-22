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
        addTitleView(titleHeight: 40)
        
        addDeviceFragment()
        addRunningDataFragment()
        initSelectedButtons()
    }
    
    func addDeviceFragment()  {
        let x: CGFloat = 0
        let y: CGFloat = 100
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - 140
        deviceListFragment = DeviceListFragment(frame: CGRect(x: x, y: y, width: w, height: h))
        deviceListFragment.delegate = self
        self.itemBgView.addSubview(deviceListFragment)
    }
    
    func addRunningDataFragment(){
        
        let x: CGFloat = 0
        let y: CGFloat = 100
        let w: CGFloat = itemBgWidth
        let h: CGFloat = itemBgHeight - 140
        runningDataFragment = RunningDataFragment(frame: CGRect(x: x, y: y, width: w, height: h), target: self, onBackBtnClickAction: #selector(onBack(_:)))
        self.itemBgView.addSubview(runningDataFragment)
        self.runningDataFragment.isHidden = true
    }
    
    @objc func onBack(_ sender: UIButton){
        self.runningDataFragment.isHidden = true
        self.deviceListFragment.isHidden = false
    }
    
    func initSelectedButtons(){
        
        guard let type = self.viewType else {
            return
        }
        
        switch type {
        case .adminitor:
            addSelectedButtons(buttonTitles: ["设备信息", "定时运行", "紧急启停"], buttonWidth: 80, buttonHeight: 30)
        case .EP:
            addSelectedButtons(buttonTitles: ["设备信息"], buttonWidth: 80, buttonHeight: 30)
        case .mantainer:
            addSelectedButtons(buttonTitles: ["设备信息", "紧急启停"], buttonWidth: 80, buttonHeight: 30)
        }
    }
    
    override func refreshProject() {
        let projectId: Int = self.selectedProject.id
        ClientRequest.getDeviceList(projectId: projectId){
            resDevices in
            if let resDevices = resDevices{
                self.deviceListFragment.setDevices(devices: resDevices)
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
        }
    }
    
    override func onSelectedButtonClicked(_ sender: UIButton) {
        super.onSelectedButtonClicked(sender)
        
        
    }
}

extension RunningDataViewController: DeviceListFragmentDelegate {
    func onDeviceListSelected(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String(indexPath.row) + "被选中")
        
        self.deviceListFragment.isHidden = true
        self.runningDataFragment.isHidden = false
        
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
        guard deviceDatas.count > 0 else {
            return
        }
        
        let data = deviceDatas[0]
        self.runningDataFragment.refreshDeviceData(deviceData: data)
    }
}
