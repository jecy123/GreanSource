//
//  ShowProjectInfo.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/15.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowProjectInfo: BaseData{
    //项目id
    var id: Int!
    //项目处理量
    var capability: Int!
    //总发电量
    var projectTotalPChg: Int64!
    //排放标准
    var emissionStandards:Int!
    //地址的纬度
    var altitude: String!
    //地址的经度
    var longtitude: String!
    //项目类型
    var type: Int!
    //状态
    var state: Int!
    
    required init() {
        super.init()
        self.type = 0
        self.projectTotalPChg = 0
        self.capability = 0
        self.emissionStandards = 0
        self.retCode = 0
    }
    
    convenience init(projectId: Int) {
        self.init()
        self.id = projectId
        
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let id = self.id {
            dic["id"] = id
        }
        if let state = self.state {
            dic["state"] = state
        }
        if let retCode = self.retCode {
            dic["retCode"] = retCode
        }
        if let msg = self.msg {
            dic["msg"] = msg
        }
        if let capability = self.capability {
            dic["capability"] = capability
        }
        if let emissionStandards = self.emissionStandards {
            dic["emissionStandards"] = emissionStandards
        }
        if let type = self.type {
            dic["type"] = type
        }
        if let altitude = self.altitude {
            dic["altitude"] = altitude
        }
        if let longtitude = self.longtitude {
            dic["longtitude"] = longtitude
        }
        return dic

    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        if let capability = dic["capability"] {
            self.capability = capability as! Int
        }
        if let emissionStandards = dic["emissionStandards"] {
            self.emissionStandards = emissionStandards as! Int
        }
        if let id = dic["id"] {
            self.id = id as! Int
        }
        if let totalPchgStr = dic["projectTotalPChg"] {
            
            let str = totalPchgStr as! NSString
            self.projectTotalPChg = str.longLongValue
        }
        if let state = dic["state"] {
            self.state = state as! Int
        }
        if let type = dic["type"] {
            self.type = type as! Int
        }
        if let altitude = dic["altitude"] {
            self.altitude = altitude as! String
        }
        if let longtitude = dic["longitude"] {
            self.longtitude = longtitude as! String
        }
    }
}
