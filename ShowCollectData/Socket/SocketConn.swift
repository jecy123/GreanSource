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

    var readCount:Int
    var unreadCount:Int
    var responseMsg: ShowMessage!
    private var reconnectcount:Int = 0
    
    public var responceHandler:((RequestRet)->Void)?
    
    override init(){
        self.readCount = 0
        self.unreadCount = 0
        self.responseMsg = ShowMessage()
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
    
    func sendMessage(commandCode:Int32, msgBody:String, msgId:Int, completeHandler:@escaping ((RequestRet) -> Void)) {
        self.tag = msgId
        if(reconnectcount >= 1 ){
            if(reconnectcount >= 3){
                ToastHelper.showGlobalToast(message: "请检查网络")
                reconnectcount = 1
                return
            }
            ToastHelper.showGlobalToast(message: "重新连接中")
            self.connect()
            return
        }
        if let socket = self.socket {
            
            self.responceHandler = completeHandler
            
            let length:UInt32 = UInt32(MsgProtocol.msgCodeSize + msgBody.lengthOfBytes(using: String.Encoding.utf8) + MsgProtocol.msgLenSize)
            let msgLen:UInt16 = UInt16(msgBody.lengthOfBytes(using: String.Encoding.utf8))
            
            print("length = \(Int(length))")
            var muteableData:Data = Data()
            
            let flag:UInt8 = MsgProtocol.defaultFlag
            let msgTotalLength: [UInt8] = StringUtils.conventUint32ToUint8(value: length, bigDean: true)
            let msgCode: [UInt8] = StringUtils.conventUint32ToUint8(value: UInt32(commandCode), bigDean: true)
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
            ToastHelper.showGlobalToast(message: "请检查网络1")
        }
    }

    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功! ：服务器IP地址 " + host)
        if(reconnectcount>0){
            reconnectcount = 0
            ViewController.dologinagain()
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("向服务器发送数据完毕 tag=\(tag)")
        self.socket.readData(withTimeout: -1, tag: self.tag)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("断开连接")
        if let err = err{
            print("连接错误:\(err)")
            reconnectcount += 1
          /*  if(reconnectcount>1 && reconnectcount < 6 ){
               let thread:Thread = Thread{
                    Thread.sleep(forTimeInterval:2)
                    ViewController.dologinagain()
                    return
                }
                thread.start()
            }*/
        }
    }
    
    func readData(){
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
      /*  let readClientDataString: NSString? = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)*/
        print("---收到数据---")
     //   print(data.base64EncodedString())
        
        let bytes = [UInt8](data)
        //这里要分段获取数据，因为如果待获取的数据太长，可能需要不止一次的读取数据
        if readCount == 0 {
            //第一次获取到数据
            readCount += bytes.count
            print("数据长度 = \(bytes.count)")
            print("首次获取到数据")
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
                
                unreadCount = Int(msgTotalLen - UInt32(readCount))
                responseMsg = ShowMessage(flag: flag, totalLen: msgTotalLen, code: msgCode, status: statusCode, msgLen: msgLen, msgStr: responseStr)
                
            }else{
                responseMsg = nil
            }
            
        }else{
            //不是第一次获取到数据
            readCount += bytes.count
            print("数据长度 = \(bytes.count)")
            print("非首次读取数据")
            let responseStr = StringUtils.conventBytesToString(bytes: bytes, start: 0)
            if let str = responseStr{
                unreadCount =  unreadCount - bytes.count
                responseMsg.msgStr.append(str)
            }else{
                responseMsg = nil
            }
        }
        
        
        
        if let responseMsg = responseMsg
        {
            if unreadCount > 0 {
                //数据没有读完，还要再次读取数据
                self.socket.readData(withTimeout: -1, tag: self.tag)
                return
            }
            
            //当所有数据读取完成后就会执行这里的代码
            readCount = 0
            unreadCount = 0
            
            //let r:RequestRet = RequestRet.success(response: readClientDataString as! String)
            if let handler = self.responceHandler {
                handler(.success(responseMsg: responseMsg))
            }
        }else{
            print("Failed")
            
            readCount = 0
            unreadCount = 0
            
            if let handler = self.responceHandler{
                handler(.failed(errCode: .responseFormatError))
            }
        }
    }
}

