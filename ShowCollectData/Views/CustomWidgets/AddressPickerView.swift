//
//  AddressPickerView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/7.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol AddressPickerViewDelegate {
    @objc optional func onPickerViewWillShow(addressPickerView: AddressPickerView, sender: Any?)
    @objc optional func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?)
    @objc optional func onPickerViewWillHide(addressPickerView: AddressPickerView, sender: Any?)
    @objc optional func onPickerViewDidHide(addressPickerView: AddressPickerView, sender: Any?)
    @objc optional func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String)
}

class AddressPickerView: UIView {
    
    var pickerViewHeight: CGFloat!
    let buttonHeight: CGFloat = 40
    let buttonWidth: CGFloat = 60
    let backgroudAlpha: CGFloat = 0.3
    let animateTime: Double = 0.3
    
    var contentViewY: CGFloat!
    
    let screenWidth = UIApplication.shared.keyWindow?.bounds.width
    let screenHeight = UIApplication.shared.keyWindow?.bounds.height
    
    var provinceItems: [BaseItem] = []
    var backgroundCover: UIView!
    var pickerView: UIPickerView!
    
    var contentView: UIView!
    var buttonCancel: UIButton!
    var buttonConfirm: UIButton!
    
    var contentFrame: CGRect!
    
    var locationId: String = ""
    var locationName: String = ""
    
    var sender: Any?
    
    var delegate: AddressPickerViewDelegate?
    
    init(provinceItems: [BaseItem], height: CGFloat) {
        self.provinceItems = provinceItems
        self.contentFrame = CGRect(x: 0, y: 0, width: screenWidth!, height: screenHeight!)
        super.init(frame: contentFrame)
        
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }
        if height < 100 {
            self.pickerViewHeight = 100
        }else{
            self.pickerViewHeight = height
        }
        let backgroundFrame = CGRect(origin: contentFrame.origin, size: contentFrame.size)
        self.backgroundCover = UIView(frame: backgroundFrame)
        self.backgroundCover.backgroundColor = UIColor.black
        self.backgroundCover.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.addSubview(backgroundCover)
        
        
        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.backgroundCover.addGestureRecognizer(backgroundTapRecognizer)
        
        self.contentViewY = screenHeight! - pickerViewHeight - buttonHeight
        
