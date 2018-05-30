//
//  ShowDevice.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/16.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation
class ShowDevice: BaseData {
    static let ACCESS_SUCCESS: Int = 0
    static let ACCESS_FAILURE: Int = 0
    
    //设备id号
    var id: Int!
    //设备号码，用来获取设备运行状态
    var devNo: String!
    //太阳能污水处理控制柜号码，用来显示控制柜名称
    var boxNo: Int!
    //地址id号，表示设备所在的位置
    var locationId: String!
    //项目id号
    var projectId: Int!
    
    var sw0: Int16!
    var sw1: Int16!
    var sw2: Int16!
    var sw3: Int16!
    var sw4: Int16!
    var sw5: Int16!
    var sw6: Int16!
    var sw7: Int16!
    
    var gpsInfo: String!
    var ipAddr: String!
    var dataServerIp: Int!
    var createTime: String!
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let id = self.id {
            dic["id"] = id
        }
        
        if let devNo = self.devNo {
            dic["devNo"] = devNo
        }
        
        if let boxNo = self.boxNo {
            dic["boxNo"] = boxNo
        }
        
        if let createTime = self.createTime {
            dic["createTime"] = createTime
        }
        
        if let locationId = self.locationId {
            dic["locationId"] = locationId
        }
        
        if let projectId = self.projectId {
            dic["projectId"] = projectId
        }
        
        if let sw0 = self.sw0 {
            dic["sw0"] = sw0
        }
        
        if let sw1 = self.sw1 {
            dic["sw1"] = sw1
        }
        
        if let sw2 = self.sw2 {
            dic["sw2"] = sw2
        }
        
        if let sw3 = self.sw3 {
            dic["sw3"] = sw3
        }
        
        if let sw4 = self.sw4 {
            dic["sw4"] = sw4
        }
        
        if let sw5 = self.sw5 {
            dic["sw5"] = sw5
        }
        
        if let sw6 = self.sw6 {
            dic["sw6"] = sw6
        }
        
        if let sw7 = self.sw7 {
            dic["sw7"] = sw7
        }
        return dic
    }
    
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        
        if let id = dic["id"] {
            self.id = id as! Int
        }
        
        if let devNo = dic["devNo"] {
            self.devNo = devNo as! String
        }
        
        if let boxNo = dic["boxNo"] {
            self.boxNo = boxNo as! Int
        }
        
        if let createTime = dic["createTime"] {
            let createTimeL = createTime as! Int64
            self.createTime = String(createTimeL)
        }
        
        if let locationId = dic["locationId"] {
            self.locationId = locationId as! String
        }
        
        if let projectId = dic["projectId"] {
            self.projectId = projectId as! Int
        }
        
        if let sw0 = dic["sw0"] {
            self.sw0 = sw0 as! Int16
        }
        
        if let sw1 = dic["sw1"] {
            self.sw1 = sw1 as! Int16
        }
        
        if let sw2 = dic["sw2"] {
            self.sw2 = sw2 as! Int16
        }
        
        if let sw3 = dic["sw3"] {
            self.sw3 = sw3 as! Int16
        }
        
        if let sw4 = dic["sw4"] {
            self.sw4 = sw4 as! Int16
        }
        
        if let sw5 = dic["sw5"] {
            self.sw5 = sw5 as! Int16
        }
        
        if let sw6 = dic["sw6"] {
            self.sw6 = sw6 as! Int16
        }
        
        if let sw7 = dic["sw7"] {
            self.sw7 = sw7 as! Int16
        }
    }
    
    override init() {
        super.init()
    }
    
}

extension ShowDevice {
    public static func arrayToJSON(list: [ShowDevice]) -> String{
        var json = "["
        for i in 0..<list.count - 1 {
            json += list[i].toJSON() + ","
        }
        json += list[list.count-1].toJSON()+"]"
        return json
    }
}
