//
//  UserBaseController.swift
//  GreanSourceManeger
//
//  Created by 星空 on 2018/1/13.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class UserBaseController: UIViewController {

    public var tabelItemViews:[TableItemView]!
    public var tabelItems:[TableItem]!{
        didSet{
            addItemViews()
        }
    }
    
    public var imageTop:UIImageView!
    public var pageTitle:UILabel!
    public var back:UIButton!
    public var confirm:UIButton!
    
    public let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    public let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    public var contentHeight: CGFloat
    {
        return self.screenHeight - self.topImageHeight
    }
    public var topImageHeight: CGFloat = 120
    public var titleMarginTop:CGFloat = 10
    public var titleWidth: CGFloat = 150
    public var titleHeight: CGFloat = 40
    
    public var buttonWidth: CGFloat = 100
    public var buttonHeight: CGFloat{
        var h = screenHeight / 16
        if h > 40 {
            h = 40
        }
        return h
    }
    public var buttonPadding: CGFloat = 30
    public var buttonMarginTop: CGFloat = 20
    
    public var leftMargin: CGFloat = 30
    public var rightMargin: CGFloat = 30
    
    public var itemStartX: CGFloat!{
        return leftMargin
    }
    public var itemStartY: CGFloat!
    
    public var itemSize:CGFloat!{
        didSet{
            itemTotalHeight = itemSize * itemHeight + (itemSize - 1) * itemPadding
        }
    }
    public var itemHeight: CGFloat{
        var h = screenHeight / 22
        if h > 30 {
            h = 30
        }
        print("h = \(h)")
        return h
    }
    public var itemPadding:CGFloat = 10
    
    public var itemWidth:CGFloat{
        return screenWidth - leftMargin - rightMargin
        
    }
    
    public var itemTotalHeight:CGFloat!{
        didSet{
            itemMarginTop = (contentHeight - titleMarginTop - titleHeight - buttonMarginTop - buttonHeight - itemTotalHeight) / 2
        }
    }
    public var itemMarginTop:CGFloat!{
        didSet{
            itemStartY = topImageHeight + titleMarginTop + titleHeight + itemMarginTop
            addBottomView()
        }
    }
    
    public var titleString:String!{
        didSet{
            addTitleView(pageTitleString: titleString)
        }
    }
    
    public func addTitleView(pageTitleString: String){
        
        let ox:CGFloat = (screenWidth - titleWidth) / 2
        let oy:CGFloat = topImageHeight + titleMarginTop
        
        print("itemMarginTop = \(itemMarginTop)")
        print("itemTotalHeight = \(itemTotalHeight)")
        print("screenWidth = \(screenWidth)")
        print("screenHeight = \(screenHeight)")
        print("contentHeight = \(contentHeight)")
        
        pageTitle = UILabel(frame: CGRect(x: ox, y: oy, width: titleWidth, height: buttonHeight))
        pageTitle.text = pageTitleString
        pageTitle.font = UIFont(name: "Times New Roman", size: buttonHeight * 0.57)
        pageTitle.textAlignment = .center
        pageTitle.textColor = ColorUtils.mainThemeColor
      
        self.view.addSubview(pageTitle)
    }
    
    public func addItemViews()
    {
        for item in tabelItems {
            addTabelItem(item: item)
        }
    }
    
    public func addBottomView()
    {
        var buttonX: CGFloat = (screenWidth - buttonWidth - buttonWidth - buttonPadding) / 2
        let buttonY: CGFloat = screenHeight - itemMarginTop - buttonHeight
        
        confirm = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
        confirm.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        confirm.setTitleColor(UIColor.white, for: .normal)
        confirm.setTitleColor(UIColor.brown, for: .highlighted)
        confirm.setTitle("提交审核", for: .normal)
        self.view.addSubview(confirm)
        confirm.addTarget(self, action: #selector(onConfirmButtonTapped(_:)), for: .touchDragInside)
        
        buttonX += buttonWidth + buttonPadding
        back = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
        back.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        back.setTitleColor(UIColor.white, for: .normal)
        back.setTitleColor(UIColor.brown, for: .highlighted)
        back.setTitle("返回登录", for: .normal)
        self.view.addSubview(back)
        back.addTarget(self, action: #selector(onBackButtonTapped(_:)), for: .touchUpInside)
    }
    
    func addTopImage(){
        let topImageFrame: CGRect = CGRect(x: 0, y: 0, width: screenWidth, height: topImageHeight)
        imageTop = UIImageView(frame: topImageFrame)
        imageTop.image = UIImage(named: "top")
        self.view.addSubview(imageTop)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTopImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc public func onBackButtonTapped(_ sender: Any){
        goBack()
    }
    
    @objc public func onConfirmButtonTapped(_ sender: Any){
        
    }
    
    func goBack()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setTitle(titleString:String?)
    {
        self.pageTitle.text = titleString
    }
    
    func addTabelItem(item: TableItem)
    {
        let itemView = TableItemView(item: item)
        self.view.addSubview(itemView)
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
