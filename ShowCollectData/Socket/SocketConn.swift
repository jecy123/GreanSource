//
//  SocketConn.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/19.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

class SocketConn: NSObject, GCDAsyncSocketDelegate{
    let serverIp: String = "123.56.76.77"
    let serverPort: UInt16 = 10122
    
    private var socket: GCDAsyncSocket!
    override init(){
        super.init()
        self.setup()
    }
    func setup(){
        socket = GCDAsyncSocket()
        socket.delegate = self
        socket.delegateQueue = DispatchQueue.global()
        
        
    }
    
    func connect(){
        
        do {
            try socket.connect(toHost: serverIp, onPort: serverPort)
        } catch {
            print("try connect error: \(error)")
        }
        
    }

    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("success!  " + host)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("connect error:\(err)")
    }
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let readClientDataString: NSString? = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        print("---Data Recv---")
        print(readClientDataString)

    }
}

