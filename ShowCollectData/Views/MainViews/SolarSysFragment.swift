//
//  SolarSYSFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/6/28.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class SolarSysFragment: BaseFragment{
    
    let titles = ["项目名称:", "项目类别:", "项目地址:", "街道:", "设备型号:", "设计处理量:","进水标准:", "COD:","氨氮:","总磷:","总氮:","PH值:","悬浮物:","排放标准:","COD:","氨氮:","总磷:","总氮:","PH值:","悬浮物:","运维人员姓名:","运维人员联系方式:"]
    
    let danwei = "mg/L"
    let nulltext = " "
    
    let capcityListNames = listToNames(list: capcityList)
    
    func initViews(parentVC: UIViewController) {
        
        let frameW = self.frame.width
        
        var dropBoxY1: CGFloat = 0
        var dropBoxY2: CGFloat = 0
        
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
        
        dropBoxY1 = startY
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[6], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[7], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[8], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[9], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[10], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[11], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: nulltext, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 2, titleRatio: 0.4, title: titles[12], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[13], type: .typeText, withBottomLine: true)
        
        dropBoxY2 = startY
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[14], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[15], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[16], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[17], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: titles[18], type: .typeText, withBottomLine: true)
  
        startPoint = CGPoint(x:  frameW / 3, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: nulltext, type: .typenull, withBottomLine: true)
        
        startPoint = CGPoint(x: frameW / 2, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 2, titleRatio: 0.4, title: titles[19], type: .typeText, withBottomLine: true)
        
        startPoint = CGPoint(x: 5 * frameW / 6, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW / 3, titleRatio: 0.4, title: danwei, type: .typenull, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[20], type: .typeText, withBottomLine: true)
        
        startY += itemH + 1
        startPoint = CGPoint(x: 0, y: startY)
        self.addTableItemView(parentVC: parentVC, start: startPoint, itemW: frameW, titleRatio: 0.4, title: titles[21], type: .typeText, withBottomLine: true)
        
         self.tableItemViews[2].contentText.addTarget(self, action: #selector(onAddressItemClicked(_:)), for: UIControlEvents.editingDidBegin)
        
        self.tableItemViews[16].nameLabel.isHidden = true
        
        
        //COD
        self.tableItemViews[20].contentText.isEnabled = false
        self.tableItemViews[20].contentText.textColor = UIColor.gray
        
        //氨氮
        self.tableItemViews[22].contentText.isEnabled = false
        self.tableItemViews[22].contentText.textColor = UIColor.gray
        
        //总氮
        self.tableItemViews[24].contentText.isEnabled = false
        self.tableItemViews[24].contentText.textColor = UIColor.gray
        
        //总磷
        self.tableItemViews[26].contentText.isEnabled = false
        self.tableItemViews[26].contentText.textColor = UIColor.gray
        
        //PH值
        self.tableItemViews[28].contentText.isEnabled = false
        self.tableItemViews[28].contentText.textColor = UIColor.gray
        
        //悬浮物
        self.tableItemViews[30].contentText.isEnabled = false
        self.tableItemViews[30].contentText.textColor = UIColor.gray
        
        
        addDropBox(dropBoxFrame: CGRect(x: frameW * 0.4, y: dropBoxY1, width: frameW * 0.6, height: itemH - 1), names: self.capcityListNames, dropBoxDidSelected: onCapcityListSelected)
        
        addDropBox(dropBoxFrame: CGRect(x: frameW * 0.4, y: dropBoxY2, width: frameW * 0.6, height: itemH - 1), names: emissionStdNames, dropBoxDidSelected: onEmissionStdSelected)
        
    }
    
    init(parentVC: UIViewController, frame: CGRect, itemH: CGFloat, dropBoxOffset: CGPoint) {
        super.init(frame: frame, itemH: itemH)
        self.dropBoxOffset = dropBoxOffset
        self.initViews(parentVC: parentVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCapcityListSelected(row: Int){
        guard row >= 0 && row <= capcityList.count - 1 else{
            return
        }
        print("capability = \(capcityList[row])")
        //newProject.capability = capcityList[row]
        //计算设备列表
    }
    
    func onEmissionStdSelected(row: Int){
        guard row >= 0 && row <= emissionStd.count - 1 else{
            return
        }
        print("emissionStd = \(emissionStd[row])")
        if row ==  0{
            //COD
            self.tableItemViews[20].contentText.text = "50"
            //氨氮
            self.tableItemViews[22].contentText.text = "5"
            //总磷
            self.tableItemViews[24].contentText.text = "0.5"
            //总氮
            self.tableItemViews[26].contentText.text = "15"
            //PH值
            self.tableItemViews[28].contentText.text = "6-9"
            //悬浮物
            self.tableItemViews[30].contentText.text = "10"
        }else {
            //COD
            self.tableItemViews[20].contentText.text = "60"
            //氨氮
            self.tableItemViews[22].contentText.text = "8"
            //总磷
            self.tableItemViews[24].contentText.text = "1"
            //总氮
            self.tableItemViews[26].contentText.text = "20"
            //PH值
            self.tableItemViews[28].contentText.text = "6-9"
            //悬浮物
            self.tableItemViews[30].contentText.text = "20"
            
        }
        //newProject.emissionStandards = emissionStd[row]
    }
    
}

extension SolarSysFragment  {
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

