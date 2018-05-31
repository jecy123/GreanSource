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
    
    var mDevices:[ShowDevice]!{
        didSet{
            guard let listTable = deviceListTable else { return }
            listTable.reloadData()
        }
    }
    
    ///重新刷新设备信息，以方便提交，同时对数据完整性进行检查，若正确返回true，错误返回false
    func refreshDevices() -> Bool {
        
        for index in 0...mDevices.count-1 {
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
        return true
    }
    
    
    func addFooterView() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        let addButtonW: CGFloat = 60
        let addButtonH: CGFloat = 30
        let addButtonX: CGFloat = (frame.width - addButtonW) / 2
        let addButtonY: CGFloat =  10
        
        let addButtonFrame = CGRect(x: addButtonX, y: addButtonY, width: addButtonW, height: addButtonH)
        let addButton = UIButton(frame: addButtonFrame)
        addButton.addTarget(self, action: #selector(onAddButtonClick(_:)), for: .touchUpInside)
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
    
    @objc func onAddButtonClick(_ sender: UIButton) {
        let device = ShowDevice()
        self.mDevices.append(device)
        
        let latestIndex = IndexPath(row: mDevices.count - 1, section: 0)
        //self.deviceListTable.rectForRow(at: latestIndex)
        self.deviceListTable.scrollToRow(at: latestIndex, at: .top, animated: true)
        
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
    func onDelButtonClick(at index: Int) {
        self.mDevices.remove(at: index)
        
    }
}
