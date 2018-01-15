//
//  UseRetrieveViewController.swift
//  GreanSourceManeger
//
//  Created by 星空 on 2018/1/15.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class UseRetrieveViewController: UserBaseController {
    
    let tabelItemNames:[String] = ["用户姓名","用户类型","项目区域","输入原号码","输入新号码","验证码"]
    
    func initViews(){
        self.titleString = "用户找回"
        self.itemPadding = 20
        self.itemSize = CGFloat(tabelItemNames.count)
        
        let startX: CGFloat = self.itemStartX
        var startY: CGFloat = self.itemStartY
        
        var items:[TableItem] = [TableItem]()
        
        var rect:CGRect
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[0], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        
        items.append(TableItem(name: tabelItemNames[1], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        
        items.append(TableItem(name: tabelItemNames[2], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        
        items.append(TableItem(name: tabelItemNames[3], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        
        items.append(TableItem(name: tabelItemNames[4], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        
        items.append(TableItem(name: tabelItemNames[5], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        self.tabelItems = items
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

        // Do any additional setup after loading the view.
    }
    
    override func onConfirmButtonTapped(_ sender: Any) {
        
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
