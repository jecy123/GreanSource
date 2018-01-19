//
//  ViewPager.swift
//  GreanSourceManeger
//
//  Created by 星空 on 2018/1/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class BasePageViewController:UIViewController{
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect(x: self.view.frame.width/2-50, y: self.view.frame.height/2-100, width: 100, height: 50))
        label.text = title
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
    }
}

