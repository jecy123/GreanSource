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
    
    //项目类型：10 - 太阳能污水处理系统，20 - 智能运维系统
    static let PROJ_TYPE_SUNPOWER = 10
    static let PROJ_TYPE_SMART = 20
    
    override init() {
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
    }
}
