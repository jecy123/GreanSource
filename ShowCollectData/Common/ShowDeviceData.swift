//
//  ShowDeviceData.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/17.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class ShowDeviceData: BaseData{
    
    var ain1: String!      // 第1路4-20mA
    var ain2: String!      // 第2路4-20mA
    var ain3: String!      // 第3路4-20mA
    
    var ild1: String!      // 负载1电流
    var ild2: String!      // 负载2电流
    var ild3: String!      // 负载3电流
    var ild4: String!      // 负载4电流
    
    var ecd1: Double!    //负载1累计能耗 kwh U*I*10 + PREV_SUM
    var ecd2: Double!    //负载2累计能耗 kwh
    var ecd3: Double!    //负载3累计能耗 kwh
    var ecd4: Double!    //负载4累计能耗 kwh
    
    var id: Int!
    var req: String!
    var uuid: String!      // 设备号
    var fmid: String!      // 固件版本
    
    var vssun: String!     // 太阳能板电压
    var ichg: String!      // 电池充电电流
    var vbat: String!      // 电池电压
    var level: String!     // 电池剩余容量
    var pchg: String!      // 充电累积度数
    var pdis: String!      // 放电累积度数
    var temp: String!      // 电池温度
    var stat: String!      // 控制器状态
    
    var utcTime: String!   // GPS时间
    var latitude: String!  // GPS纬度
    var longtitude: String! // GPS经度
    
    var createTime: String!
    var safeTime: Int64!    //安全运行时间
    var breakTime: Date!    //上次故障时间
    
    var offline: Bool!  //污水控制器是否在线
    
    required init() {
        super.init()
    }
    
    convenience init(uuid: String) {
        self.init()
        self.offline = false
        self.uuid = uuid
    }
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let ain1 = self.ain1 {
            dic["ain1"] = ain1
        }
        if let ain2 = self.ain2 {
            dic["ain2"] = ain2
        }
        if let ain3 = self.ain3 {
            dic["ain3"] = ain3
        }
        if let latitude = self.latitude {
            dic["altitude"] = latitude
        }
        
        if let breakTime = self.breakTime {
            dic["breakTime"] = breakTime.toJavaDateLongFormat()
        }
        if let longtitude = self.longtitude {
            dic["longtitude"] = longtitude
        }
        if let createTime = self.createTime {
            let time: Int64 = Int64(createTime)!
            dic["createTime"] = time
        }
        if let ecd1 = self.ecd1 {
            dic["ecd1"] = ecd1
        }
        if let ecd2 = self.ecd2 {
            dic["ecd2"] = ecd2
        }
        if let ecd3 = self.ecd3 {
            dic["ecd3"] = ecd3
        }
        if let ecd4 = self.ecd4 {
            dic["ecd4"] = ecd4
        }
        if let fmid = self.fmid {
            dic["fmid"] = fmid
        }
        if let ichg = self.ichg {
            dic["ichg"] = ichg
        }
        if let id = self.id {
            dic["id"] = id
        }
        if let ild1 = self.ild1 {
            dic["ild1"] = ild1
        }
        if let ild2 = self.ild2 {
            dic["ild2"] = ild2
        }
        if let ild3 = self.ild3 {
            dic["ild3"] = ild3
        }
        if let ild4 = self.ild4 {
            dic["ild4"] = ild4
        }
        if let level = self.level {
            dic["level"] = level
        }
        if let offline = self.offline {
            dic["offline"] = offline
        }
        if let pchg = self.pchg {
            dic["pchg"] = pchg
        }
        if let pdis = self.pdis {
            dic["pdis"] = pdis
        }
        if let req = self.req {
            dic["req"] = req
        }
        if let safeTime = self.safeTime {
            dic["safeTime"] = safeTime
        }
        if let stat = self.stat {
            dic["stat"] = stat
        }
        if let temp = self.temp {
            dic["temp"] = temp
        }
        if let utcTime = self.utcTime {
            dic["utcTime"] = utcTime
        }
        if let uuid = self.uuid {
            dic["uuid"] = uuid
        }
        if let vbat = self.vbat {
            dic["vbat"] = vbat
        }
        if let vssun = self.vssun {
            dic["vssun"] = vssun
        }
        
        return dic
    }
    
    override func fromDictionary(dic: NSDictionary) {
        super.fromDictionary(dic: dic)
        if let ain1 =  dic["ain1"]{
            self.ain1 = ain1 as! String
        }
        if let ain2 =  dic["ain2"]{
            self.ain2 = ain2 as! String
        }
        if let ain3 =  dic["ain3"]{
            self.ain3 = ain3 as! String
        }
        
        if let breakTime = dic["breakTime"]{
            let javaLongDateFormat = breakTime as! Int64
            self.breakTime = Date(javaDateLongFormat: javaLongDateFormat)
        }
        
        if let latitude = dic["altitude"] {
            self.latitude = latitude as! String
        }
        
        if let longtitude = dic["longtitude"]{
            self.longtitude = longtitude as! String
        }
        if let createTime = dic["createTime"] {
            let time: Int64 = createTime as! Int64
            self.createTime = String(time)
        }
        if let ecd1 = dic["ecd1"] {
            self.ecd1 = ecd1 as! Double
        }
        if let ecd2 = dic["ecd2"] {
            self.ecd2 = ecd2 as! Double
        }
        if let ecd3 = dic["ecd3"] {
            self.ecd3 = ecd3 as! Double
        }
        if let ecd4 = dic["ecd4"] {
            self.ecd4 = ecd4 as! Double
        }
        if let fmid = dic["fmid"] {
            self.fmid = fmid as! String
        }
        if let ichg = dic["ichg"] {
            self.ichg = ichg as! String
        }
        if let id = dic["id"]{
            self.id = id as! Int
        }
        if let ild1 = dic["ild1"] {
            self.ild1 = ild1 as! String
        }
        if let ild2 = dic["ild2"] {
            self.ild2 = ild2 as! String
        }
        if let ild3 = dic["ild3"] {
            self.ild3 = ild3 as! String
        }
        if let ild4 = dic["ild4"] {
            self.ild4 = ild4 as! String
        }
        if let level = dic["level"] {
            self.level = level as! String
        }
        if let offline = dic["offline"] {
            self.offline = offline as! Bool
        }
        if let pchg = dic["pchg"] {
            self.pchg = pchg as! String
        }
        if let pdis = dic["pdis"] {
            self.pdis = pdis as! String
        }
        if let req = dic["req"] {
            self.req = req as! String
        }
        if let safeTime = dic["safeTime"] {
            self.safeTime = safeTime as! Int64
        }
        if let stat = dic["stat"] {
            self.stat = stat as! String
        }
        if let temp = dic["temp"] {
            self.temp = temp as! String
        }
        if let utcTime = dic["utcTime"] {
            self.utcTime = utcTime as! String
        }
        if let uuid = dic["uuid"] {
            self.uuid = uuid as! String
        }
        if let vbat = dic["vbat"] {
            self.vbat = vbat as! String
        }
        if let vssun = dic["vssun"] {
            self.vssun = vssun as! String
        }
    }
}


