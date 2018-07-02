//
//  ShowPage.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/30.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation


class ShowPage<T:BaseData>: BaseData {
    var start: Int!
    var pageNum: Int!
    var count: Int!
    var total: Int!
    
    var condition: BaseData! //条件
    var resList: [T]! //结果
    
    required init() {
        super.init()
        self.start = 0
        self.pageNum = 1
        self.count = 1000
        self.total = 0
    }
    
    convenience init(c: BaseData) {
        self.init()
        self.condition = c
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let start = self.start {
            dic["start"] = start
        }
        
        if let pageNum = self.pageNum {
            dic["pageNum"] = pageNum
        }
        
        if let count = self.count {
            dic["count"] = count
        }
        
        if let total = self.total {
            dic["total"] = total
        }
        
        if let condition = self.condition {
            dic["c"] = condition.toDic() as NSDictionary
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        
        if let start = dic["start"] {
            self.start = start as! Int
        }
        
        if let pageNum = dic["start"] {
            self.pageNum = pageNum as! Int
        }
        
        if let  count = dic["count"] {
            self.count = count as! Int
        }
        
        if let total = dic["total"] {
            self.total = total as! Int
        }
        
        if let resList = dic["t"] {
            let resDics = resList as! Array<NSDictionary>
            self.resList = []
            for dic in resDics {
                let resListItem = T()
                resListItem.fromDictionary(dic: dic)
                self.resList.append(resListItem)
            }
        }
    }
}
