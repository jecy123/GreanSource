//
//  DeviceListCellTableViewCell.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/30.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol DeviceInfoListCellDelegate {
    @objc optional func onDelButtonClick(at index: Int)
}

class DeviceInfoListCell: UITableViewCell {

    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var tfTag: UITextField!
    @IBOutlet weak var tfDeviceNo: UITextField!
    
    var delegate: DeviceInfoListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnDelete.setTitleColor(UIColor.white, for: .normal)
        btnDelete.setTitleColor(ColorUtils.itemTitleViewBgColor, for: .highlighted)
        btnDelete.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        btnDelete.layer.cornerRadius = 4
        btnDelete.addTarget(self, action: #selector(onDeleteBtnClick(_:)), for: .touchUpInside)
        
        tfDeviceNo.delegate = self
        tfTag.delegate = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func onDeleteBtnClick(_ sender: UIButton) {
        delegate?.onDelButtonClick?(at: sender.tag)
    }
    
}

extension DeviceInfoListCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
