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
    
    override init() {
        super.init()
    }
    
    
}
