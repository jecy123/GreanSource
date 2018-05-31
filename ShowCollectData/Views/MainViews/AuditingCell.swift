//
//  AuditingCell.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/29.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol AuditingCellDelegate {
    @objc optional func doAuditingAccept(cellId: Int)
    @objc optional func doAuditingReject(cellId: Int)
}

class AuditingCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var telPhone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var projectAddress: UILabel!
    @IBOutlet weak var applyTime: UILabel!
    @IBOutlet weak var auditAcceptSwitch: UISwitch!
    @IBOutlet weak var auditRejectSwitch: UISwitch!
    
    var cellIdNo: Int!
    var delegate: AuditingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //审核通过
    @IBAction func onAuditAccept(_ sender: UISwitch) {
        guard let cellIdNo = self.cellIdNo else {
            return
        }
        if sender.isOn {
            delegate?.doAuditingAccept?(cellId: cellIdNo)
        }
    }
    
    //审核驳回
    @IBAction func onAuditReject(_ sender: UISwitch) {
        guard let cellIdNo = self.cellIdNo else {
            return
        }
        if sender.isOn {
            delegate?.doAuditingReject?(cellId: cellIdNo)
        }
    }
    
    
}
