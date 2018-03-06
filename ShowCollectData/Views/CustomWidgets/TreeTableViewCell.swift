//
//  TreeTableViewCell.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/27.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class TreeTableViewCell: UITableViewCell {

    @IBOutlet weak var nodeImage: UIImageView!
    @IBOutlet weak var nodeName: UILabel!
    
    @IBOutlet weak var background:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
