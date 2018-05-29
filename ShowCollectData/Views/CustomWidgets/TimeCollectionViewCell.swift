//
//  TimeCollectionViewCell.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class TimeCellData {
    var title: String!
    var checked: Bool!
    init() {
    }
    
    init(title: String, checked: Bool) {
        self.title = title
        self.checked = checked
    }
    
}

class TimeCollectionViewCell: UICollectionViewCell {

    let imageChecked = UIImage(named: "btn_check_on_holo")
    let imageUnchecked = UIImage(named: "btn_check_off_holo")
    var data: TimeCellData! {
        didSet{
            labelTime.text = data.title
            if data.checked{
                imageCheck.image = imageChecked
            }else{
                imageCheck.image = imageUnchecked
            }
        }
    }
    
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
