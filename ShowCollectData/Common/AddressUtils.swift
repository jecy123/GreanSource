//
//  AddressUtils.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/26.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class AddressUtils {
    
    static var addressItem: AddressItem!
    static var sunPowerItem: AddressItem!
    static var smartSysItem: AddressItem!
    
    static func initAddress()
    {
        if let path = Bundle.main.path(forResource: "address", ofType: "txt"){
            print(path)
            do{
                let fileContent = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
                //print(fileContent)
                let dic = JSONUtils.getDictionaryFromJSONString(jsonString: fileContent as String)
                addressItem = AddressItem()
                if let result = dic["Result"]{
                    let ResDic = result as! NSDictionary
                    addressItem.fromDictionary(dic: ResDic)
                }
            }catch let error as NSError{
                print("\(error.localizedDescription)")
            }
        }
    }
    
    static func getItems(projects: [ShowProject]){
        
        var sunPowerProjects: [ShowProject] = []
        var smartSysProjects: [ShowProject] = []
        
        for project in projects {
            if project.type == ShowProject.PROJ_TYPE_SMART {
                smartSysProjects.append(project)
            }
            else if project.type == ShowProject.PROJ_TYPE_SUNPOWER {
                sunPowerProjects.append(project)
            }
            
        }
        
        sunPowerProjects.sort(by: { $0.locationId < $1.locationId })
        smartSysProjects.sort(by: { $0.locationId < $1.locationId })
        
        sunPowerItem = buildItems(projects: sunPowerProjects)
        smartSysItem = buildItems(projects: smartSysProjects)
        
    }
    
    static func buildItems(projects: [ShowProject]) -> AddressItem?{
        guard let p = addressItem.provinceItem, p.count > 0 else{
            return nil
        }
        
        let resItem = AddressItem()
        
        for project in projects {
            
            guard let locationId = project.locationId else { continue }
            
            let projectItem = ProjectNameItem(name: project.projectName, id: String(project.id))
            //省的Id号
            let provinceId = StringUtils.subString(of: locationId, from: 0, to: 1)! + "0000"
            //市的Id号
            let cityId = StringUtils.subString(of: locationId, from: 0, to: 3)! + "00"
            
            let dic = queryLocationId(locationId: locationId)
            
            let provinceEnity = ProvinceItem()
            let cityEnity = CityItem()
            let areaEnity = AreaItem()
            
            areaEnity.id = locationId
            areaEnity.name = dic[locationId]
            
            cityEnity.id = cityId
            cityEnity.name = dic[cityId]
            
            provinceEnity.id = provinceId
            provinceEnity.name = dic[provinceId]
        
            
            
            var i = 0
            for item in resItem.provinceItem{
                if item.id == provinceId {
                    break
                }
                i += 1
            }
            //找到了省
            if i < resItem.provinceItem.count {
                
                let provinceItem = resItem.provinceItem[i]
                var j = 0
                
                for item in provinceItem.children{
                    if item.id == cityId {
                        break
                    }
                    j += 1
                }
                //找到了市
                if j < provinceItem.children.count {
                    let cityItem = provinceItem.children[j] as! CityItem
                    var k = 0
                    
                    for item in cityItem.children{
                        if item.id == locationId{
                             break
                        }
                        k += 1
                    }
                    //找到了地区
                    if k < cityItem.children.count {
                        let areaItem = cityItem.children[k] as! AreaItem
                        areaItem.children.append(projectItem)
                        areaItem.childrenSize = areaItem.childrenSize + 1
                        
                    }else{
                        areaEnity.children.append(projectItem)
                        areaEnity.childrenSize = areaEnity.childrenSize + 1
                        
                        cityItem.children.append(areaEnity)
                        cityItem.childrenSize = cityItem.childrenSize + 1
                    }
                    
                }else{
                    
                    areaEnity.children.append(projectItem)
                    areaEnity.childrenSize = areaEnity.childrenSize + 1
                    
                    cityEnity.children.append(areaEnity)
                    cityEnity.childrenSize = cityEnity.childrenSize + 1
                    
                    provinceItem.children.append(cityEnity)
                    provinceItem.childrenSize = provinceItem.childrenSize + 1
                }
                
                
            }else{
                areaEnity.children.append(projectItem)
                areaEnity.childrenSize =  areaEnity.childrenSize + 1
                
                cityEnity.children.append(areaEnity)
                cityEnity.childrenSize = cityEnity.childrenSize + 1
                
                provinceEnity.children.append(cityEnity)
                provinceEnity.childrenSize = provinceEnity.childrenSize + 1
                
                resItem.provinceItem.append(provinceEnity)
            }
            
        }
        return resItem
    }
    
    private static func queryLocationId(locationId: String) -> [String : String]{
        var res = [String : String]()
        
        let range1 = locationId.startIndex..<locationId.index(locationId.startIndex, offsetBy: 2)
        let range2 = locationId.startIndex..<locationId.index(locationId.startIndex, offsetBy: 4)
        
        let provinceId: String = locationId[range1] + "0000"
        let cityId: String = locationId[range2] + "00"
        
        var i = 0
        for item in self.addressItem.provinceItem {
            if item.id == provinceId {
                //找到省
                res[provinceId] = item.name
                break
            }
            i += 1
        }
        if i < self.addressItem.provinceItem.count {
            var j = 0
            let province = self.addressItem.provinceItem[i]
            for item in province.children{
                //找到市
                if item.id == cityId {
                    res[cityId] = item.name
                    break
                }
                j += 1
            }
            if j < province.children.count {
                let city = province.children[j] as! CityItem
                for item in city.children {
                    
                    //找到地区
                    if item.id == locationId {
                        res[locationId] = item.name
                        break
                    }
                }
                
                
                
            }
            
        }
        return res
    }
}
