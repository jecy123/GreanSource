//
//  RuningStateViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//运行状态界面
class RunningStateViewController: BasePageViewController{
    let titles:[String] = ["连续无故障运行时长：","上次故障发生日期："]
    let contents: [String] = ["  天  小时  分", "    年  月  日  时  分"]
    
    var mDevices: [ShowDevice]!{
        didSet{
            if let deviceTable = self.devicesTableView {
                deviceTable.mDevices = mDevices
                deviceTable.reloadData()
            }
        }
    }
    
    var backButton: UIButton!
    
    var runningNormalLabel: UILabel!
    var runningErrorLabel: UILabel!
    
    var runningNormalImage: UIImageView!
    var runningErrorImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initRunningStateView(){
        
        let lableImageW: CGFloat = self.itemBgWidth / 2 - 20
    
        let imageH: CGFloat = 20
        let imageW: CGFloat = lableImageW * 0.45
        
        let labelH: CGFloat = 20
        let labelW: CGFloat = lableImageW * 0.55
        
        let originY: CGFloat = 140
        
        runningNormalLabel = self.addInfoTitleLabel(frame: CGRect(x: 20, y: originY, width: labelW, height: labelH), title: "运行正常：")
        
        let imageRight:UIImage = UIImage(named: "goodstatus")!
        runningNormalImage = self.addInfoContentImage(frame: CGRect(x: 20 + labelW, y: originY, width: imageW, height: imageH), image: imageRight)
        
        
        runningErrorLabel = self.addInfoTitleLabel(frame: CGRect(x: 20 + labelW + imageW, y: originY, width: labelW, height: labelH), title: "故障报警：")
        
        let imageError:UIImage = UIImage(named: "errorstatus")!
        runningErrorImage = self.addInfoContentImage(frame: CGRect(x: 20 + labelW + imageW + labelW, y: originY, width: imageW, height: imageH), image: imageError)
    }
    
    func initInfomationView()  {
        
        let infoItemHeight:CGFloat = 60
        let height = infoItemHeight * CGFloat(self.titles.count)
        //let y = (itemBgView.frame.height - height) / 2
        let infoFrame = CGRect(x: 20, y: 200, width: itemBgWidth, height: height)
        addInfoView(infoViewFrame: infoFrame, titleRatio: 0.5, titles: titles, contents: contents)
    }
    
    func initDeviceListTable(){
        mDevices = [ShowDevice]()
        let devicesFrame = CGRect(x: 0, y: 100, width: itemBgWidth, height: itemBgHeight - 100)
        addDeviceListView(deviceListFrame: devicesFrame, devices: mDevices)
        self.devicesTableView.delegate = self
    }
    
    func initBackButton(){
        backButton = UIButton(frame: CGRect(x: itemLeftPadding + itemBgWidth / 2 - 25, y: itemTopPadding + itemBgHeight - 40, width: 50, height: 30))
        backButton.addTarget(self, action: #selector(onBtnBackClicked(_:)), for: .touchUpInside)
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitleColor(UIColor.gray, for: .highlighted)
        backButton.layer.cornerRadius = 5
        backButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        
        self.view.addSubview(backButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTitleView(titleHeight: 40)
        
        initRunningStateView()
        initInfomationView()
        initDeviceListTable()
        initBackButton()
        
        self.runningNormalLabel.isHidden = true
        self.runningNormalImage.isHidden = true
        self.runningErrorLabel.isHidden = true
        self.runningErrorImage.isHidden = true
        
        self.devicesTableView.isHidden = false
        self.infomationView.isHidden = true
        self.backButton.isHidden = true
    }
    
    override func refreshProject() {
        let projectId: Int = self.selectedProject.id
        ClientRequest.getDeviceList(projectId: projectId){
            resDevices in
            if let resDevices = resDevices{
                self.mDevices = resDevices
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
        }
    }
}

extension RunningStateViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中了第" + String(indexPath.row) + "项")
        
        
        self.runningNormalLabel.isHidden = false
        self.runningErrorLabel.isHidden = false
        
        self.devicesTableView.isHidden = true
        self.infomationView.isHidden = false
        self.backButton.isHidden = false
        
        let uuid:String =  self.devicesTableView.mDevices[indexPath.row].devNo
        ClientRequest.getDeviceData(uuid: uuid){
            resDeviceDatas in
            if let resDeviceDatas = resDeviceDatas {
                self.refreshDeviceData(deviceDatas: resDeviceDatas)
            }else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
    }
    
    func isStateRight(state: String) -> Bool {
        let numbers = StringUtils.stringToIntArray(value: state)
        guard let nums = numbers else { return false }
        let stateCode = nums[nums.count - 1]
        var res = false
        
        if (stateCode & 0x8) == 0x8 {
            res = false
        }else{
            res = true
        }
        return res
    }
    
    func refreshDeviceData(deviceDatas: [ShowDeviceData]) {
        guard deviceDatas.count > 0 else {
            return
        }
        let data = deviceDatas[0]
        if let state = data.stat {
            if isStateRight(state: state) {
                //正确状态
                self.runningNormalImage.isHidden = false
                self.runningErrorImage.isHidden = true
                
            }else{
                //错误状态
                self.runningNormalImage.isHidden = true
                self.runningErrorImage.isHidden = false
            }
        }
        if let safeTime = data.safeTime {
            let days = safeTime / (60 * 60 * 24)
            let hours = (safeTime % (60 * 60 * 24)) / (60 * 60)
            let minutes = (safeTime % (60 * 60)) / 60
            
            let safeTimeString = String(days) + "天" + String(hours) + "时" + String(minutes) + "分"
            self.infomationView.refreshOneContent(at: 0, content
                : safeTimeString)
        }
        
        if let breakTime = data.breakTime {
            let year = breakTime.getDate().year
            let month = breakTime.getDate().month
            let day = breakTime.getDate().day
            let hour = breakTime.getDate().hour
            
            let breakTimeString = String(year) + "年" + String(month) + "月" + String(day) + "日" + String(hour) + "时"
            self.infomationView.refreshOneContent(at: 1, content: breakTimeString)
        }
        
    }
}



extension RunningStateViewController{
    @objc func onBtnBackClicked(_ sender: UIButton){
        
        self.runningNormalLabel.isHidden = true
        self.runningNormalImage.isHidden = true
        self.runningErrorLabel.isHidden = true
        self.runningErrorImage.isHidden = true
        
        self.devicesTableView.isHidden = false
        self.infomationView.isHidden = true
        self.backButton.isHidden = true
    }
}
