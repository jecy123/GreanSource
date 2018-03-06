//
//  ProjectInfoViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/21.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目信息界面
class ProjectInfoViewController: BasePageViewController {

    let titles: [String] = ["项目名称：", "项目位置：", "设计处理量：", "排放标准：", "达标排放量：", "太阳能发电电能："]
    let contents: [String] = ["", "", "", "", "", ""]
    
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
        let infoFrame = CGRect(x: 0, y: 100, width: itemBgWidth, height: itemBgHeight - 120)
        addInfoView(infoViewFrame: infoFrame, titleRatio: 0.4, titles: titles, contents: contents)
    }
    
    override func refreshProject() {
        print("Refresh Project!!")
        self.infomationView.refreshOneContent(at: 0, content: selectedProject.projectName)
        self.infomationView.refreshOneContent(at: 1, content: selectedProject.locationName)
        self.infomationView.refreshOneContent(at: 2, content: String(selectedProject.capability) + "D/T")
        self.infomationView.refreshOneContent(at: 3, content: String(selectedProject.emissionStandards) + "D/T")
        self.infomationView.refreshOneContent(at: 4, content: "0")
        self.infomationView.refreshOneContent(at: 5, content: selectedProject.street)
    }
    
}
