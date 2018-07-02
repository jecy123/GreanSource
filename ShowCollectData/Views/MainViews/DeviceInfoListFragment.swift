//
//  DeviceDetailListFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/30.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class DeviceInfoListFragment: UIView {
    
    let cellId = "DeviceInfoListCell"
    
    var deviceListTable: UITableView!
    
    var mDevices:[ShowDevice]! = []{
        didSet{
            guard let listTable = deviceListTable else { return }
            listTable.reloadData()
        }
    }
    
    ///记录新增的设备信息
    var mAddDevices: [ShowDevice] = []
    
    ///记录删除的设备信息
    var mDelDevices: [ShowDevice] = []
    
    ///将新增的设备列表和删除的设备列表信息重置为空
    func resetDeviceList() {
        self.mAddDevices.removeAll()
        self.mDelDevices.removeAll()
    }
    
    ///重新刷新设备信息，以方便提交，同时对数据完整性进行检查，若正确返回true，错误返回false
    ///projcetId--项目id
    ///locationId--项目位置
    func refreshDevices(projectId: Int = 0, locationId: String = "") -> Bool {
        
        for index in 0..<mDevices.count {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.deviceListTable.cellForRow(at: indexPath) as! DeviceInfoListCell
            guard let devNo = cell.tfDeviceNo.text, let boxNo = cell.tfTag.text else{
                return false
            }
            if devNo == "" || boxNo == "" {
                return false
            }
            mDevices[index].devNo = devNo
            mDevices[index].boxNo = Int(boxNo)
        }
        
        mAddDevices = mAddDevices.filter({ (resDevice) -> Bool in
            resDevice.flag != 0
        })
        
        //新添加的项目应该重置数据
        for device in mAddDevices {
            device.resetData(projectId: projectId, locationId: locationId)
        }
        
        return true
    }
    
    
    func addFooterView() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        let screenH = UIScreen.main.bounds.height
        var labelFontSize: CGFloat = 0
        var btnWidth: CGFloat = 0
        var btnHeight: CGFloat = 0
        
        if screenH >= 568.0 && screenH < 667.0 {
            labelFontSize = 13
            btnWidth = 58
            btnHeight = 27
        } else if screenH >= 667.0 && screenH < 736.0 {
            labelFontSize = 16
            btnWidth = 66
            btnHeight = 33
        } else if screenH >= 736.0 {
            labelFontSize = 18
            btnWidth = 80
            btnHeight = 40
        }
        
        let addButtonW: CGFloat = btnWidth
        let addButtonH: CGFloat = btnHeight
        let addButtonX: CGFloat = (frame.width - addButtonW) / 2
        let addButtonY: CGFloat =  10
        
        let addButtonFrame = CGRect(x: addButtonX, y: addButtonY, width: addButtonW, height: addButtonH)
        let addButton = UIButton(frame: addButtonFrame)
        addButton.addTarget(self, action: #selector(onAddButtonClick(_:)), for: .touchUpInside)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: labelFontSize)
        addButton.setTitle("新增", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.setTitleColor(ColorUtils.itemTitleViewBgColor, for: .highlighted)
        addButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        addButton.layer.cornerRadius = 4
        footerView.addSubview(addButton)
        
        deviceListTable.tableFooterView = footerView
    }
    
    func addDeviceListTable(itemHeight: CGFloat) {
        let listFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        deviceListTable = UITableView(frame: listFrame)
        deviceListTable.dataSource = self
        deviceListTable.rowHeight = itemHeight
        self.addSubview(deviceListTable)
    }
    
    
    init(frame: CGRect, tableItemHeight: CGFloat) {
        super.init(frame: frame)
        self.addDeviceListTable(itemHeight: tableItemHeight)
        self.addFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeviceInfoListFragment: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let devices = self.mDevices {
            return devices.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "DeviceInfoListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! DeviceInfoListCell
        
        cell.btnDelete.tag = indexPath.row
        cell.tfDeviceNo.text = ""
        cell.tfTag.text = ""
        
        let device = mDevices[indexPath.row]
        
        if let devNo = device.devNo{
            cell.tfDeviceNo.text = devNo
        }
        
        if let boxNo = device.boxNo {
            cell.tfTag.text = String(boxNo)
        }
        
        cell.delegate = self
        
        return cell
    }
    
}
extension DeviceInfoListFragment: DeviceInfoListCellDelegate {
    
    ///添加设备信息
    @objc func onAddButtonClick(_ sender: UIButton) {
        let device = ShowDevice()
        device.flag = 1
        self.mDevices.append(device)
        self.mAddDevices.append(device)
        
        device.flag = 1
        
        let latestIndex = IndexPath(row: mDevices.count - 1, section: 0)
        //self.deviceListTable.rectForRow(at: latestIndex)
        self.deviceListTable.scrollToRow(at: latestIndex, at: .top, animated: true)
        
    }
    
    ///删除设备信息
    func onDelButtonClick(at index: Int) {
        //只删除已经默认存在的信息（默认存在的项目flag为0，添加的项目的flag为1，因此如果将flag-1后就可以判断是否为-1就可以判断其是否是默认存在的项目还是添加的项目）
        mDevices[index].flag -= 1
        if mDevices[index].flag == -1 {
            self.mDelDevices.append(mDevices[index])
        }
        self.mDevices.remove(at: index)
    }
}
