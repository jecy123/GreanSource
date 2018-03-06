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

protocol MainViewTitleItemDelegate {
    func onBack(_ sender: UIButton)
    func onMenu(_ sender: UIButton)
}

class MainViewController: ISViewPagerContainer, TreeTableDelegate {
    let titlesAdmin = ["项目信息","运行状态","运行数据","项目添加","项目信息修改","设备信息修改","维护人员修改","找回信息审核"]
    let titlesEp = ["项目信息", "运行状态","运行数据"]
    
    var delegate:MainViewTitleItemDelegate?
    
    var pages:[BasePageViewController]!
    var viewType: MainViewType!{
        didSet{
            initViewPages(type: viewType)
        }
    }
    
    
    public var selectedProject: ShowProject!
    var projects:[ShowProject]!{
        didSet{
            guard let pages = self.pages else {
                return
            }
            for page in pages {
                page.allProjects = self.projects
            }
        }
    }
    
    public let screenWidth: CGFloat = UIScreen.main.bounds.width
    public static let topImageHeight: CGFloat = 120
    public static let titleViewHeight: CGFloat = 40
    
    public var imageTop: UIImageView!
    public var titleView: UIView!
    public var titleLabel: UILabel!

    public var projectListTreeView: TreeTableView!
    public var projectListPopover: Popover!
    
    public var titleName:String!{
        didSet{
            self.titleLabel?.text = titleName
        }
    }
    
    
    func initViewPages(type: MainViewType){
        switch type {
        case MainViewType.typeAdmin:
            self.titles = titlesAdmin
        default:
            //self.titles = titlesEp
            break
        }
        
        pages = [BasePageViewController]()
        
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
        
        self.titleName = "太阳能污水处理系统"
        self.viewPages = pages
        self.yOffset = MainViewController.topImageHeight
        self.view.backgroundColor = UIColor.white
        
        
    }
    
    init(options: [UIViewPagerOption], type: MainViewType) {
        super.init(nibName: nil, bundle: nil)
        self.options = options
        initViewPages(type: type)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPopover(){
        
        let options: [PopoverOption] = []
        
        projectListPopover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        projectListPopover.arrowSize.height = 0
        
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 3 * 2, height: self.view.frame.height * 0.75)
        projectListTreeView = TreeTableView(frame: frame, data1: AddressUtils.sunPowerItem.provinceItem, data2:AddressUtils.smartSysItem.provinceItem)
        projectListTreeView.treeTableDelegate = self
        
    }
    
    func addHeadView(){
        self.imageTop = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: MainViewController.topImageHeight))
        self.imageTop.image = UIImage(named: "top")
        self.view.addSubview(imageTop)
        
        self.titleView = UIView(frame: CGRect(x: 0, y: MainViewController.topImageHeight - MainViewController.titleViewHeight, width: screenWidth, height: MainViewController.titleViewHeight))
        
        let backBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 5, width: 40, height: 30))
        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        self.titleView.addSubview(backBtn)
        
        
        let menuBtn:UIButton = UIButton(frame: CGRect(x: screenWidth - 40, y: 5, width: 40, height: 30))
        menuBtn.setImage(UIImage(named: "arrow_menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(onMenu(_:)), for: .touchUpInside)
        self.titleView.addSubview(menuBtn)
        
        let titleLabelWidth = screenWidth - 80
        self.titleLabel = UILabel(frame: CGRect(x: 40, y: 0, width: titleLabelWidth, height: MainViewController.titleViewHeight))
        titleLabel.text = titleName
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.textAlignment = .center
        self.titleView.addSubview(titleLabel)
        
        self.titleView.backgroundColor = ColorUtils.mainThemeColor
        self.view.addSubview(titleView)
    }
    
    @objc public func onBack(_ sender: UIButton){
        print("MainView onBack调用")
        self.dismiss(animated: true, completion: nil)
        delegate?.onBack(sender)
    }
    
    @objc public func onMenu(_ sender: UIButton){
        print("MainView onMenu调用")
        let startPoint = CGPoint(x: self.view.frame.width - 20, y: 120)
        print("frame = \(projectListPopover.frame)")
        projectListPopover.show(projectListTreeView, point: startPoint)
        
        delegate?.onMenu(sender)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainView.navigationController = \(self.navigationController)")
        
        // Do any additional setup after loading the view.
        self.addHeadView()
        self.initPopover()
        
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func TreeTable(_ treeTableView: TreeTableView, section: Int, addressNames: [String], didSelectProject id: Int) {
        projectListPopover.dismiss()
        
        guard let projects = self.projects else {
            return
        }
        
        self.titleName = systemNames[section]
        print(section)
        print(id)
        print(addressNames)
        
        for project in projects {
            if project.id == id {
                self.selectedProject = project
                break
            }
        }
        
        for page in self.pages {
            page.addressNames = addressNames
            page.selectedProject = self.selectedProject
        }

    }
}
