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
    
    
    
}
