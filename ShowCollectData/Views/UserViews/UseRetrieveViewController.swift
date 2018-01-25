//
//  UseRetrieveViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/15.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class UseRetrieveViewController: UserBaseController {
    
    let tabelItemNames:[String] = ["用户姓名","用户类型","项目区域","输入原号码","输入新号码","验证码"]
    let userTypes: [String] = ["环保人员", "管理员","维护人员"]
    
    
    func initViews(){
        self.titleString = "用户找回"
        self.itemPadding = 20
        self.itemSize = CGFloat(tabelItemNames.count)
        
        let startX: CGFloat = self.itemStartX
        var startY: CGFloat = self.itemStartY
        
        let identiCodeY:CGFloat = startY + (itemHeight + itemPadding) * 5
        
        var items:[TableItem] = [TableItem]()
        
        var rect:CGRect
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[0], type: .typeText, frame: rect, ratio: 0.4))
        startY += itemHeight + itemPadding
        let dropBoxY = startY
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[1], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[2], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[3], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[4], type: .typeText, frame: rect, ratio: 0.4))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX + 100, y: startY, width: itemWidth - 100, height: itemHeight)
        items.append(TableItem(name: tabelItemNames[5], type: .typeText, frame: rect, ratio: 0.4))
        
        self.tabelItems = items
        
        let dropBoxFrame = CGRect(x: startX + itemWidth * 0.4 + 5, y: dropBoxY, width: itemWidth * 0.6 - 5, height: itemHeight)
        
        addDropBox(frame: dropBoxFrame, userTypeMenus: userTypes)
        
        addIdentiCodeButton(frame: CGRect(x: startX, y: identiCodeY, width: 100, height: itemHeight))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

        // Do any additional setup after loading the view.
    }
    
    override func onConfirmButtonTapped(_ sender: Any) {
        
    }
    
    override func onIdentiCodeObtain(_ sender: Any){
        
        print("获取验证码UUUU")
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
