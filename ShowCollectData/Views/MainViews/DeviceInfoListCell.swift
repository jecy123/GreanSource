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
    
    @IBOutlet weak var labelDeviceName: UILabel!
    
    @IBOutlet weak var labelDeviceTag: UILabel!
    
    var delegate: DeviceInfoListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var labelFontSize: CGFloat = 0
        var btnWidth: CGFloat = 0
        var btnHeight: CGFloat = 0
        
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667.0 {
            labelFontSize = 12
            btnWidth = 40
            btnHeight = 20
        } else if screenH >= 667.0 && screenH < 736.0 {
            labelFontSize = 15
            btnWidth = 50
            btnHeight = 25
        } else if screenH >= 736.0 {
            labelFontSize = 17
            btnWidth = 60
            btnHeight = 30
        }
        
        labelDeviceName.font = UIFont.systemFont(ofSize: labelFontSize)
        labelDeviceTag.font = UIFont.systemFont(ofSize: labelFontSize)
        tfDeviceNo.font = UIFont.systemFont(ofSize: labelFontSize)
        tfTag.font = UIFont.systemFont(ofSize: labelFontSize)
        
        btnDelete.setTitleColor(UIColor.white, for: .normal)
        btnDelete.setTitleColor(ColorUtils.itemTitleViewBgColor, for: .highlighted)
        btnDelete.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        btnDelete.layer.cornerRadius = 4
        btnDelete.titleLabel?.font = UIFont.systemFont(ofSize: labelFontSize)
        btnDelete.bounds.size.width = btnWidth
        btnDelete.bounds.size.height = btnHeight
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
