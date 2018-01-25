//
//  MsgProtocol.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

//客户端消息协议 = flag(1Byte) + MsgAndCodeLen(4Byte) + MsgCode(4Byte) + MsgLen(2Byte) + Msg(0~65535 Byte)
//服务器消息协议 = flag(1Byte) + MsgLen(4Byte) + ResponseCode(4Byte)+StatusCode(4Byte) + MsgLen(2Byte) +Msg(0~65535 Byte)
struct MsgProtocol {
    /** 默认flag值 */
    public static let defaultFlag :UInt8 = 1
    /** 最大长度 */
    public static let maxPackLength:Int = 1024 * 5;
    /** 标识数占得 byte数 */
    public static let flagSize:Int = 1
    /** 协议中 长度部分 占用的byte数,其值表示( 协议号+内容) 的长度 */
    public static let lengthSize:Int = 4
    /** 消息号占用的byte数 */
    public static let msgCodeSize:Int = 4
    /** 消息内容的长度 */
    public static let msgLenSize: Int = 2
    /**服务器消息的状态码**/
    public static let statusCodeSize: Int = 4
    
}
