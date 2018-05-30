//
//  ShowVCode.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/8.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

//校验码类型：10-注册校验码 20-找回校验码
enum ShowVCodeType: Int{
    case typeRegister = 10
    case typeRetrieve = 20
}

class ShowVCode: BaseData{
    var type: Int!
    var phone: String!
    var vcode: String!
    
    override init() {
        super.init()
        self.retCode = 0
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let type = self.type {
            dic["type"] = type
        }
        if let phone = self.phone {
            dic["phone"] = phone
        }
        
        if let vcode = self.vcode {
            dic["vcode"] = vcode
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
        if let vcode = dic["vcode"] {
            self.vcode = vcode as! String
        }
        if let type = dic["type"] {
            self.type = type as! Int
        }
        if let phone = dic["phone"] {
            self.phone = phone as! String
        }
    }
}
