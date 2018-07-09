//
//  DateUtils.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

extension Date {
    ///获取年月日小时
    func getDate()->(year: Int, month: Int, day: Int, hour: Int, minute:Int){
        let calender = Calendar.current
        
        let year = calender.component(.year, from: self)
        let month = calender.component(.month, from: self)
        let day = calender.component(.day, from: self)
        let hour = calender.component(.hour, from: self)
        let minute = calender.component(.minute, from: self)
        
        return (year, month, day, hour,minute)
    }
    
    ///java长整形日期数据格式转换成swift的Date
    init(javaDateLongFormat: Int64) {
        let interval = Double(javaDateLongFormat / 1000)
        self.init(timeIntervalSince1970: interval)
    }
    
    ///swif的Date转换成java中长整型日期数据格式
    func toJavaDateLongFormat() ->  Int64{
        let inteval = self.timeIntervalSince1970
        let longFormat = Int64(inteval * 1000)
        return longFormat
    }
    
    ///以format格式获取当前时间（yyyy-MM-dd HH:mm:ss）
    func getDateString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let str = formatter.string(from: self)
        return str
    }
}


