//
//  ConnectAPI.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation
class ConnectAPI{
    
    init() {
    }
    
    ///测试平台ip地址
    public static let serverIp: String = "39.107.24.81"
    ///正式平台ip地址
    //public static let serverIp: String = "123.56.76.77"
    public static let serverPort: UInt16 = 10122
    /**
     * 指令码
     */
    // 业务终端指令
    public static let LOGIN_COMMAND: Int32 = 0x000001;
    // 工作模式更新
    public static let WORKING_MODE_UPDATE_COMMAND: Int32 = 0x000003;
    // 获取模式设置指令
    public static let GET_WORKING_MODE_COMMAND: Int32 = 0x000004;
    // 警告通知指令
    public static let WARNNING_COMMAND: Int32 = 0x000005;
    
    // 升级指令
    public static let APP_UPGRADE_COMMAND: Int32 = 0x000006;
    
    // 查询数据服务器地址
    public static let DATA_SERVER_QUERY_COMMAND: Int32 = 0x000007;
    
    // apk版本查询
    public static let APK_VERSION_QUERY_COMMAND: Int32 = 0x000009;
    
    // 11开始
    public static let ADDR_PROVINCES_QUERY_COMMAND: Int32 = 0x000011;
    public static let ADDR_CITIES_QUERY_COMMAND: Int32 = 0x000012;
    public static let ADDR_AREAS_QUERY_COMMAND: Int32 = 0x000013;
    
    public static let PROJECT_ADD_COMMAND: Int32 = 0x000014;
    public static let PROJECT_UPDATE_COMMAND: Int32 = 0x000015;
    public static let PROJECT_DELETE_COMMAND: Int32 = 0x000016;
    
    public static let ACCOUNT_ADD_COMMAND: Int32 = 0x000017;
    public static let ACCOUNT_UPDATE_COMMAND: Int32 = 0x000018;
    public static let ACCOUNT_DELETE_COMMAND: Int32 = 0x000019;
    
    public static let VCODE_GET_COMMAND: Int32 = 0x000020;
    
    public static let ACCOUNT_FINDBACK_COMMAND: Int32 = 0x000021;
    public static let ACCOUNT_FINDBACK_QUERY_COMMAND: Int32 = 0x000022;
    public static let ACCOUNT_FINDBACK_AUDIT_COMMAND: Int32 = 0x000023;
    
    public static let ACCOUNT_QUERY_COMMAND: Int32 = 0x000024;
    public static let ACCOUNT_AUDIT_COMMAND: Int32 = 0x000025;
    public static let ACCOUNT_PROJECT_CHECK_COMMAND: Int32 = 0x000026;
    
    public static let PROJECT_QUERY_COMMAND: Int32 = 0x000027;
    
    public static let PROJECT_SELECT_COMMAND: Int32 = 0x000028;
    
    public static let ACCOUNT_AUDIT_QUERY_COMMAND: Int32 = 0x000029;
    
    public static let ACCOUNT_SELECT_COMMAND: Int32 = 0x000030;
    
    public static let DEVICES_IN_PROJECT_COMMAND: Int32 = 0x000031;
    
    public static let DEVICES_RUNNINGDATA_COMMAND: Int32 = 0x000032;
    
    public static let DEVICES_UPDATE_COMMAND: Int32 = 0x000033;
    //增加单个设备
    public static let DEVICES_ADD_COMMAND: Int32 = 0x000034;
    
    public static let DEVICES_SCHEDULE_COMMAND: Int32 = 0x000035
    
    public static let DEVICES_UPGRADECTR_COMMAND: Int32 = 0x000036
    
    public static let PROJECT_DEVICES_CTRL_COMMAND: Int32 = 0x000037
    //删除单个设备
    public static let DEVICES_DEL_COMMAND: Int32 = 0x000038
    //批量增加项目和减少设备
    public static let DEVICES_BATCH_COMMAND: Int32 = 0x000039
    //项目总电量
    public static let PROJECT_CALC_PCHG_COMMAND: Int32 = 0x000040
    // 控制终端指令
    public static let CTRL_COMMAND: Int32 = 0x999999
    
    /**
     * 响应吗
     */
    
    public static let CONNECTLOST_RESPONSE: Int32 = -0x100000
    public static let ZERO_RESPONSE: Int32 = 0x100000
    public static let ERROR_RESPONSE: Int32 = 0x100000
    public static let FAILURE_RESPONSE: Int32 = 0x100000
    
