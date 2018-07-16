//
//  MainViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/24.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit



protocol MainViewTitleItemDelegate {
    func onUser(_ sender: UIButton)
    func onBack(_ sender: UIButton)
    func onMenu(_ sender: UIButton)
}



class MainViewController: ISViewPagerContainer, TreeTableDelegate {
    let titlesGuest = ["项目信息"]
    let titlesAdmin = ["项目信息","运行状态","运行数据","项目添加","运维人员更变","设备信息修改","注册信息审核"]
    let titlesEp = ["项目信息", "运行状态","运行数据"]
    //当前页面的索引值
    var pageIndex: Int = -1
    
    var isFirstScroll: Bool = true
    
    var delegate:MainViewTitleItemDelegate?
    
    var pages:[BasePageViewController]!
    var viewType: AccountType!{
        didSet{
            initViewPages(type: viewType)
        }
    }
    
    public var addressNames: [String]!
    
    public var selectedProject: ShowProject!
    
    //如果保存了项目id，就获取选择保存的项目id对应的项目
    var selectedProjectId: Int!{
        didSet {
            guard let id = self.selectedProjectId else { return }
            guard let projects = self.projects else { return }
            for project in projects {
                if id == project.id {
                    self.selectedProject = project
                    break
                }
            }
        }
    }
    
    var account: ShowAccount! {
        didSet{
            guard let userInfoView = self.userInfoView else { return }
            userInfoView.labelUserType.text = AccountTypeHashMap[account.role]
            userInfoView.labelTelephone.text = "手机号：" + account.phone
            userInfoView.labelUserName.text = "姓名：" + account.name
        }
    }
    
    public var projects:[ShowProject]!
    {
        didSet
        {
            guard let pages = self.pages else
            {
                return
            }
            for page in pages
            {
                page.allProjects = self.projects
            }
            //程序约束
            if let projects = self.projects
            {
                if projects.count > 0
                {
                    self.selectedProject = projects[0]
                }
                
            }
        }
    }
    
    public let screenWidth: CGFloat = UIScreen.main.bounds.width
    public static let topImageHeight: CGFloat = {
        let screenH = UIScreen.main.bounds.height
        var size: CGFloat = 0
        if screenH >= 568.0 && screenH < 667.0 {
            size = 110
        } else if screenH >= 667.0 && screenH < 736.0 {
            size = 115
        } else if screenH >= 736.0 {
            size = 120
        }
        return size
    }()
    
    public static let titleViewHeight: CGFloat = {
        let screenH = UIScreen.main.bounds.height
        var size: CGFloat = 0
        if screenH >= 568.0 && screenH < 667.0 {
            size = 37
        } else if screenH >= 667.0 && screenH < 736.0 {
            size = 38
        } else if screenH >= 736.0 {
            size = 40
        }
        return size
    }()
    
    public var imageTop: UIImageView!
    public var titleView: UIView!
    public var titleLabel: UILabel!

    public var projectListTreeView: TreeTableView!
    public var projectListPopover: Popover!
    
    public var userInfoView: UserInfoView!
    public var userInfoPopover: Popover!
    
    public var titleName:String!{
        didSet{
            self.titleLabel?.text = titleName
        }
    }
    
    var systemName:String!
    
    
    func initViewPages(type: AccountType){
        switch type {
        case .guest:
            self.titles = titlesGuest
        case .adminitor:
            self.titles = titlesAdmin
        default:
            self.titles = titlesEp
            break
        }
        
        pages = [BasePageViewController]()
        if type == .guest {
            let projectInfoView = ProjectInfoViewController(title:titles[0], container: self)
            pages.append(projectInfoView)
        }else if type == .adminitor {
            let projectInfoView = ProjectInfoViewController(title:titles[0], container: self)
            pages.append(projectInfoView)
        
            let runningStateView = RunningStateViewController(title:titles[1], container: self)
            pages.append(runningStateView)
        
            let runningDataView = RunningDataViewController(title:titles[2], container: self)
            runningDataView.viewType = type
            pages.append(runningDataView)
        
            let projectAddView = ProjectAddViewController(title:titles[3], container: self)
            pages.append(projectAddView)
        
            let projectModifyView = ProjectModifyViewController(title:titles[4], container: self)
            pages.append(projectModifyView)
        
            let deviceModifyView = DeviceModifyViewController(title:titles[5], container: self)
            pages.append(deviceModifyView)
        
            let infoRefindView = InfoRefindViewController(title:titles[6], container: self)
            pages.append(infoRefindView)
            
        }else{
            let projectInfoView = ProjectInfoViewController(title:titles[0], container: self)
            pages.append(projectInfoView)
            
            let runningStateView = RunningStateViewController(title:titles[1], container: self)
            pages.append(runningStateView)
            
            let runningDataView = RunningDataViewController(title:titles[2], container: self)
            runningDataView.viewType = type
            pages.append(runningDataView)
        }
        self.pageIndex = 0
        
        self.systemName = "太阳能污水处理系统"
        self.titleName = "太阳能污水处理系统"
        self.viewPages = pages
        self.yOffset = MainViewController.topImageHeight
        self.view.backgroundColor = UIColor.white
    }
    
