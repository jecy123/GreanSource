//
//  RuningStateViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//运行状态界面
class RunningStateViewController: BasePageViewController{
    let titles:[String] = ["运行正常：", "故障报警：", "连续无故障运行时长：","上次故障发生日期："]
    let contents: [String] = ["", "", "  天  小时  分", "    年  月  日  时  分"]
    
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
        addTitleView(titleHeight: 40)
        let infoItemHeight:CGFloat = 60
        let height = infoItemHeight * CGFloat(self.titles.count)
        let y = (itemBgView.frame.height - height) / 2
        let infoFrame = CGRect(x: 0, y: 100, width: itemBgWidth, height: height)
        addInfoView(infoViewFrame: infoFrame, titleRatio: 0.5, titles: titles, contents: contents)
    }
    
    
}
