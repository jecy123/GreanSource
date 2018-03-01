//
//  ViewPager.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit



class BasePageViewController:UIViewController{
    
    public var selectedProject: ShowProject!
    
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        //self.titleName = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //self.view.backgroundColor = ColorUtils.mainThemeColor
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