    init(options: [UIViewPagerOption], type: AccountType) {
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
    
    ///更新项目列表
    func refreshProjectTreeView() {
        self.projectListTreeView.mNodes1 = AddressUtils.sunPowerItem.provinceItem
        self.projectListTreeView.mNodes2 = AddressUtils.waterSysItem.provinceItem
        self.projectListTreeView.mNodes3 = AddressUtils.smartSysItem.provinceItem
        self.projectListTreeView.reloadData()
    }
    
    func popoverWillShow(){
        self.refreshProjectTreeView()
    }
    
    func initPopover(){
        
        let options: [PopoverOption] = []
        
        projectListPopover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        projectListPopover.arrowSize.height = 0
        projectListPopover.willShowHandler = self.popoverWillShow
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 3 * 2, height: self.view.frame.height * 0.75)
        projectListTreeView = TreeTableView(frame: frame, data1: AddressUtils.sunPowerItem.provinceItem, data2:AddressUtils.waterSysItem.provinceItem, data3: AddressUtils.smartSysItem.provinceItem)
        projectListTreeView.treeTableDelegate = self
        
        userInfoPopover = Popover(options: [], showHandler: nil, dismissHandler: nil)
        userInfoPopover.arrowSize.height = 0
        let frame2 = CGRect(x: 0, y: 0, width: self.view.bounds.width / 3 * 2, height: self.view.frame.height * 0.75)
        userInfoView = UserInfoView(frame: frame2)
        userInfoView.delegate = self
        
    }
    
    func addHeadView(){
        self.imageTop = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: MainViewController.topImageHeight))
        self.imageTop.image = UIImage(named: "top")
        self.view.addSubview(imageTop)
        
        self.titleView = UIView(frame: CGRect(x: 0, y: MainViewController.topImageHeight - MainViewController.titleViewHeight, width: screenWidth, height: MainViewController.titleViewHeight))
        
//        let backBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 5, width: 40, height: 30))
//        backBtn.setImage(UIImage(named: "arrow_back2"), for: .normal)
//        backBtn.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
//        self.titleView.addSubview(backBtn)
        
        
        let userBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 5, width: 40, height: 30))
        userBtn.setImage(UIImage(named: "arrow_back2"), for: .normal)
        userBtn.addTarget(self, action: #selector(onUser(_:)), for: .touchUpInside)
        self.titleView.addSubview(userBtn)
        
        
        let menuBtn:UIButton = UIButton(frame: CGRect(x: screenWidth - 40, y: 5, width: 40, height: 30))
        menuBtn.setImage(UIImage(named: "arrow_menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(onMenu(_:)), for: .touchUpInside)
        self.titleView.addSubview(menuBtn)
        
        let titleLabelWidth = screenWidth - 80
        self.titleLabel = UILabel(frame: CGRect(x: 40, y: 0, width: titleLabelWidth, height: MainViewController.titleViewHeight))
        titleLabel.text = titleName
        titleLabel.adjustFontByScreenHeight(isTitle: true)
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.textAlignment = .center
        self.titleView.addSubview(titleLabel)
        
        self.titleView.backgroundColor = ColorUtils.mainThemeColor
        self.view.addSubview(titleView)
    }
    
    @objc public func onUser(_ sender: UIButton) {
        print("MainView onUser调用")
        let startPoint = CGPoint(x: 20, y: 120)
        userInfoPopover.show(userInfoView, point: startPoint)
        delegate?.onUser(sender)
        
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
    
    override func didScrollToPage(index: UInt) {
        if self.viewType == AccountType.adminitor {
            if index > 2 {
                self.titleName = self.titlesAdmin[Int(index)]
            }else{
                self.titleName = self.systemName
            }
        }
        pageIndex = Int(index)
        
        pages[pageIndex].addressNames = self.addressNames
        pages[pageIndex].selectedProject = self.selectedProject
        
        isFirstScroll = false
        
    }
    func TreeTable(_ treeTableView: TreeTableView, section: Int, addressNames: [String], didSelectProject id: Int) {
        projectListPopover.dismiss()
        
        guard let projects = self.projects else {
            return
        }
        
        self.titleName = systemNames[section]
        self.systemName = systemNames[section]
        print(section)
        print(id)
        print(addressNames)
        
        for project in projects {
            if project.id == id {
                self.selectedProject = project
                break
            }
        }
        
        //保存项目id
        let accountDefaults = UserDefaults.standard
        accountDefaults.set(id, forKey: account.account + "_" + Keys.selectedProjectId)
        
        self.doScrollToPage(index: 0)
        self.addressNames = addressNames
        
        pages[pageIndex].addressNames = self.addressNames
        pages[pageIndex].selectedProject = self.selectedProject
//        for page in self.pages {
//            page.addressNames = addressNames
//            page.selectedProject = self.selectedProject
//        }

    }
}

extension MainViewController: UserInfoDelegate {
    func onSignOut(button: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        print("sign out")
        self.userInfoPopover.dismiss()
        onBack(button)
        
    }
}
