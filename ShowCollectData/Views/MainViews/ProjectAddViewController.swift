//
//  ProjectAddViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目添加界面
class ProjectAddViewController: BasePageViewController {

    let titles = ["项目名称","项目类别","项目地址","街道","设计处理量","设备列表","排放标准","运维人员姓名","运维人员联系方式"]
    let projectTypeNames = systemNames
    let capcityListNames = listToNames(list: capcityList)
    let emissionStdNames = ["10D/T", "20D/T"]
    
    var newProject: ShowProject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initTableItemView()
    }
    
    func initTableItemView(){
        let x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = self.itemBgView.frame.width
        let h: CGFloat = (self.itemBgView.frame.height - 60) / CGFloat(self.titles.count)
        
        var dropBoxY1: CGFloat = 0
        var dropBoxY2: CGFloat = 0
        var dropBoxY3: CGFloat = 0
        
        var tableItemFrame: CGRect!
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[0], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[1], type: .typeText, withBottomLine: true)
        dropBoxY1 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[2], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[3], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[4], type: .typeText, withBottomLine: true)
        
        dropBoxY2 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[5], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[6], type: .typeText, withBottomLine: true)
        
        dropBoxY3 = y
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.3, title: titles[7], type: .typeText, withBottomLine: true)
        
        y += h
        tableItemFrame = CGRect(x: x, y: y, width: w, height: h - 1)
        addTableItemView(tableFrame: tableItemFrame, titleRatio: 0.4, title: titles[8], type: .typeText, withBottomLine: true)
        
        let btnWidth: CGFloat = 100
        let btnHeight: CGFloat = 40
        let rect = CGRect(x: (self.itemBgView.frame.width - btnWidth) / 2, y: self.itemBgView.frame.height - btnHeight - 10, width: btnWidth, height: btnHeight)
        addButton(buttonframe: rect, title: "确认添加", target: self, action: #selector(onConfirm(_:)), for: UIControlEvents.touchUpInside)
        

        //下拉列表和下拉按钮之间的偏移量计算
        let offSetX = self.itemBgView.frame.origin.x
        let offSetY = MainViewController.topImageHeight + self.itemBgView.frame.origin.y + 1
        let offset = CGPoint(x: offSetX, y: offSetY)
        
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY1, width: w * 0.7, height: h - 1), names: self.projectTypeNames, dropBoxOffset: offset, dropBoxDidSelected: self.onProjectTypeSelected)
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY2, width: w * 0.7, height: h - 1), names: self.capcityListNames, dropBoxOffset: offset, dropBoxDidSelected: self.onCapcityListSelected)
        addDropBox(dropBoxFrame: CGRect(x: x + w * 0.3, y: dropBoxY3, width: w * 0.7, height: h - 1), names:self.emissionStdNames, dropBoxOffset: offset, dropBoxDidSelected: self.onEmissionStdSelected)
        
        
        
    }
    
    @objc func onConfirm(_ sender: UIButton){
        
        print("确认添加")
    }
    
    func onProjectTypeSelected(row: Int){
        
        print("row = \(row)")
        
    }
    
    func onCapcityListSelected(row: Int){
        
    }
    
    func onEmissionStdSelected(row: Int){
        
    }

}
