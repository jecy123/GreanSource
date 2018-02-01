//
//  ToastHelper.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/29.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation
import UIKit

class ToastHelper {
    static let LENGTH_LONG: Double = 2
    static let LENGTH_SHORT: Double = 1
    
    static func showGlobalToast(message: String, duration: Double = LENGTH_SHORT){
        UIApplication.shared.keyWindow?.tgc_makeToast(message: message, duration: duration)
    }
    
    static func showToast(parent:UIView, message: String, duration:Double = LENGTH_SHORT){
        parent.tgc_makeToast(message: message, duration: duration)
    }
}
