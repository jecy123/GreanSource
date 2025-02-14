//
//  ShowResponse.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/12.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowResponse: BaseData {
    var type: Int!
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let type = self.type {
            dic["type"] = type
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        
        if let type = dic["type"] {
            self.type = type as! Int
        }
    }
}
