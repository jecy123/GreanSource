//
//  MainViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

enum MainViewType{
    case typeAdmin      //管理员
    case typeMaintainer //维护员
    case typeEP         //环保部门人员
    case typeNormalUser //普通用户
}

class MainViewController: ISViewPagerContainer {
    let titlesAdmin = ["项目信息","运行状态","运行数据","项目添加","项目信息修改","设备信息修改","维护人员修改","找回信息审核"]
    
    init(options: [UIViewPagerOption], type: MainViewType) {
        super.init(nibName: nil, bundle: nil)
        self.options = options
        
        switch type {
        case .typeAdmin:
            self.titles = titlesAdmin
        default:
            break
        }
        //let titles = ["项目信息","运行状态","运行数据","项目添加","项目信息修改","设备信息修改","维护人员修改","找回信息审核"]
        var pages = [BasePageViewController]()
        
        let projectInfoView = ProjectInfoViewController(title:titles[0])
        pages.append(projectInfoView)
        
        let runningStateView = RunningStateViewController(title:titles[1])
        pages.append(runningStateView)
        
        let runningDataView = RunningDataViewController(title:titles[2])
        pages.append(runningDataView)
        
        let projectAddView = ProjectAddViewController(title:titles[3])
        pages.append(projectAddView)
        
        let projectModifyView = ProjectModifyViewController(title:titles[4])
        pages.append(projectModifyView)
        
        let deviceModifyView = DeviceModifyViewController(title:titles[5])
        pages.append(deviceModifyView)
        
        let maintainerView = MaintainerModifyViewController(title:titles[6])
        pages.append(maintainerView)
        
        let infoRefindView = InfoRefindViewController(title:titles[7])
        pages.append(infoRefindView)
        
        self.viewPages = pages
        self.view.backgroundColor = UIColor.white
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
