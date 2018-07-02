//
//  BaseFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/6/28.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class BaseFragment: UIView {
    
    var itemH: CGFloat!
    var tableItemTag: Int = 0
    var tableItemViews: [TableItemView] = []
    var dropBoxViews: [DropBoxView] = []
    
    var locationId: String?
    
    public var dropBoxOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    func addTableItemView(parentVC: UIViewController, start: CGPoint, itemW: CGFloat, titleRatio: CGFloat, title: String, type: TableItemType, withBottomLine: Bool, delegate: TableItemViewDelegate? = nil)
    {
        let tableFrame = CGRect(origin: start, size: CGSize(width: itemW, height: itemH))
        let tableItem = TableItem(name: title, type: type, frame: tableFrame, ratio: titleRatio,withBottomLine: withBottomLine)
        let tableItemView = TableItemView(parentVC: parentVC, item: tableItem)
        tableItemView.delegate = delegate
        
        tableItemView.tag = self.tableItemTag
        self.tableItemTag += 1
        
        self.addSubview(tableItemView)
        self.tableItemViews.append(tableItemView)
    }
    
    func addDropBox(dropBoxFrame: CGRect, names: [String], dropBoxDidSelected: @escaping (Int) -> Void){
        
        let dropBox = DropBoxView(title: "请选择", items: names, frame: dropBoxFrame, offset: self.dropBoxOffset)
        dropBox.isHightWhenShowList = true
        dropBox.didSelectBoxItemHandler = dropBoxDidSelected
        self.addSubview(dropBox)
        self.dropBoxViews.append(dropBox)
    }
    
    init(frame: CGRect, itemH: CGFloat) {
        super.init(frame: frame)
        self.itemH = itemH
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func onAddressItemClicked(_ sender: UITextField){
        let addressPickerView = AddressPickerView(provinceItems: AddressUtils.addressItem.provinceItem, height: 200)
        addressPickerView.delegate = self
        addressPickerView.show()
    }
    
}

extension BaseFragment : AddressPickerViewDelegate {
    func onPickerViewSelected(addressPickerView: AddressPickerView, sender: Any?, locationId: String, locationName: String) {
        print("locationId = \(locationId)")
        print("locationName = \(locationName)")
        self.locationId = locationId
    }
    
    func onPickerViewDidShow(addressPickerView: AddressPickerView, sender: Any?){
    }
}
