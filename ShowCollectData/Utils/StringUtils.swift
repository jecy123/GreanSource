//
//  StringUtils.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class StringUtils {
    
    public static func conventUint16ToUin8(value: UInt16, bigDean: Bool) ->[UInt8]{
        var res: [UInt8]
        
        let mask:UInt16 = 0x00ff
        let u1:UInt8 = UInt8(value & mask)
        let u2:UInt8 = UInt8((value >> 8) & mask)
        if bigDean {
            res = [u2, u1]
        }else{
            res = [u1, u2]
        }
        return res
    }
    
    public static func conventUint32ToUint8(value: UInt32, bigDean: Bool) -> [UInt8]
    {
        let mask:UInt32 = 0x000000ff
        let u1:UInt8 = UInt8(value & mask)
        let u2:UInt8 = UInt8((value >> 8) & mask)
        let u3:UInt8 = UInt8((value >> 16) & mask)
        let u4:UInt8 = UInt8((value >> 32) & mask)
        var res:[UInt8]
        if bigDean {
            res = [u4,u3,u2,u1]
        }else{
            res = [u1,u2,u3,u4]
        }
        print("result = \(res)")
        return res
        
    }
    
    public static func conventBytesToUint16(bytes:[UInt8], start: Int, bigDean:Bool) -> UInt16?{
        if start + 2 > bytes.count || start < 0 {
            print("Error, index out of range!")
            return nil
        }
        var res:UInt16 = 0
        
        let dataBytes = [bytes[start], bytes[start + 1]]
        let data = NSData(bytes: dataBytes, length: 2)
        data.getBytes(&res, length: 2)
        if bigDean {
            res = UInt16(bigEndian: res)
        }
        return res
    }
    
    public static func conventBytesToUint32(bytes:[UInt8], start: Int, bigDean: Bool) -> UInt32?{
        
        
        if start + 4 > bytes.count {
            print("Error, index out of range: \(start) ~ \(start + 3) while the size of bytes is \(bytes.count)")
            return nil
        }
        if start < 0 {
            print("Error, start index must be a positive number: start index = \(start)")
            return nil
        }
        
        var res:UInt32 = 0
        
        let dataBytes = [bytes[start], bytes[start + 1], bytes[start + 2], bytes[start + 3]]
        let data = NSData(bytes: dataBytes, length: 4)
        data.getBytes(&res, length: 4)
        if bigDean {
            res = UInt32(bigEndian: res)
        }
        return res
    }
    
    
    
    public static func conventBytesToString(bytes:[UInt8], start: Int) -> String?{
        if start > bytes.count {
            print("Error, index out of range: start = \(start) , while the size of bytes is \(bytes.count)")
            return nil
        }
        if start < 0 {
            print("Error, start index must be a positive number: start index = \(start)")
            return nil
        }
        
        var stringBytes = [UInt8]()
        for index in start ..< bytes.count {
            stringBytes.append(bytes[index])
        }
        
        let str = String(bytes: stringBytes, encoding: .utf8)!
        return str
    }
    
    public static func subString(of string: String, from: Int, to: Int) -> String?{
        guard from <= to else{
            return nil
        }
        let start = string.index(string.startIndex, offsetBy: from)
        let end = string.index(string.startIndex, offsetBy: to)
        return String(string[start...end])
    
    }
}