    public static let LOGIN_RESPONSE: Int32 = 0x100001
    public static let SUCCESS_RESPONSE: Int32 = 0x100002
    
    public static let WORKING_MODE_UPDATE_RESPONSE: Int32 = 0x100003
    public static let GET_WORKING_MODE_RESPONSE: Int32 = 0x100004
    
    // 警告信息响应
    public static let WARNNING_RESPONSE: Int32 = 0x100005
    
    public static let APP_UPGRADE_RESPONSE: Int32 = 0x100006
    
    // 查询数据服务器地址
    public static let DATA_SERVER_QUERY_RESPONSE: Int32 = 0x100007
    
    public static let APP_VERSION_QUERY_RESPONSE: Int32 = 0x100009
    
    public static let ADDR_PROVINCES_QUERY_RESPONSE: Int32 = 0x100011
    public static let ADDR_CITIES_QUERY_RESPONSE: Int32 = 0x100012
    public static let ADDR_AREAS_QUERY_RESPONSE: Int32 = 0x100013
    
    public static let PROJECT_ADD_RESPONSE: Int32 = 0x100014
    public static let PROJECT_UPDATE_RESPONSE: Int32 = 0x100015
    public static let PROJECT_DELETE_RESPONSE: Int32 = 0x100016
    
    public static let ACCOUNT_ADD_RESPONSE: Int32 = 0x100017
    public static let ACCOUNT_UPDATE_RESPONSE: Int32 = 0x100018
    public static let ACCOUNT_DELETE_RESPONSE: Int32 = 0x100019
    
    public static let VCODE_GET_RESPONSE: Int32 = 0x000020
    
    public static let ACCOUNT_FINDBACK_RESPONSE : Int32 = 0x100021
    public static let ACCOUNT_FINDBACK_QUERY_RESPONSE : Int32 = 0x100022
    public static let ACCOUNT_FINDBACK_AUDIT_RESPONSE : Int32 = 0x100023
    
    public static let ACCOUNT_QUERY_RESPONSE : Int32 = 0x100024
    public static let ACCOUNT_AUDIT_RESPONSE : Int32 = 0x100025
    public static let ACCOUNT_PROJECT_CHECK_RESPONSE : Int32 = 0x100026
    
    public static let PROJECT_QUERY_RESPONSE : Int32 = 0x100027
    public static let PROJECT_SELECT_RESPONSE : Int32 = 0x100028
    
    public static let ACCOUNT_AUDIT_QUERY_RESPONSE : Int32 = 0x100029
    
    public static let ACCOUNT_SELECT_RESPONSE : Int32 = 0x100030
    
    public static let DEVICES_IN_PROJECT_RESPONSE : Int32 = 0x100031
    
    public static let DEVICES_RUNNINGDATA_RESPONSE : Int32 = 0x100032
    
    public static let DEVICES_UPDATE_RESPONSE : Int32 = 0x100033
    public static let DEVICES_ADD_RESPONSE : Int32 = 0x100034
    public static let DEVICES_SCHEDULE_RESPONSE: Int32 = 0x100035
    public static let DEVICES_UPGRADECTR_RESPONSE: Int32 = 0x100036
    public static let PROJECT_DEVICES_CTRL_RESPONSE: Int32 = 0x100037
    
    public static let DEVICES_DEL_RESPONSE: Int32 = 0x100038
    
    public static let DEVICES_BATCH_RESPONSE: Int32 = 0x100039
    
    public static let PROJECT_CALC_PCHG_RESPONSE = 0x100040
    
    // 单片机
    public static let MC_ERROR_RESPONSE : String = "00";
    public static let MC_SUCCESS_RESPONSE : String = "99";
    // 设备接入
    public static let MC_DEVICES_ACCESS_COMMAND: String = "98";
    public static let MC_DEVICES_ACCESS_RESPONSE: String  = "98";
    // 数据上传指令
    public static let MC_DATA_UPLOAD_COMMAND: String = "01";
    public static let MC_DATA_UPLOAD_RESPONSE: String = "01";
    
    public static let MC_DEVICES_RUNNING_CTRL_RESPONSE: String  = "02"
    
    public static let MC_UPDATE_WARE_BLOCK_RESPONSE: String  = "03"
    public static let MC_UPDATE_WARE_BLOCK_COMMAND: String  = "04"
    public static let MC_PROJECT_RUNNINGMODE_RESPONSE: String = "05"

}
