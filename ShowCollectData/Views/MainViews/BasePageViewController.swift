//
//  ViewPager.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class BasePageViewController: UIViewController{
    
    
    var topViewHeight: CGFloat = 120
    var bottomViewHeight: CGFloat = 50
    
    var itemLeftPadding: CGFloat = 20
    var itemTopPadding:CGFloat = 20
    
    var itemBgHeight: CGFloat {
        return self.view.frame.height - itemTopPadding - itemTopPadding
    }
    
    var itemBgWidth: CGFloat {
        return self.view.frame.width - itemLeftPadding - itemLeftPadding
    }
    
    var itemBgView: UIView!
    var mainTitleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    var viewType: AccountType!
    
    var tableItemTag: Int  = 0
    
    
    public var infomationView: InfoView!
    
    public var allProjects: [ShowProject]!
    
    public var selectedProject: ShowProject!{
        didSet{
            selectedProject.locationName = "" + addressNames[3] + addressNames[2] +  addressNames[1]
            print(self.selectedProject.projectName)
            self.refreshProject()
            
        }
    }
    
    public var addressNames: [String]!{
        didSet{
            guard  addressNames.count == 4 else {
                ToastHelper.showGlobalToast(message: "数据返回出错！")
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
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.subTitleName = title
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
    
    func addTableItemView(tableFrame: CGRect, titleRatio: CGFloat, title: String, type: TableItemType, withBottomLine: Bool, delegate: TableItemViewDelegate? = nil){
        let tableItem = TableItem(name: title, type: type, frame: tableFrame, ratio: titleRatio,withBottomLine: withBottomLine)
        let tableItemView = TableItemView(parentVC: self, item: tableItem)
        tableItemView.delegate = delegate
        
        tableItemView.tag = self.tableItemTag
        self.tableItemTag += 1
        
        self.itemBgView.addSubview(tableItemView)
        self.tableItemViews.append(tableItemView)
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
    
    func addTitleView(titleHeight: CGFloat)
    {
        
        let mainTitleFrame: CGRect = CGRect(x: 0, y: 0, width: self.itemBgView.frame.width, height: titleHeight)
        let subTitleFrame: CGRect = CGRect(x: 0, y: titleHeight, width: self.itemBgView.frame.width, height: titleHeight)
        
        mainTitleLabel = UILabel(frame: mainTitleFrame)
        subTitleLabel = UILabel(frame: subTitleFrame)
        
        mainTitleLabel.backgroundColor = ColorUtils.mainThemeColor
        mainTitleLabel.textColor = UIColor.white
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.text = self.mainTitleName
        mainTitleLabel.adjustsFontSizeToFitWidth = true
        
        subTitleLabel.backgroundColor = ColorUtils.itemTitleViewBgColor
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = self.subTitleName
        
        self.itemBgView.addSubview(mainTitleLabel)
        self.itemBgView.addSubview(subTitleLabel)
    }
    
    func addButton(buttonframe:CGRect,title: String? , target: Any?, action: Selector, for event: UIControlEvents){
        let button = UIButton(frame: buttonframe)
        button.setTitle(title, for: .normal)
        //button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        button.addTarget(target, action: action, for: event)
        self.itemBgView.addSubview(button)
    }
    
    func addDropBox(dropBoxFrame: CGRect, names: [String], dropBoxOffset: CGPoint, dropBoxDidSelected: @escaping (Int) -> Void){
        
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

