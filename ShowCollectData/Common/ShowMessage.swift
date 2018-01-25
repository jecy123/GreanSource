//
//  ShowMessage.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/25.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowMessage {
    var msgCode:UInt32!
    var msgStr:String!
    init(code: UInt32, msg: String) {
        self.msgCode = code
        self.msgStr = msg
    }
}
