//
//  SocketConn.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/19.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class SocketConn: NSObject, GCDAsyncSocketDelegate{
    
    public static var Instance: SocketConn = SocketConn()
    
    private var socket: GCDAsyncSocket!
    private var tag:Int!
    
    public var responceHandler:((RequestRet)->Void)?
    
    override init(){
        super.init()
        self.setup()
    }
    
    deinit {
        socket.disconnect()
    }
    func setup(){
        socket = GCDAsyncSocket()
        socket.delegate = self
        socket.delegateQueue = DispatchQueue.global()
        connect()
    }
    
    func sendMessage(commondCode:Int32, msgBody:String, msgId:Int, completeHandler:@escaping ((RequestRet) -> Void)) {
        self.tag = msgId
        
        if let socket = self.socket {
            
            self.responceHandler = completeHandler
            
            let length:UInt32 = UInt32(MsgProtocol.msgCodeSize + msgBody.lengthOfBytes(using: String.Encoding.utf8) + MsgProtocol.msgLenSize)
            let msgLen:UInt16 = UInt16(msgBody.lengthOfBytes(using: String.Encoding.utf8))
            
            print("length = \(Int(length))")
            var muteableData:Data = Data()
            
            let flag:UInt8 = MsgProtocol.defaultFlag
            let msgTotalLength: [UInt8] = StringUtils.conventUint32ToUint8(value: length, bigDean: true)
            let msgCode: [UInt8] = StringUtils.conventUint32ToUint8(value: UInt32(commondCode), bigDean: true)
            let msgLength: [UInt8] = StringUtils.conventUint16ToUin8(value: msgLen, bigDean: true)
            
            print("msgFlag = \(flag)")
            print("msgTotalLength = \(msgTotalLength)")
            print("msgCode = \(msgCode)")
            print("msgLen = \(msgLength)")
            print("msgBody = \(msgBody)")
    
            muteableData.append(flag)
            muteableData.append(msgTotalLength, count: MsgProtocol.lengthSize)
            muteableData.append(msgCode, count: MsgProtocol.msgCodeSize)
            muteableData.append(msgLength, count: MsgProtocol.msgLenSize)
            muteableData.append(msgBody.data(using: String.Encoding.utf8)!)
            
            print("dataL = \(muteableData.count)")
            print("data = \(muteableData.base64EncodedString())")
            
            socket.write(muteableData, withTimeout: -1, tag: self.tag)
            //socket.readData(withTimeout: -1, tag: self.tag)
        }
        
    }
    
    func connect(){
        
        do {
            try socket.connect(toHost: ConnectAPI.serverIp , onPort: ConnectAPI.serverPort)
        } catch {
            print("连接失败: \(error)")
        }
    }

    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功! ：服务器IP地址 " + host)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("向服务器发送数据完毕 tag=\(tag)")
        self.socket.readData(withTimeout: -1, tag: self.tag)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("断开连接")
        if let err = err{
            print("连接错误:\(err)")
            self.connect()
        }
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let readClientDataString: NSString? = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        print("---收到数据---")
        print(data.base64EncodedString())
        
        let bytes = [UInt8](data)
        
        let flag = bytes[0]
        let msgTotalLen = StringUtils.conventBytesToUint32(bytes: bytes, start: 1, bigDean: true)
        let msgCode = StringUtils.conventBytesToUint32(bytes: bytes, start: 5, bigDean: true)
        let statusCode = StringUtils.conventBytesToUint32(bytes: bytes, start: 9, bigDean: true)
        let msgLen = StringUtils.conventBytesToUint16(bytes: bytes, start: 13, bigDean: true)
        let responseStr = StringUtils.conventBytesToString(bytes: bytes, start: 15)
        
        if let msgTotalLen = msgTotalLen,
            let msgCode = msgCode,
            let statusCode = statusCode,
            let msgLen = msgLen,
            let responseStr = responseStr
        {
         
            
            
            print("===Success===")
            print("flag = \(flag)")
            print("msgTotalLen = \(msgTotalLen)")
            print("msgCode = \(msgCode)")
            print("statusCode = \(statusCode)")
            print("msgLen = \(msgLen)")
            
            //let r:RequestRet = RequestRet.success(response: readClientDataString as! String)
            if let handler = self.responceHandler {
                handler(.success(responseMsg: ShowMessage(code: msgCode, msg: responseStr)))
            }
        }else{
            print("Failed")
            
            if let handler = self.responceHandler{
                handler(.failed(errCode: .responseFormatError))
            }
        }
    }
}

