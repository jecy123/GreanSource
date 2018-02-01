//
//  BaseData.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation
class BaseData {
    public var retCode: Int!
    public var msg:String!
    
    init() {
        
    }
    
    init(retCode:Int, msg:String) {
        self.retCode = retCode
        self.msg = msg
    }
    
    func fromDictionary(dic: NSDictionary){
        
        if let msg = dic["msg"] {
            self.msg = msg as! String
        }
        if let retCode = dic["retCode"] {
            self.retCode = retCode as! Int
        }
    }
}
