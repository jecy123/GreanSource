//
//  RunningDataViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/23.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//运行数据界面
class RunningDataViewController: BasePageViewController {
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
        initSelectedButtons()
    }
    
    func initSelectedButtons(){
        
        guard let type = self.viewType else {
            return
        }
        
        switch type {
        case .adminitor:
            addSelectedButtons(buttonTitles: ["设备信息", "定时运行", "紧急启停"], buttonWidth: 80, buttonHeight: 30)
        case .EP:
            addSelectedButtons(buttonTitles: ["设备信息"], buttonWidth: 80, buttonHeight: 30)
        case .mantainer:
            addSelectedButtons(buttonTitles: ["设备信息", "紧急启停"], buttonWidth: 80, buttonHeight: 30)
        }
    }
    
    override func onSelectedButtonClicked(_ sender: UIButton) {
        super.onSelectedButtonClicked(sender)
    }
}
