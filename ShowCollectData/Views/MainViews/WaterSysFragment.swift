//
//  WaterSysFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/6/28.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class WaterSysFragment: BaseFragment {
    
    let titles = ["项目名称:", "项目类别:", "项目地址:", "街道:", "设备型号:", "增氧设备功率(W):", "增氧能力(KGO₂/H):", "动力效率(KGO₂/H):", "循环通量(M³/H):","辐射面积(M²):", "运维人员姓名:", "运维人员联系方式:"]
    

    func initViews(parentVC: UIViewController) {
        
        let frameW = self.frame.width
        
        var startY: CGFloat = 0
        var startPoint = CGPoint(x: 0, y: startY)
        //项目名称
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[0], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        //项目类别
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[1], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        //项目地址
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[2], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        //街道
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[3], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        //设备型号
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[4], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[5], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[6], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[7], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[8], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[9], type: .typeText, withBottomLine: true)
        
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[10], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[11], type: .typeText, withBottomLine: true)
        
        self.tableItemViews[2].contentText.addTarget(self, action: #selector(onAddressItemClicked(_:)), for: UIControlEvents.editingDidBegin)
        
    }
    
    
    init(parentVC: UIViewController, frame: CGRect, itemH: CGFloat) {
        super.init(frame: frame, itemH: itemH)
        self.initViews(parentVC: parentVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WaterSysFragment {
    override func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String) {
        super.onPickerViewSelected(addressPickerView: addressPickerView, sender: sender, locationId: locationId, locationName: locationName)
        self.tableItemViews[2].contentText.text = locationName
    }
    
    override func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?){
        //收起键盘
        self.tableItemViews[2].contentText.resignFirstResponder()
        self.tableItemViews[2].contentText.endEditing(true)
    }
}



