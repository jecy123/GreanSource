//
//  SoAccount.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

///三种用户的类型
enum AccountType: Int {
    case adminitor = 10 //管理员
    case mantainer = 20 //维护员
    case EP = 30        //环保部门人员
}

///审核状态：
enum AuditStatus: Int {
    case waitForAudit = 10
    case agree = 50
    case reject = 60
}

class ShowAccount: BaseData {
    var account: String!
    var password: String!
    var phone: String!
    var name: String!
    var oldPhone: String!
    var email:String!
    var type: Int!
    var savePwd: Bool!
    var id: Int!
    var role: Int!
    var locations: [ShowLocation]!
    var projects: [ShowProject]!
    var status: Int!
    
    var vcode: String!
    var createTime: String!
    
    var locationIds: String!
    
    override init() {
        super.init()
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        
        if let account = self.account {
            dic["account"] = account
        }
        if let password = self.password {
            dic["password"] = password
        }
        if let type = self.type {
            dic["type"] = type
        }
        if let role = self.role {
            dic["role"] = role
        }
        if let name = self.name {
            dic["name"] = name
        }
        if let vcode = self.vcode {
            dic["vcode"] = vcode
        }
        if let email = self.email {
            dic["email"] = email
        }
        if let status = self.status {
            dic["status"] = status
        }
        if let phone = self.phone {
            dic["phone"] = phone
        }
        if let oldPhone = self.oldPhone {
            dic["oldPhone"] = oldPhone
        }
        if let locations = self.locations {
            var locationDics = [NSDictionary]()
            for location in locations {
                var locationDic = [String : Any]()
                locationDic["locationId"] = location.locationId
                locationDic["retCode"] = location.retCode
                locationDics.append(locationDic as NSDictionary)
            }
            dic["locations"] = locationDics
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
        if let act = dic["account"]{
            self.account = act as! String
        }
        if let time = dic["createTime"] {
            self.createTime = time as! String
        }
        if let email = dic["email"] {
            self.email = email as! String
        }
        if let id = dic["id"] {
            self.id = id as! Int
        }
        if let role = dic["role"] {
            self.role = role as! Int
        }
        if let type = dic["type"] {
            self.type = type as! Int
        }
        if let name = dic["name"] {
            self.name = name as! String
        }
        if let phone = dic["phone"] {
            self.phone = phone as! String
        }
        
        if let locations = dic["locations"] {
            self.locations = [ShowLocation]()
            
            let locationsDic = locations as! Array<NSDictionary>
            for locDic in locationsDic {
                let location = ShowLocation()
                location.fromDictionary(dic: locDic)
                self.locations.append(location)
            }
            print("locationSize  = \(self.locations.count)")
            //print("jsonLen = \(jsonString.count)")
        }
        
        if let locationIds = dic["locationIds"] {
            self.locationIds = locationIds as! String
        }
        
        if let projects = dic["projects"] {
            self.projects = [ShowProject]()
            
            let projectsDic = projects as! Array<NSDictionary>
            
            for projDic in projectsDic{
                let project = ShowProject()
                project.fromDictionary(dic: projDic)
                self.projects.append(project)
            }
            print("projectSize = \(self.projects.count)")
        }
        
        
    }
    
    
}
