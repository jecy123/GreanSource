//
//  ShowCommitBatch.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/31.
//  Copyright © 2018年 星空. All rights reserved.
//

import Foundation

///批量提交类
class ShowCommitBatch: BaseData {
    ///设备批量增加列表
    var batchAdds: [ShowDevice]!
    
    var batchDels: [ShowDevice]!
    
    override func toDic() -> [String : Any] {
        var dic = super.toDic()
        if let batchAdds = self.batchAdds {
            if batchAdds.count != 0 {
                var addDics = Array<NSDictionary>()
                for device in batchAdds {
                    let addDic = device.toDic() as NSDictionary
                    addDics.append(addDic)
                }
                dic["batchAdds"] = addDics
            }
        }
        
        if let batchDels = self.batchDels {
            if batchDels.count != 0 {
                var delDics = Array<NSDictionary>()
                for device in batchDels {
                    let delDic = device.toDic() as NSDictionary
                    delDics.append(delDic)
                }
                dic["batchDels"] = delDics
            }
        }
        return dic
    }
    
    
    override func fromDictionary(dic: NSDictionary) {
        
    }
}
