//
//  ViewPager.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

protocol BaseTitleItemDelegate {
    func onBack(_ sender: BasePageViewController)
    func onMenu(_ sender: BasePageViewController)
}

class BasePageViewController:UIViewController{
    
    var delegate:BaseTitleItemDelegate?
    public var titleName:String!{
        didSet{
            self.titleLabel?.text = titleName
        }
    }
    
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.titleName = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public let screenWidth: CGFloat = UIScreen.main.bounds.width
    public let topImageHeight: CGFloat = 120
    public let titleViewHeight: CGFloat = 40
    
    
    public var imageTop:UIImageView!
    public var titleView:UIView!
    public var titleLabel:UILabel!
    
    func addHeadView(){
        self.imageTop = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: topImageHeight))
        self.imageTop.image = UIImage(named: "top")
        self.view.addSubview(imageTop)
        
        self.titleView = UIView(frame: CGRect(x: 0, y: topImageHeight - titleViewHeight, width: screenWidth, height: titleViewHeight))
        let backBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 5, width: 40, height: 30))
        backBtn.setImage(UIImage(named: "arrow_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        self.titleView.addSubview(backBtn)
        
        
        let menuBtn:UIButton = UIButton(frame: CGRect(x: screenWidth - 40, y: 5, width: 40, height: 30))
        menuBtn.setImage(UIImage(named: "arrow_menu"), for: .normal)
        backBtn.addTarget(self, action: #selector(onMenu(_:)), for: .touchUpInside)
        self.titleView.addSubview(menuBtn)
        
        let titleLabelWidth = screenWidth - 80
        self.titleLabel = UILabel(frame: CGRect(x: 40, y: 0, width: titleLabelWidth, height: titleViewHeight))
        titleLabel.text = titleName
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.textAlignment = .center
        self.titleView.addSubview(titleLabel)
        
        self.titleView.backgroundColor = ColorUtils.mainThemeColor
        self.view.addSubview(titleView)
    }
    
    @objc public func onBack(_ sender: UIButton){
        print("父类onBack调用")
        delegate?.onBack(self)
    }
    
    @objc public func onMenu(_ sender: UIButton){
        print("父类onMenu调用")
        delegate?.onMenu(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeadView()
        
        //let label = UILabel.init(frame: CGRect(x: self.view.frame.width/2-50, y: self.view.frame.height/2-100, width: 100, height: 50))
        //label.text = title
        //label.textAlignment = NSTextAlignment.center
        //self.view.addSubview(label)
    }
}

