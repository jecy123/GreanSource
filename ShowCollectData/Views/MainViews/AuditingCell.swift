//
//  AuditingCell.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/29.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class AuditingCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var telPhone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var projectAddress: UILabel!
    @IBOutlet weak var applyTime: UILabel!
    @IBOutlet weak var auditAcceptSwitch: UISwitch!
    @IBOutlet weak var auditRejectSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
