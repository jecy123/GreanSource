//
//  AddressUtils.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/26.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class AddressUtils {
    static var addressItem:AddressItem!
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
}
