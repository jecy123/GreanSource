//
//  ShowLocation.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/25.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowLocation : BaseData{
    var locationId: String!
    var accountId: Int16!
    
    override init() {
        super.init()
    }
    
    init(locationId: String, retCode: Int, msg: String) {
        super.init(retCode: retCode, msg: msg)
        self.locationId = locationId
    }
    

    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        if let locationId = dic["locationId"] {
            self.locationId = locationId as! String
        }

    }
}
