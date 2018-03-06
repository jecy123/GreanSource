//
//  BaseItem.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/27.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class BaseItem {
    var id: String!
    var name: String!
    var isLeaf: Bool!
    var level: Int!
    var isExpand: Bool!
    var childrenSize: Int!
    var children: [BaseItem]!
    weak var parent: BaseItem!
    
    init() {
        self.isLeaf = false
        self.isExpand = false
        self.childrenSize = 0
    }
    
    public func setExpand(_ isExpand: Bool){
        self.isExpand = isExpand
        
        if !isExpand {
            for child in self.children {
                child.setExpand(isExpand)
            }
        }
    }
    
    public func fromDictionary(dic: NSDictionary) {
        if let id = dic["Id"] {
            self.id = id as! String
        }
        
        if let name = dic["Name"] {
            self.name = name as! String
        }
    }
}
