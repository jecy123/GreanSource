//
//  ClientRequest.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

enum socketErrorCode{
    case responseFormatError
    case jsonStringFormatError
}

enum RequestRet{
    case success(responseMsg: ShowMessage)
    case failed(errCode: socketErrorCode)
}

class ClientRequest {
    public static func login(accountName:String, password:String, completeHandler: @escaping ((ShowAccount?) -> Void)){
        let account:ShowAccount = ShowAccount()
        account.account = accountName
        account.password = password
        account.retCode = 0
        account.type = 0
        
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.LOGIN_COMMAND, msgBody: account.toJSON(), msgId: 0){
            res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError{
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError{
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.LOGIN_RESPONSE{
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resAccount = ShowAccount()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resAccount.fromDictionary(dic: dic)
                    
                    DispatchQueue.main.async {
                        completeHandler(resAccount)
                    }
                }else{
                    print("服务器消息响应码不符合条件！")
                    
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
            
        }
        
    }
    //项目新增
    public static func addProject(project: ShowProject, completeHandler: @escaping ((ShowProject?) -> Void)){
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.PROJECT_ADD_COMMAND, msgBody: project.toJSON(), msgId: 0){
            res in
            switch res{case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError{
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError{
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.PROJECT_ADD_RESPONSE{
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resProject = ShowProject()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resProject.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resProject)
                    }
                }else{
                    print("服务器消息响应码不符合条件！")
                    
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
                
            }
        }
        
    }
    
    //项目修改
    public static func modifyProject(project: ShowProject, completeHandler: @escaping ((ShowProject?) -> Void)){
        
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.PROJECT_UPDATE_COMMAND, msgBody: project.toJSON(), msgId: 0){
            res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError{
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError{
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.PROJECT_UPDATE_RESPONSE{
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resProject = ShowProject()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resProject.fromDictionary(dic: dic)
//                    let resAccount = ShowAccount()
//                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
//                    resAccount.fromDictionary(dic: dic)
//
                    DispatchQueue.main.async {
                        completeHandler(resProject)
                    }
                }else{
                    print("服务器消息响应码不符合条件！")
                    
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
        }
    }
    
    //获取验证码
    public static func getVertifyCode(phoneNumber: String, type: ShowVCodeType, completeHandler: @escaping ((ShowVCode?) -> Void) ){
        
        let vcode = ShowVCode()
        vcode.phone = phoneNumber
        vcode.type = type.rawValue
        
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.VCODE_GET_COMMAND, msgBody: vcode.toJSON(), msgId: 0){
            res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError{
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError{
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.VCODE_GET_RESPONSE{
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resVCode = ShowVCode()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resVCode.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resVCode)
                    }
                }else{
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
                break
            }
        }
    }
    
    public static func registerAccount(showAccount: ShowAccount, completeHandler: @escaping ((ShowResponse?) -> Void)){
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.ACCOUNT_ADD_COMMAND, msgBody: showAccount.toJSON(), msgId: 0){
            res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError{
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError{
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.ACCOUNT_ADD_RESPONSE{
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resResponse = ShowResponse()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resResponse.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resResponse)
                    }
                }else{
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
        }
    }
    
    //找回用户
    public static func refindAccount(showAccount: ShowAccount, completeHandler: @escaping ((ShowResponse?) -> Void)){
        
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.ACCOUNT_FINDBACK_COMMAND, msgBody: showAccount.toJSON(), msgId: 0){
            res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                //经过调试，发现这里正确返回数据，但是服务器返回的响应码为ACCOUNT_ADD_RESPONSE
                //但是依照常理，这里应该返回的响应码是ACCOUNT_FINDBACK_RESPONSE

                if msg.msgCode == ConnectAPI.ACCOUNT_ADD_RESPONSE {
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resResponse = ShowResponse()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resResponse.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resResponse)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }

        }
    }
    
    //获取项目总发电量
    public static func getTotalPChg(projectId: Int, completeHandler: @escaping ((ShowProjectInfo?) -> Void)){
        
        let projectInfo = ShowProjectInfo(projectId: projectId)
        
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.PROJECT_CALC_PCHG_COMMAND, msgBody: projectInfo.toJSON(), msgId: 0){
        res in
            switch res{
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.PROJECT_CALC_PCHG_RESPONSE {
                    print(msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let resProjectInfo = ShowProjectInfo()
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    resProjectInfo.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resProjectInfo)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
        }
        
    }
    
    //获取设备列表
    public static func getDeviceList(projectId: Int, completeHandler: @escaping ([ShowDevice]?) -> Void){
        let deviceConfig = ShowDevConfig(projectId: projectId)
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.DEVICES_IN_PROJECT_COMMAND, msgBody: deviceConfig.toJSON(), msgId: 0){
            res in
            switch res {
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.DEVICES_IN_PROJECT_RESPONSE {
                    print("JSON_STRING=" + msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let dics = JSONUtils.getDicsFromJSONString(jsonString: msg.msgStr)
                    
                    var devices = [ShowDevice]()
                    for dic in dics{
                        let device = ShowDevice()
                        device.fromDictionary(dic: dic)
                        devices.append(device)
                    }
                    DispatchQueue.main.async {
                        completeHandler(devices)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
        }
    }
    
    //获取设备运行信息
    public static func getDeviceData(uuid: String, completeHandler: @escaping ([ShowDeviceData]?) -> Void){
        let deviceData = ShowDeviceData(uuid: uuid)
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.DEVICES_RUNNINGDATA_COMMAND, msgBody: deviceData.toJSON(), msgId: 0){
            res in
            switch res {
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.DEVICES_RUNNINGDATA_RESPONSE {
                    print("JSON_STRING=" + msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let dics = JSONUtils.getDicsFromJSONString(jsonString: msg.msgStr)
                    
                    var deviceDatas = [ShowDeviceData]()
                    for dic in dics{
                        let deviceData = ShowDeviceData()
                        deviceData.fromDictionary(dic: dic)
                        deviceDatas.append(deviceData)
                    }
                    DispatchQueue.main.async {
                        completeHandler(deviceDatas)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
        }
        
    }
   
    public static func getTimingRunData(projectId: Int, completeHandler: @escaping (ProjectWorkingMode?) -> Void){
        let workingMode = ProjectWorkingMode(projectId: projectId)
        let workingJsonData = workingMode.toJSON()
        print("获取定时数据："+workingJsonData)
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.GET_WORKING_MODE_COMMAND, msgBody: workingJsonData, msgId: 0) {
            res in
            switch res {
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.GET_WORKING_MODE_RESPONSE {
                    print("JSON_STRING=" + msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    
                    let resWorkingMode = ProjectWorkingMode()
                    resWorkingMode.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resWorkingMode)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
            
        }
    }
    
    ///更新定时运行配置数据
    public static func updateTimingRunData(workingMode: ProjectWorkingMode, completeHandler: @escaping (BaseData?) -> Void){
        
        let workingJsonData = workingMode.toJSON()
        print("更新定时数据："+workingJsonData)
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.WORKING_MODE_UPDATE_COMMAND, msgBody: workingJsonData, msgId: 0) {
            res in
            switch res {
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.WORKING_MODE_UPDATE_RESPONSE {
                    print("JSON_STRING=" + msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let dic = JSONUtils.getDictionaryFromJSONString(jsonString: msg.msgStr)
                    
                    let resData = BaseData()
                    resData.fromDictionary(dic: dic)
                    DispatchQueue.main.async {
                        completeHandler(resData)
                    }
                }else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
            
        }
    
    }
    
    //项目紧急启停：
    public static func setProjectEmergencyStartOrStop(devicelistJson: String, completeHandler: @escaping ([ShowDevice]?) -> Void){
        SocketConn.Instance.sendMessage(commondCode: ConnectAPI.PROJECT_DEVICES_CTRL_COMMAND, msgBody: devicelistJson, msgId: 0){
            res in
            switch res {
            case .failed(let code):
                if code == socketErrorCode.jsonStringFormatError {
                    print("Json字符串格式错误！")
                }else if code == socketErrorCode.responseFormatError {
                    print("服务器响应字符串格式错误！")
                }
                
                DispatchQueue.main.async {
                    completeHandler(nil)
                }
            case .success(let msg):
                if msg.msgCode == ConnectAPI.PROJECT_DEVICES_CTRL_RESPONSE {
                    print("JSON_STRING=" + msg.msgStr)
                    print("成功收到服务器响应！")
                    
                    let dics = JSONUtils.getDicsFromJSONString(jsonString: msg.msgStr)
                    
                    var devices = [ShowDevice]()
                    for dic in dics{
                        let device = ShowDevice()
                        device.fromDictionary(dic: dic)
                        devices.append(device)
                    }
                    DispatchQueue.main.async {
                        completeHandler(devices)
                    }
                }
                else {
                    print("服务器消息响应码不符合条件！")
                    DispatchQueue.main.async {
                        completeHandler(nil)
                    }
                }
            }
            
        }
    }
    
    
    
}
