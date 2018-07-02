//
//  ShowDevConfig.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/9.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowDevConfig: BaseData {
    var id: Int!
    var projectId: Int!
    var devType: Int!
    var config: String!
    
    required init() {
        super.init()
        self.retCode = 0
        self.msg = "Success"
    }
    
    convenience init(projectId: Int) {
        self.init()
        self.projectId = projectId
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let id = self.id {
            dic["id"] = id
        }
        if let projectId = self.projectId {
            dic["projectId"] = projectId
        }
        if let devType = self.devType {
            dic["devType"] = devType
        }
        if let config = self.config {
            dic["config"] = config
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
        
    }
}
