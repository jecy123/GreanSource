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

class ProvinceItem {
    var cityItems:[CityItem]!
    var id: String!
    var name: String!
    
    func fromDictionary(dic: NSDictionary){
        if let id = dic["Id"] {
            self.id = id as! String
        }
        
        if let name = dic["Name"] {
            self.name = name as! String
        }
        
        if let city = dic["City"] {
            self.cityItems = [CityItem]()
            let cityDics = city as! Array<NSDictionary>
            for cityDic in cityDics{
                let cityItem = CityItem()
                cityItem.fromDictionary(dic: cityDic)
                self.cityItems.append(cityItem)
            }
        }
    }
}

class CityItem {
    var areaItems: [AreaItem]!
    var id: String!
    var name: String!
    
    func fromDictionary(dic: NSDictionary){
        if let id = dic["Id"] {
            self.id = id as! String
        }
        
        if let name = dic["Name"] {
            self.name = name as! String
        }
        
        
        if let areas = dic["Area"] {
            self.areaItems = [AreaItem]()
            let areaDics = areas as! Array<NSDictionary>
            for areaDic in areaDics{
                let area = AreaItem()
                area.fromDictionary(dic: areaDic)
                self.areaItems.append(area)
            }
        }
    }
}

class AreaItem {
    var id: String!
    var name: String!
    
    func fromDictionary(dic: NSDictionary){
        if let id = dic["Id"] {
            self.id = id as! String
        }
        if let name = dic["Name"] {
            self.name = name as! String
        }
    }
}
