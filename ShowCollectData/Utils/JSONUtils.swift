//
//  JSONUtils.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class JSONUtils{
    
    static func toJSONString(dic: NSDictionary)->String{
        if (!JSONSerialization.isValidJSONObject(dic)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        let str = JSONString! as String
        //str.insert("<", at: String.Index(0))
        //str.insert("\0", at: String.Index(0))
        //print("JSON = \(str.data(using: .utf8)?.base64EncodedString())")
        return str
    }
    
    static func getDictionaryFromJSONString(jsonString:String) -> NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
}
