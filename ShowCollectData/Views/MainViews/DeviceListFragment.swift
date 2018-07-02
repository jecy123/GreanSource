//
//  DeviceListFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc public protocol DeviceListFragmentDelegate{
    @objc optional func onDeviceListSelected(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class DeviceListFragment: UIView {
    
    var mDevices: [ShowDevice]!
    
    var deviceListTableView: DevicesTableView!
    
    var delegate: DeviceListFragmentDelegate?
    
    var projectType: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mDevices = []
        deviceListTableView = DevicesTableView(frame:CGRect(x: 0, y: 0, width: frame.width, height: frame.height), devices: mDevices)
        self.addSubview(deviceListTableView)
        deviceListTableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setDevices(devices: [ShowDevice]){
        guard let tableView = self.deviceListTableView else { return }
        
        tableView.mDevices = devices
        tableView.projectType = self.projectType
        tableView.reloadData()
    }
    
}

extension DeviceListFragment: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //选中设备
        delegate?.onDeviceListSelected?(tableView, didSelectRowAt: indexPath)
    }
}
