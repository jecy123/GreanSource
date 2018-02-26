//
//  ShowMessage.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/25.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowMessage {
    var flag:UInt8!
    var msgTotalLen:UInt32!
    var msgCode:UInt32!
    var statusCode:UInt32!
    var msgLen:UInt16!
    var msgStr:String!
   
    init() {
        
    }
    
    init(flag: UInt8, totalLen: UInt32, code: UInt32, status:UInt32, msgLen:UInt16, msgStr:String) {
        self.flag = flag
        self.msgTotalLen = totalLen
        self.msgCode = code
        self.statusCode = status
        self.msgLen = msgLen
        self.msgStr = msgStr
    }
    
    init(code: UInt32, msg: String) {
        self.msgCode = code
        self.msgStr = msg
    }
}
