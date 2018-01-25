//
//  tableItemView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/11.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

enum TableItemType{
    case typeText
    case typePopup
}

class TableItem
{
    var itemName:String!
    var itemType:TableItemType!
    var itemFrame: CGRect!
    var itemLabelRatio: CGFloat!
    init(name: String, type: TableItemType, frame:CGRect, ratio:CGFloat) {
        self.itemName = name
        self.itemType = type
        self.itemFrame = frame
        self.itemLabelRatio = ratio
    }
}

class TableItemView: UIView {
    var nameLabel:UILabel!
    var contentText:UITextField!
    var contentPopup:DropBoxView!
    
    ///constructor
    convenience init(parentVC:UIViewController, item: TableItem)
    {
        let type = item.itemType
        let frame = item.itemFrame!
        let labelRatio = item.itemLabelRatio!
        
        self.init(frame: frame)
        
        let rect = CGRect(x: 0, y: 0, width: frame.width * labelRatio - 5, height: frame.height)
        nameLabel = UILabel(frame: rect)
        nameLabel.textAlignment = .right
        nameLabel.font = UIFont.systemFont(ofSize: frame.height * 0.57)
        nameLabel.text = item.itemName
        
        
        self.addSubview(nameLabel)
        
        if type == TableItemType.typeText {
            
            let rect2 = CGRect(x:frame.width * labelRatio + 5, y:0, width:frame.width*(1 - labelRatio) - 5, height:frame.height)
            contentText = UITextField(frame: rect2)
            contentText.layer.masksToBounds = true
            contentText.layer.backgroundColor = UIColor.white.cgColor
            self.addSubview(contentText)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
