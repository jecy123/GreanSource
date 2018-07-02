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
    
    required init() {
        
    }

    init(retCode:Int, msg:String) {
        self.retCode = retCode
        self.msg = msg
    }
    
    func toDic() -> [String: Any]{
        var dic = [ String: Any ]()
        if let retCode = self.retCode {
            dic["retCode"] = retCode
        }
        if let msg = self.msg {
            dic["msg"] = msg
        }
        return dic
    }
    
    func toJSON() -> String {
        let dic = toDic()
        let str = JSONUtils.toJSONString(dic: dic as NSDictionary)
        print("JSONData = \(str)")
        return str
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


