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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func onBack(_ sender: UIButton) {
    //        print("项目信息界面返回")
    //        self.delegate?.onMenu(self)
    //    }
    //
    override func onMenu(_ sender: UIButton) {
        print("运行状态界面菜单")
        self.delegate?.onBack(self)
    }
}
