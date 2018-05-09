//
//  ProvinceItem.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/26.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class AddressItem {
    var provinceItem: [ProvinceItem]!
    
    init() {
        self.provinceItem = [ProvinceItem]()
    }
    
    func fromDictionary(dic:NSDictionary){
        if let provinceItems = dic["ProvinceItems"] {
            let provinces = provinceItems as! NSDictionary
            if let province = provinces["Province"]{
                let provinceDics = province as! Array<NSDictionary>
                
                self.provinceItem = [ProvinceItem]()
                
                for proDic in provinceDics{
                    let provinceItem = ProvinceItem()
                    provinceItem.fromDictionary(dic: proDic)
                    self.provinceItem.append(provinceItem)
                }
            }
        }
        print("一共有\(self.provinceItem.count)个省")
    }
}

class ProvinceItem : BaseItem{
    override init() {
        super.init()
        self.level = 0
        self.children = [CityItem]()
        self.parent = nil
    }
    
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
        if let id = dic["Id"] {
            self.id = id as! String
        }
        
        if let name = dic["Name"] {
            self.name = name as! String
        }
        
        if let city = dic["City"] {
            let cityDics = city as! Array<NSDictionary>
            for cityDic in cityDics{
                let cityItem = CityItem()
                cityItem.fromDictionary(dic: cityDic)
                cityItem.parent = self
                self.children.append(cityItem)
                self.childrenSize = self.childrenSize + 1
            }
        }
    }
}

class CityItem : BaseItem{
    
    override init() {
        super.init()
        self.level = 1
        self.children = [AreaItem]()
        //self.parent = ProvinceItem()
    }
    
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
        
        if let areas = dic["Area"] {
            let areaDics = areas as! Array<NSDictionary>
            for areaDic in areaDics{
                let area = AreaItem()
                area.fromDictionary(dic: areaDic)
                area.parent = self
                self.children.append(area)
                self.childrenSize = self.childrenSize + 1
            }
        }
    }
}

class AreaItem :BaseItem {
    
    override init() {
        super.init()
        self.level = 2
        self.children = [ProjectNameItem]()
        //self.parent = CityItem()
    }
    override func fromDictionary(dic: NSDictionary){
        super.fromDictionary(dic: dic)
    }
    
    func addProject(projectName: String, projectId: String) {
        let projectItem: ProjectNameItem = ProjectNameItem(name: projectName, id: projectId)
        projectItem.parent = self
        self.children.append(projectItem)
        
    }
}

class ProjectNameItem: BaseItem {
    
    convenience init(name: String, id: String) {
        self.init()
        self.name = name
        self.id = id
        self.children = []
        self.parent = AreaItem()
    }
    override init() {
        super.init()
        self.isLeaf = true
        self.level = 3
    }
}
