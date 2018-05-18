//
//  DevicesTableView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/16.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class DevicesTableView: UITableView{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var mDevices: [ShowDevice]!
    
    let NodeCellId = "DevicesTableViewCell"
    let cellHeight: CGFloat = 50
    
    init(frame: CGRect, devices: [ShowDevice]) {
        super.init(frame: frame, style: .plain)
        
        self.mDevices = devices
        self.contentSize = CGSize(width: 0, height: CGFloat(mDevices.count)*cellHeight)
        self.dataSource = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DevicesTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let device = mDevices else { return 0 }
        return device.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "DevicesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NodeCellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NodeCellId) as! DevicesTableViewCell
        
        var device: ShowDevice!
        device = mDevices[indexPath.row]
        cell.deviceTitleLabel.text = "太阳能污水处理控制柜"+String(device.boxNo)
        return cell
    }
}
