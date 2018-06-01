//
//  GlobalVar.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/6.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

let systemNames = ["太阳能污水处理系统", "智能运维系统"]
let deviceNames = ["太阳能板", "电池", "曝气系统", "太阳能控制器"]
let deviceCountOpts = [[2, 4, 6, 8, 16, 24, 32], [2, 4, 6, 8, 16, 24, 32], [2, 2, 3, 3, 6, 9, 12], [1, 1, 1, 2, 4, 6, 8]]

let emissionStdAccessment: [Int : String] = [10 : "一级A", 20 : "一级A", 30 : "二级", 40 : "三级"]
let emissionStdNames = ["一级A", "一级B", "二级", "三级"]

let capcityList = [5, 10, 20, 30, 50, 100]
let emissionStd = [10, 20, 30, 40]

var loginAccount: String = ""

func getIndexOfCapcity(capcity: Int) -> Int{
    var i = 0
    for c in capcityList {
        if capcity == c {
            break
        }
        i += 1
    }
    return i
}

func getDeviceCountMsg(index: Int) -> String{
    guard index >= 0 && index < capcityList.count else{
        return ""
    }
    var msg = ""
    let cnt = deviceNames.count
    for i in 0..<cnt-1 {
        let str = deviceNames[i] + "×" + String(deviceCountOpts[i][index]) + ","
        msg += str
    }
    msg += deviceNames[cnt-1] + "×" + String(deviceCountOpts[cnt-1][index])
    return msg
}

func listToNames(list: [Int]) -> [String]{
    var resNames:[String] = []
    for item in list {
        resNames.append(String(item) + "D/T")
    }
    return resNames
}
