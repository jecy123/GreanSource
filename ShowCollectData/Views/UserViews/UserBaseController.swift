//
//  UserBaseController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/13.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class UserBaseController: UIViewController {

    public var tableItemViews:[TableItemView] = []
    public var tableItems:[TableItem]!{
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
        var h = screenHeight / 22 - 2
        if h > 30 {
            h = 30
        }
     //   print("h = \(h)")
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
    
    
    public var identiCodeConfirm:UIButton!
    public var userTypeDropBox:DropBoxView!
    
    public var showVCode: ShowVCode!
    
    var timer: DispatchSourceTimer!
    var tickCnt: Int = 120
    var repeateCnts: Int!
    
    func startTimer(repeateCnts: Int){
        self.repeateCnts = repeateCnts
        self.tickCnt = repeateCnts
        self.identiCodeConfirm.isEnabled = false
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler(handler: {
            self.onTickDown()
        })
        timer.resume()
    }
    
    @objc func onTickDown(){
        DispatchQueue.main.async {
            self.identiCodeConfirm.setTitle(String(self.tickCnt)+"秒后重试", for: .disabled)
        }
        
        self.tickCnt -= 1
        if tickCnt == 0 {
            tickCnt = repeateCnts
            DispatchQueue.main.async {
                self.identiCodeConfirm.isEnabled = true
                self.identiCodeConfirm.setTitle("获取验证码", for: .normal)
            }
            timer.cancel()
        }
    }
    
    func getVCode(phoneNumber:String, type: ShowVCodeType){
        ClientRequest.getVertifyCode(phoneNumber: phoneNumber, type: type){
            resVCode in
            if let resVCode = resVCode{
                //登陆失败的返回码是1
                if resVCode.retCode == 1{
                    
                    let error:String = resVCode.msg
                    let errorMsg:String = "获取验证码失败：" + error
                    print(errorMsg)
                    ToastHelper.showGlobalToast(message: errorMsg)
                    //self.view.tgc_makeToast(message: errorMsg)
                    return
                }
                print("获取验证码成功")
                self.showVCode = resVCode
                ToastHelper.showGlobalToast(message: "获取验证码成功")
               /* if let code = resVCode.vcode{
                    ToastHelper.showGlobalToast(message: "获取验证码成功，验证码是" + code)
                }*/
            }else{
                
                print("获取验证码失败！")
                ToastHelper.showGlobalToast(message: "获取验证码失败！")
            }
            
        }
    }
    
    func addDropBox(frame: CGRect, userTypeMenus:[String]){
        //let choice:[String] = ["类型1","类型2"]
        
        userTypeDropBox = DropBoxView(parentVC: self, title: "请选择", items: userTypeMenus, frame: frame)
        userTypeDropBox.isHightWhenShowList = true
        userTypeDropBox.willShowOrHideBoxListHandler = { (isShow) in
            self.onDropBoxWillShowOrHide(isShow: isShow)
        }
        userTypeDropBox.didShowOrHideBoxListHandler = { (isShow) in
            self.onDropBoxDidShowOrHide(isShow: isShow)
        }
        userTypeDropBox.didSelectBoxItemHandler = { (row) in
            self.onDropBoxDidSelect(row: row)
        }
        self.view.addSubview(userTypeDropBox)
    }
    
    public func onDropBoxWillShowOrHide(isShow: Bool){
        if isShow {
            NSLog("will show choices")
        }
        else {
            NSLog("will hide choices")
        }
    }
    
    public func onDropBoxDidShowOrHide(isShow: Bool){
        if isShow {
            NSLog("did show choices")
            
        }else {
            NSLog("did hide choices")
        }
    }
    
    public func onDropBoxDidSelect(row: Int){
        NSLog("selected No.\(row): \(self.userTypeDropBox.currentTitle())")
    }
    
    func addIdentiCodeButton(frame: CGRect){
        identiCodeConfirm = UIButton(frame: frame)
        identiCodeConfirm.titleLabel?.font = UIFont.systemFont(ofSize: itemHeight * 0.57)
        identiCodeConfirm.setTitle("获取验证码", for: .normal)
        identiCodeConfirm.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        identiCodeConfirm.setTitleColor(UIColor.white, for: .highlighted)
        identiCodeConfirm.addTarget(self, action: #selector(onIdentiCodeObtain(_:)), for: .touchUpInside)
        self.view.addSubview(identiCodeConfirm)
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
        for item in tableItems {
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
        confirm.addTarget(self, action: #selector(onConfirmButtonTapped(_:)), for: .touchUpInside)
        
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
        //print("确认")
    }
    @objc public func onIdentiCodeObtain(_ sender: Any){
        print("获取验证码")
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
        let itemView = TableItemView(parentVC: self, item: item)
        self.tableItemViews.append(itemView)
        self.view.addSubview(itemView)
    }
    
    func checkVCode(vcode: String) -> Bool{
        guard let code = self.showVCode else {
            print("未获取验证码！")
            ToastHelper.showGlobalToast(message: "未获取验证码！")
            return false
        }
        guard code.vcode == vcode else {
            print("验证码不一致！")
            ToastHelper.showGlobalToast(message: "验证码不一致！")
            return false
        }
        return true
    }
}
