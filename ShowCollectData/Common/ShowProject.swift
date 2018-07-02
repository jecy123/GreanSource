//
//  ShowProject.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/25.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowProject: BaseData{
    
    /*"capability": 50,
    "createTime": "2018-01-18 14:41:12.0",
    "emissionStandards": 10,
    "id": 4,
    "locationId": "150521",
    "msg": "Success",
    "projectName": "第一个项目",
    "retCode": 0,
    "state": 0,
    "street": "",
    "type": 10,
    "workerName": "里方正",
    "workerPhone": "133232"*/
    
    //项目类型：10 - 太阳能污水处理系统，20 - 智慧运维系统 30 - 水体太阳能曝气系统
    static let PROJ_TYPE_SUNPOWER = 10
    static let PROJ_TYPE_SMART = 20
    static let PROJ_TYPE_WATER = 30
    
    static let projectType = [ShowProject.PROJ_TYPE_SUNPOWER, ShowProject.PROJ_TYPE_SMART, ShowProject.PROJ_TYPE_WATER]
    required init() {
        super.init()
    }
    
    var capability:Int!
    var createTime:String!
    var emissionStandards:Int!
    var id:Int!
    var locationId:String!
    var projectName:String!
    var state:Int!
    var street: String!
    var type:Int!
    var workerName:String!
    var workerPhone:String!
    var locationName: String!
    
    var deviceType: String!// 设备类型
    var inwaterStandard: String!// 进水标准
    var inwaterCod: String!// COD
    var inwaterAndan: String!// 氨氮
    var inwaterZonglin: String!// 总磷
    var inwaterZongdan: String!// 总氮
    var inwaterPhValue: String!// PH值
    var inwaterXuanfuwu: String!// 悬浮物
    var outerCod: String!// 排放cod
    var outerAndan: String!// 排放氨氮
    var outerZonglin: String!// 排放总磷
    var outerZongdan: String!// 排放总氮
    var outerPhValue: String!// 排放PH值
    var outerXuanfuwu: String!// 排放悬浮物
    var totalReduce: String!// 总减排
    var waterOxyenW: String!// 增氧设备功率
    var waterOxyenKgoh: String!// 增氧能力
    var waterOxyenKgokwh: String!// 动力效率
    var waterCycleMh: String!// 循环通量
    var wateFuseArea: String!// 辐射面积
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let capability = self.capability {
            dic["capability"] = capability
        }
        if let emissionStandards = self.emissionStandards {
            dic["emissionStandards"] = emissionStandards
        }
        if let id = self.id {
            dic["id"] = id
        }
        
        if let locationId = self.locationId {
            dic["locationId"] = locationId
        }
        if let projectName = self.projectName {
            dic["projectName"] = projectName
        }
        if let street = self.street {
            dic["street"] = street
        }
        if let state = self.state {
            dic["state"] = state
        }
        if let type = self.type {
            dic["type"] = type
        }
        if let workerName = self.workerName {
            dic["workerName"] = workerName
        }
        if let workerPhone = self.workerPhone {
            dic["workerPhone"] = workerPhone
        }
        
        if let deviceType = self.deviceType {
            dic["deviceType"] = deviceType
        }
        
        if let inwaterStandard = self.inwaterStandard {
            dic["inwaterStandard"] = inwaterStandard
        }
        
        if let inwaterCod = self.inwaterCod {
            dic["inwaterCod"] = inwaterCod
        }
        
        if let inwaterAndan = self.inwaterAndan {
            dic["inwaterAndan"] = inwaterAndan
        }
        
        if let inwaterZonglin = self.inwaterZonglin {
            dic["inwaterZonglin"] = inwaterZonglin
        }
        
        if let inwaterZongdan = self.inwaterZongdan {
            dic["inwaterZongdan"] = inwaterZongdan
        }
        
        if let inwaterPhValue = self.inwaterPhValue {
            dic["inwaterPhValue"] = inwaterPhValue
        }
        
        if let inwaterXuanfuwu = self.inwaterXuanfuwu {
            dic["inwaterXuanfuwu"] = inwaterXuanfuwu
        }
        
        if let outerCod = self.outerCod {
            dic["outerCod"] = outerCod
        }
        
        if let outerAndan = self.outerAndan {
            dic["outerAndan"] = outerAndan
        }
        
        if let outerZonglin = self.outerZonglin {
            dic["outerZonglin"] = outerZonglin
        }
        
        if let outerZongdan = self.outerZongdan {
            dic["outerZongdan"] = outerZongdan
        }
        
        if let outerPhValue = self.outerPhValue {
            dic["outerPhValue"] = outerPhValue
        }
        
        if let outerXuanfuwu = self.outerXuanfuwu {
            dic["outerXuanfuwu"] = outerXuanfuwu
        }
        
        if let totalReduce = self.totalReduce {
            dic["totalReduce"] = totalReduce
        }
        
        if let waterOxyenW = self.waterOxyenW {
            dic["waterOxyenW"] = waterOxyenW
        }
        
        if let waterOxyenKgoh = self.waterOxyenKgoh {
            dic["waterOxyenKgoh"] = waterOxyenKgoh
        }
        
        if let waterOxyenKgokwh = self.waterOxyenKgokwh {
            dic["waterOxyenKgokwh"] = waterOxyenKgokwh
        }
        
        if let waterCycleMh = self.waterCycleMh {
            dic["waterCycleMh"] = waterCycleMh
        }
        
        if let wateFuseArea = self.wateFuseArea {
            dic["wateFuseArea"] = wateFuseArea
        }
        
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        if let capability = dic["capability"] {
            self.capability = capability as! Int
        }
        if let createTime = dic["createTime"] {
            self.createTime = createTime as! String
        }
        if let emissionStandards = dic["emissionStandards"] {
            self.emissionStandards = emissionStandards as! Int
        }
        if let id = dic["id"] {
            self.id = id as! Int
        }
        if let locationId = dic["locationId"] {
            self.locationId = locationId as! String
        }
        if let projectName = dic["projectName"] {
            self.projectName = projectName as! String
        }
        if let state = dic["state"] {
            self.state = state as! Int
        }
        if let type = dic["type"] {
            self.type = type as! Int
        }
        if let workerName = dic["workerName"] {
            self.workerName = workerName as! String
        }
        if let workerPhone = dic["workerPhone"] {
            self.workerPhone = workerPhone as! String
        }
        if let street = dic["street"] {
            self.street = street as! String
        }
        if let deviceType = dic["deviceType"] {
            self.deviceType = deviceType as! String
        }
        if let inwaterStandard = dic["inwaterStandard"] {
            self.inwaterStandard = inwaterStandard as! String
        }
        if let inwaterCod = dic["inwaterCod"] {
            self.inwaterCod = inwaterCod as! String
        }
        if let inwaterAndan = dic["inwaterAndan"] {
            self.inwaterAndan = inwaterAndan as! String
        }
        if let inwaterZonglin = dic["inwaterZonglin"] {
            self.inwaterZonglin = inwaterZonglin as! String
        }
        if let inwaterZongdan = dic["inwaterZongdan"] {
            self.inwaterZongdan = inwaterZongdan as! String
        }
        if let inwaterPhValue = dic["inwaterPhValue"] {
            self.inwaterPhValue = inwaterPhValue as! String
        }
        if let inwaterXuanfuwu = dic["inwaterXuanfuwu"] {
            self.inwaterXuanfuwu = inwaterXuanfuwu as! String
        }
        if let outerCod = dic["outerCod"] {
            self.outerCod = outerCod as! String
        }
        if let outerAndan = dic["outerAndan"] {
            self.outerAndan = outerAndan as! String
        }
        if let outerZonglin = dic["outerZonglin"] {
            self.outerZonglin = outerZonglin as! String
        }
        if let outerZongdan = dic["outerZongdan"] {
            self.outerZongdan = outerZongdan as! String
        }
        if let outerPhValue = dic["outerPhValue"] {
            self.outerPhValue = outerPhValue as! String
        }
        if let outerXuanfuwu = dic["outerXuanfuwu"] {
            self.outerXuanfuwu = outerXuanfuwu as! String
        }
        if let totalReduce = dic["totalReduce"] {
            self.totalReduce = totalReduce as! String
        }
        if let waterOxyenW = dic["waterOxyenW"] {
            self.waterOxyenW = waterOxyenW as! String
        }
        if let waterOxyenKgoh = dic["waterOxyenKgoh"] {
            self.waterOxyenKgoh = waterOxyenKgoh as! String
        }
        if let waterOxyenKgokwh = dic["waterOxyenKgokwh"] {
            self.waterOxyenKgokwh = waterOxyenKgokwh as! String
        }
        if let waterCycleMh = dic["waterCycleMh"] {
            self.waterCycleMh = waterCycleMh as! String
        }
        if let wateFuseArea = dic["wateFuseArea"] {
            self.wateFuseArea = wateFuseArea as! String
        }
    }
}
