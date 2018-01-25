//
//  SoAccount.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowAccount: BaseData {
    var account: String!
    var password: String!
    var phone: String!
    var name: String!
    var oldPhone: String!
    var email:String!
    var type: Int!
    var savePwd: Bool!
    var id:Int!
    var role:Int!
    var locations:[ShowLocation]!
    var projects:[ShowProject]!
    
    var vcode: String!
    var createTime: String!
    
    override init() {
        super.init()
    }
    
    func toJSON() -> String {
        var dic = [ String: Any ]()
        
        if let account = self.account {
            dic["account"] = account
        }
        if let msg = self.msg {
            dic["msg"] = msg
        }
        
        if let password = self.password {
            dic["password"] = password
        }
        
        if let retCode = self.retCode {
            dic["retCode"] = retCode
        }
        if let savePwd = self.savePwd {
            dic["savePwd"] = savePwd
        }
        
        if let type = self.type {
            dic["type"] = type
        }
        
        let str = JSONUtils.toJSONString(dic: dic as NSDictionary)
        print("JSONData = \(str)")
        return str
    }
    
    static func fromDictionary(dic: NSDictionary) -> ShowAccount?{
        let account:ShowAccount = ShowAccount()
        if let act = dic.value(forKey: "account") {
            account.account = act as! String
        }
        if let time = dic.value(forKey: "createTime") {
            account.createTime = time as! String
        }
        if let email = dic.value(forKey: "email") {
            account.email = email as! String
        }
        if let id = dic.value(forKey: "id") {
            account.id = id as! Int
        }
        if let msg = dic.value(forKey: "msg") {
            account.msg = msg as! String
        }
        if let retCode = dic.value(forKey: "retCode") {
            account.retCode = retCode as! Int
        }
        if let role = dic.value(forKey: "role") {
            account.role = role as! Int
        }
        if let type = dic.value(forKey: "type") {
            account.type = type as! Int
        }
        if let name = dic.value(forKey: "name") {
            account.name = name as! String
        }
        if let phone = dic.value(forKey: "phone") {
            account.phone = phone as! String
        }
        
        return account
    }
    
    
}
