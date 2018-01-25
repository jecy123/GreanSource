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
    
    init(locationId: String, retCode: Int, msg: String) {
        super.init(retCode: retCode, msg: msg)
        self.locationId = locationId
    }
}
