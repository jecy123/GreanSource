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
    
    //返回string中下标from到to之间的子字符串
    public static func subString(of string: String, from: Int, to: Int) -> String?{
        guard from <= to else{
            return nil
        }
        let start = string.index(string.startIndex, offsetBy: from)
        let end = string.index(string.startIndex, offsetBy: to)
        return String(string[start...end])
    
    }
    
    //检查字符串是否是手机号
    public static func isPhone(number: String) -> Bool {
        guard !number.isEmpty else{
            return false
        }
        var inputNumber = number.trimmingCharacters(in: .whitespaces)
        
        
        if inputNumber.hasPrefix("+86") && inputNumber != "+86" {
            inputNumber = subString(of: inputNumber, from: 3, to: inputNumber.count - 1)!
        }
        
        guard inputNumber.count == 11 else{
            return false
        }
        //利用正则表达式判断是不是全部都是数字
        let regex = "^[-\\+]?[\\d]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: inputNumber)
        
        guard isValid else {
            return false
        }
        return true
    }
    
    //检查字符串是否email
    public static func isEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    public static func stringToIntArray(value: String) -> [UInt32]?{
        //利用正则表达式判断是不是全部都是数字
        let regex = "^[-\\+]?[\\d]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: value)
        
        guard isValid else {
            return nil
        }
        
        var code = [UInt32]()
        for char in value {
            code.append(char.toNumber())
        }
        return code
    }
    
    //16位的16位进制整数数据字符串转换成UInt16
    public static func hexStringToUInt16(value: String) -> UInt16? {
        //判断数字是否满足16进制的条件
        let regex = "^[0-9a-zA-Z]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: value)
        guard isValid else {
            NSLog("Convert error: this string is not a hexadecimal string!")
            return nil
        }
        var sum: UInt16 = 0
        for i in value.utf8 {
            //a-f
            var codeValue: UInt8
            if i >= 97 && i <= 102 {
                codeValue = i - 87
            }else if i >= 65 && i <= 70 {
                codeValue = i - 55
            }else {
                codeValue = i - 48
            }
            sum = sum * 16 + UInt16(codeValue)
        }
        return sum
    }
    
    //32位的16位进制整数数据字符串转换成UInt16
    public static func hexStringToUInt32(value: String) -> UInt32? {
        //判断数字是否满足16进制的条件
        let regex = "^[0-9a-zA-Z]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: value)
        guard isValid else {
            NSLog("Convert error: this string is not a hexadecimal string!")
            return nil
        }
        var sum: UInt32 = 0
        for i in value.utf8 {
            //a-f
            var codeValue: UInt8
            if i >= 97 && i <= 102 {
                codeValue = i - 87
            }else if i >= 65 && i <= 70 {
                codeValue = i - 55
            }else {
                codeValue = i - 48
            }
            sum = sum * 16 + UInt32(codeValue)
        }
        return sum
    }
}

extension Character{
    func toNumber() -> UInt32{
        let str = String(self)
        var number: UInt32 = 0
        for code in str.unicodeScalars {
            number = code.value
        }
        return number - 48
    }
}
