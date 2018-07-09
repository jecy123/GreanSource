//
//  ViewPager.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class BasePageViewController: UIViewController{
    
    ///主容器视图类
    public weak var viewContainer: ISViewPagerContainer!
    
    var topViewHeight: CGFloat = 120
    var bottomViewHeight: CGFloat = 50
    
    var itemLeftPadding: CGFloat = 20
    var itemTopPadding:CGFloat = 20
    
    var itemBgTitleHeight: CGFloat {
        let screenH = UIScreen.main.bounds.height
        var size: CGFloat = 0
        if screenH >= 568.0 && screenH < 667.0 {
            size = 30
        } else if screenH >= 667.0 && screenH < 736.0 {
            size = 35
        } else if screenH >= 736.0 {
            size = 40
        }
        return size
    }
    
    var itemBgHeight: CGFloat {
        return self.view.frame.height - itemTopPadding - itemTopPadding
    }
    
    var itemBgWidth: CGFloat {
        return self.view.frame.width - itemLeftPadding - itemLeftPadding
    }
    
    var itemBgView: UIView!
    var mainTitleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    //设备列表
    var devicesTableView: DevicesTableView!
    
    var viewType: AccountType!
    
    var tableItemTag: Int  = 0
    
    
    public var infomationView: InfoView!
    
    //所有的项目
    public var allProjects: [ShowProject]!
    
    //选中的项目
    public var selectedProject: ShowProject!{
        didSet{
            guard let selectedProject = self.selectedProject
                //, let addressNames = self.addressNames
                else {
                return
            }
            
            let resAddress = AddressUtils.queryAddressNames(by: selectedProject.locationId)
            selectedProject.locationName = resAddress.province + resAddress.city + resAddress.area
            self.addressNames = []
            self.addressNames.append(selectedProject.projectName)
            self.addressNames.append(resAddress.area)
            self.addressNames.append(resAddress.city)
            self.addressNames.append(resAddress.province)
            //selectedProject.locationName = "" + addressNames[3] + addressNames[2] +  addressNames[1]
            print(self.selectedProject.projectName)
            self.refreshProject()
            
        }
    }
    
    public var addressNames: [String]!{
        didSet{
            guard let addressNames = self.addressNames else {
                return
            }
            guard  addressNames.count == 4 else {
                //ToastHelper.showGlobalToast(message: "数据返回出错！")
                return
            }
            self.mainTitleName = addressNames[3] + "-" + addressNames[2] + "-" + addressNames[1] + "-" + addressNames[0]
            
        }
    }
    
    public var mainTitleName: String!{
        didSet{
            
            mainTitleLabel?.text = mainTitleName
        }
    }
    public var subTitleName: String!{
        didSet{
            subTitleLabel?.text = subTitleName
        }
    }
    
    //保存列表项
    public var tableItemViews: [TableItemView] = []
    //保存下拉列表
    public var dropBoxViews: [DropBoxView] = []
    //保存选择按钮
    public var selectedButtons: [UIButton] = []
    public var selectedButtonIndex: Int = 0{
        didSet{
            guard selectedButtonIndex >= 0 && selectedButtonIndex <= selectedButtons.count - 1 else {
                return
            }
            for i in 0...self.selectedButtons.count - 1{
                if i == selectedButtonIndex {
                    self.selectedButtons[i].layer.backgroundColor = ColorUtils.selectedBtnColor.cgColor
                }else {
                    self.selectedButtons[i].layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
                }
            }
        }
    }
    
    init(title: String, container: ISViewPagerContainer? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.subTitleName = title
        self.viewContainer = container
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initItemBgView()
        
        print("frame = \(self.view.frame)")
        print("bounds = \(self.view.bounds)")
        self.view.backgroundColor = ColorUtils.mainViewBackgroudColor
        
    }
    
    func addInfoView(infoViewFrame: CGRect, titleRatio: CGFloat, titles: [String], contents: [String]){
        infomationView = InfoView(frame: infoViewFrame, titleRatio: titleRatio, titles: titles, contents: contents)
        self.itemBgView.addSubview(infomationView)
    }
    
    func addStatusInfoView(infoViewFrame: CGRect, titleRatio: CGFloat, titles: [String], contents: [String]){
        infomationView = InfoView(frame: infoViewFrame, titleRatio: titleRatio, titles: titles, contents: contents,status:false)
        self.itemBgView.addSubview(infomationView)
      //  let tableItem = TableItem(name: titles[0], type: .typenull, frame: infoViewFrame, ratio: titleRatio,withBottomLine: false)
       // let tableItemView = TableItemView(parentVC: self, item: tableItem)
       // tableItemView.delegate = delegate
        
     //   tableItemView.tag = self.tableItemTag
     //   self.tableItemTag += 1
     //   self.itemBgView.addSubview(tableItemView)
      //  self.tableItemViews.append(tableItemView)
        
        
        
    }
    
    func addTableItemView(tableFrame: CGRect, titleRatio: CGFloat, title: String, type: TableItemType, withBottomLine: Bool, delegate: TableItemViewDelegate? = nil){
        let tableItem = TableItem(name: title, type: type, frame: tableFrame, ratio: titleRatio,withBottomLine: withBottomLine)
        let tableItemView = TableItemView(parentVC: self, item: tableItem)
        tableItemView.delegate = delegate
        
        tableItemView.tag = self.tableItemTag
        self.tableItemTag += 1
        
        self.itemBgView.addSubview(tableItemView)
        self.tableItemViews.append(tableItemView)
    }
    
    func addDeviceListView(deviceListFrame: CGRect, devices: [ShowDevice]){
        self.devicesTableView = DevicesTableView(frame: deviceListFrame, devices: devices)
        self.itemBgView.addSubview(self.devicesTableView)
    }
    
    func removeTableItemView(at tag: Int){
        guard tag >= 0 && tag < self.tableItemTag else {
            return
        }
        var tableItem: TableItemView? = nil
        var i = 0
        for item in self.tableItemViews {
            if item.tag == tag {
                tableItem = item
                break
            }
            i += 1
        }
        
        if tableItem != nil {
            let h = tableItem?.frame.height
            tableItem?.frame.size.height = 0
            tableItem?.isHidden = true
            
            for index in (i+1)..<self.tableItemViews.count {
                self.tableItemViews[index].frame.origin.y -= h!
            }
            self.tableItemViews.remove(at: i)
        }
        
    }
    
    func addTitleView()
    {
        let height: CGFloat = itemBgTitleHeight
        
        let mainTitleFrame: CGRect = CGRect(x: 0, y: 0, width: self.itemBgView.frame.width, height: height)
        let subTitleFrame: CGRect = CGRect(x: 0, y: height, width: self.itemBgView.frame.width, height: height)
        
        mainTitleLabel = UILabel(frame: mainTitleFrame)
        subTitleLabel = UILabel(frame: subTitleFrame)
        
        mainTitleLabel.backgroundColor = ColorUtils.mainThemeColor
        mainTitleLabel.textColor = UIColor.white
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.text = self.mainTitleName
        mainTitleLabel.adjustFontByScreenHeight()
        mainTitleLabel.adjustsFontSizeToFitWidth = true
        
        subTitleLabel.backgroundColor = ColorUtils.itemTitleViewBgColor
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = self.subTitleName
        subTitleLabel.adjustFontByScreenHeight()
        
        self.itemBgView.addSubview(mainTitleLabel)
        self.itemBgView.addSubview(subTitleLabel)
    }
    
    func addButton(buttonframe:CGRect,title: String? , target: Any?, action: Selector, for event: UIControlEvents){
        let button = UIButton(frame: buttonframe)
        button.setTitle(title, for: .normal)
        //button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: buttonframe.height / 2)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        button.addTarget(target, action: action, for: event)
        self.itemBgView.addSubview(button)
    }
    
    public func addDropBox(dropBoxFrame: CGRect, names: [String], dropBoxOffset: CGPoint, dropBoxDidSelected: @escaping (Int) -> Void){
        
        let dropBox = DropBoxView(title: "请选择", items: names, frame: dropBoxFrame, offset: dropBoxOffset)
        dropBox.isHightWhenShowList = true
        dropBox.didSelectBoxItemHandler = dropBoxDidSelected
        self.itemBgView.addSubview(dropBox)
        self.dropBoxViews.append(dropBox)
    }
    
    func addSelectedButtons(buttonTitles: [String], buttonWidth:CGFloat, buttonHeight: CGFloat){
        let count: CGFloat = CGFloat(buttonTitles.count)
        let bottomPadding: CGFloat = 10
        var width: CGFloat = 0
        var padding: CGFloat = 0
        if buttonWidth * count >= itemBgView.frame.width{
            padding = 4
            width = itemBgView.frame.width / count - padding
        }else{
            padding = itemBgView.frame.width / count - buttonWidth
            width = buttonWidth
        }
        
        var x = padding / 2
        let y = self.itemBgView.frame.height - bottomPadding - buttonHeight
        var index = 0
        for title in buttonTitles {
            let frame = CGRect(x: x, y: y, width: width, height: buttonHeight)
            let button = UIButton(frame: frame)
            
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: buttonHeight/2)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.cornerRadius = 4
            button.tag = index
            button.addTarget(self, action: #selector(onSelectedButtonClicked(_:)), for: .touchUpInside)
            
            x += (padding + width)
            index += 1
            
            self.selectedButtons.append(button)
            self.itemBgView.addSubview(button)
        }
        self.selectedButtonIndex = 0
        
    }
    
    func addInfoTitleLabel(frame: CGRect, title: String) -> UILabel{
        let label = UILabel(frame: frame)
        label.text = title
        self.itemBgView.addSubview(label)
        return label
    }
    
    func addInfoContentImage(frame: CGRect, image: UIImage) -> UIImageView{
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        self.itemBgView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    @objc func onSelectedButtonClicked(_ sender: UIButton){
        self.selectedButtonIndex = sender.tag
        
    }
    
    
    func generateDeviceInfo(index: Int) -> String{
        return ""
    }

    public func initItemBgView(){
        itemBgView = UIView()
        self.view.addSubview(itemBgView)
        itemBgView.layer.borderWidth = 1
        itemBgView.layer.borderColor = ColorUtils.itemTitleViewBgColor.cgColor
        itemBgView.backgroundColor = UIColor.white
    }
    
    public func layoutUI(){
        let itemBgFrame = CGRect(x: itemLeftPadding, y: itemTopPadding, width: itemBgWidth, height: itemBgHeight)
        self.itemBgView.frame = itemBgFrame
    }
    
    ///从服务器更新项目
    public func doRefreshProjectListFromNet() {
        let project = ShowProject()
        project.capability = 0
        project.emissionStandards = 0
        project.msg = "success"
        project.retCode = 0
        project.type = 0
        project.state = 0
        
        let page = ShowPage<ShowProject>(c: project)
        let jsonData = page.toJSON()
        ClientRequest.getProjectList(json: jsonData) { (resProjects) in
            if let projects = resProjects{
                AddressUtils.getItems(projects: projects)
                //print("projects = \(resAccount.projects)")
                let mainView = self.viewContainer as! MainViewController
                mainView.projects = projects
            }else{
                print("失败！")
                ToastHelper.showGlobalToast(message: "数据获取失败，登录失败！")
            }
        }
    }
    
    //子类继承
    public func refreshProject(){
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("size = \(size)")
    }
    
    override func viewDidLayoutSubviews() {
        print(self.view.frame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.view.frame)
        layoutUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UILabel {
    func adjustFontByScreenHeight(isTitle: Bool = false) {
        var fontSize: CGFloat {
            let screenH = UIScreen.main.bounds.height
            var size: CGFloat = 0
            if screenH >= 568.0 && screenH < 667.0 {
                if isTitle {
                    size = 15
                } else {
                    size = 12
                }
            } else if screenH >= 667.0 && screenH < 736.0 {
                if isTitle {
                    size = 18
                } else {
                    size = 15
                }
            } else if screenH >= 736.0 {
                if isTitle {
                    size = 20
                } else {
                    size = 17
                }
            }
            return size
        }
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}

extension UITextField {
    func adjustFontByScreenHeight() {
        var fontSize: CGFloat {
            let screenH = UIScreen.main.bounds.height
            var size: CGFloat = 0
            if screenH >= 568.0 && screenH < 667.0 {
                size = 12
            } else if screenH >= 667.0 && screenH < 736.0 {
                size = 15
            } else if screenH >= 736.0 {
                size = 17
            }
            return size
        }
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}

