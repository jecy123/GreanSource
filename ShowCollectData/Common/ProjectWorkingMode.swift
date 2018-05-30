//
//  ProjectWorkingMode.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/6.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ProjectWorkingMode: BaseData {
    var id: Int!
    var projectId: Int!
    var halfHours: [Int8]!
    var createBy: Int!
    var updateTime: String!
    
    override init() {
        super.init()
    }
    
    init(projectId: Int!) {
        super.init()
        //halfHours = [Int8].init(repeating: 0, count: 48)
        self.retCode = 0
        self.projectId = projectId
    }
    
    convenience init(projectId: Int, isChecked: [Bool]) {
        self.init(projectId: projectId)
        
        self.updateTime = Date().getDateString(with: "yyyy年MM月dd日 HH:mm:ss")
        guard isChecked.count == 48 else {
            NSLog("格式错误!")
            return
        }
        
        self.halfHours = [Int8].init(repeating: 0, count: 48)
        var i = 0
        for check in isChecked {
            if check {
                self.halfHours[i] = 1
            }
            i += 1
        }
    }
    
    func updateProjectWorkingMode(with checked: [Bool]){
        self.halfHours = [Int8].init(repeating: 0, count: 48)
        var i = 0
        for check in checked {
            if check {
                self.halfHours[i] = 1
            }
            i += 1
        }
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let id = self.id {
            dic["id"] = id
        }
        if let projectId = self.projectId {
            dic["projectId"] = projectId
        }
        if let updateTime = self.updateTime {
            dic["updateTime"] = updateTime
        }
        
        if let halfHours = self.halfHours {
            if halfHours.count == 48 {
                var index = 0
                for hour in halfHours {
                    let keyStr = "h_"+String(index)
                    dic[keyStr] = hour
                    index += 1
                }
            }
        }
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        if let id = dic["id"] {
            self.id = id as! Int
        }
        if let projectId = dic["projectId"] {
            self.projectId = projectId as! Int
        }
        if let updateTime = dic["updateTime"] {
            self.updateTime = updateTime as! String
        }
        halfHours = [Int8].init(repeating: 0, count: 48)
        for i in 0...47 {
            let keyStr = "h_" + String(i)
            if let h = dic[keyStr] {
                self.halfHours[i] = h as! Int8
            }
        }
    }
}
