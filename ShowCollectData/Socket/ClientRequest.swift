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
    
    //项目修改
    public static func modifyProject(){
        
    }
}