        let contentViewFrame = CGRect(x: 0, y: contentViewY, width: screenWidth!, height: buttonHeight + pickerViewHeight + 1)
        self.contentView = UIView(frame: contentViewFrame)
        self.contentView.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        
        let cancelBtnFrame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        self.buttonCancel = UIButton(frame: cancelBtnFrame)
        self.buttonCancel.setTitle("取消", for: .normal)
        self.buttonCancel.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        self.buttonCancel.setTitleColor(UIColor.blue, for: .highlighted)
        self.buttonCancel.addTarget(self, action: #selector(onCancelBtnClicked(_:)), for: .touchUpInside)
        self.contentView.addSubview(buttonCancel)
        
        let confirmBtnFrame = CGRect(x: screenWidth! - buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
        self.buttonConfirm = UIButton(frame: confirmBtnFrame)
        self.buttonConfirm.setTitle("确认", for: .normal)
        self.buttonConfirm.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        self.buttonConfirm.setTitleColor(UIColor.blue, for: .highlighted)
        self.buttonConfirm.addTarget(self, action: #selector(onConfirmBtnClicked(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(buttonConfirm)
        
        let pickerViewFrame = CGRect(x: 0, y: buttonHeight, width: screenWidth!, height: pickerViewHeight)
        pickerView = UIPickerView(frame: pickerViewFrame)
        
        //pickerView.backgroundColor = UIColor.gray
        pickerView.delegate = self
        pickerView.dataSource = self
        self.contentView.addSubview(pickerView)
        
        rootView.addSubview(self)
        self.isHidden = true
        self.contentView.frame.origin.y = self.screenHeight!
        
    }
    
    override func layoutSubviews() {
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        self.delegate?.onPickerViewWillShow?(addressPickerView: self, sender: self.sender)
        self.isHidden = false
        self.backgroundCover.alpha = 0
        
        self.contentView.superview?.bringSubview(toFront: self.contentView)
        
        UIView.animate(
            withDuration: animateTime,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.backgroundCover.alpha = self.backgroudAlpha
                self.contentView.frame.origin.y = self.contentViewY
                //self.pickerView.frame.size.height = self.pickerViewHeight
        }, completion: { _ in
            self.delegate?.onPickerViewDidShow?(addressPickerView: self, sender: self.sender)
        })
        //self.backgroundCover.superview?.bringSubview(toFront: self.backgroundCover)
    }
    
    @objc func dismiss(){
        self.delegate?.onPickerViewWillHide?(addressPickerView: self, sender: self.sender)
        self.backgroundCover.alpha = self.backgroudAlpha
        
        UIView.animate(
            withDuration: animateTime,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations:{
                self.backgroundCover.alpha = 0
                self.contentView.frame.origin.y = self.screenHeight!
        },completion: { _ in
            self.isHidden = true
            self.delegate?.onPickerViewDidHide?(addressPickerView: self, sender: self.sender)
        }
        )
    }
}

extension AddressPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.provinceItems.count
        }
        if component == 1 {
            let selectedP = pickerView.selectedRow(inComponent: 0)
            return self.provinceItems[selectedP].children.count
        }
        if component == 2 {
            let selectedP = pickerView.selectedRow(inComponent: 0)
            let selectedC = pickerView.selectedRow(inComponent: 1)
            if AddressUtils.addressItem.provinceItem[selectedP].childrenSize != 0 {
                return self.provinceItems[selectedP].children[selectedC].children.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.provinceItems[row].name
        }
        if component == 1 {
            let selectedP = pickerView.selectedRow(inComponent: 0)
            let province = self.provinceItems[selectedP]
            if row < 0 || row > province.children.count - 1 {
                return nil
            }
            return province.children[row].name
        }
        if component == 2{
            let selectedP = pickerView.selectedRow(inComponent: 0)
            let selectedC = pickerView.selectedRow(inComponent: 1)
            let p = self.provinceItems[selectedP]
            if selectedC < 0 || selectedC > p.children.count - 1 {
                return nil
            }
            let city = self.provinceItems[selectedP].children[selectedC]
            if row < 0 || row > city.children.count - 1 {
                return nil
            }
            return city.children[row].name
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            //let selectC = pickerView.selectedRow(inComponent: 1)
            //let selectR = pickerView.selectedRow(inComponent: 2)
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            break
        case 1:
            //let selectR = pickerView.selectedRow(inComponent: 2)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            break
        default:
            break
        }
    }
}

extension AddressPickerView {
    @objc func onCancelBtnClicked(_ sender: UIButton){
        self.dismiss()
    }
    
    @objc func onConfirmBtnClicked(_ sender: UIButton){
        self.locationName = ""
        self.locationId = ""
        
        let p = pickerView.selectedRow(inComponent: 0)
        let c = pickerView.selectedRow(inComponent: 1)
        let a = pickerView.selectedRow(inComponent: 2)
        
        let province = self.provinceItems[p]
        self.locationName.append(province.name)
        self.locationId = province.id
        
        if province.childrenSize != 0 {
            
            let city = province.children[c]
            self.locationName.append(city.name)
            self.locationId = city.id
            
            if city.childrenSize != 0{
                let area = city.children[a]
                self.locationName.append(area.name)
                self.locationId = area.id
            }else{
                print("请选择地区")
                ToastHelper.showGlobalToast(message: "请选择地区！")
                return
            }
        }else{
            print("请选择市")
            ToastHelper.showGlobalToast(message: "请选择市！")
            return
        }
        self.dismiss()
        delegate?.onPickerViewSelected?(addressPickerView: self, sender: self.sender, locationId: self.locationId, locationName: self.locationName)
    }
}

