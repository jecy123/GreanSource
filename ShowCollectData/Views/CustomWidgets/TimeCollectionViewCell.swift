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
        var size: CGFloat = 0
        var fontSize: CGFloat = 0
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667.0 {
            size = 25
            fontSize = 8
        } else if screenH >= 667.0 && screenH < 736.0 {
            size = 32
            fontSize = 10
        } else if screenH >= 736.0 {
            size = 40
            fontSize = 14
        }
        
        self.imageCheck.bounds.size = CGSize(width: size, height: size)
        self.labelTime.font = UIFont.systemFont(ofSize: fontSize)
        self.labelTime.adjustsFontSizeToFitWidth = true
    }

}
