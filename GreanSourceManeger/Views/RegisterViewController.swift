//
//  RegisterViewController.swift
//  GreanSourceManeger
//
//  Created by 星空 on 2018/1/11.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class RegisterViewController: UserBaseController {
    
    var menuNames:[String] = ["手机号：","验证码：","账  号：","邮箱地址：","用户姓名：","密  码：","确认密码：","用户类型：","环保局地址："]
    var identiCodeConfirm:UIButton!
    
    func initViews(){
        self.titleString = "用户注册"
        
        self.itemSize = CGFloat(menuNames.count)
        
        let startX: CGFloat = itemStartX
        var startY: CGFloat = itemStartY
        
        let identiCodeY = startY + itemHeight + itemPadding
        
        var items: [TableItem] = [TableItem]()
        
        var rect:CGRect!
        
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[0], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX + 100, y: startY, width: itemWidth - 100, height: itemHeight)
        items.append(TableItem(name: menuNames[1], type: .typeText, frame: rect, ratio: 0.5, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[2], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[3], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[4], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[5], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[6], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[7], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        startY += itemHeight + itemPadding
        rect = CGRect(x: startX, y: startY, width: itemWidth, height: itemHeight)
        items.append(TableItem(name: menuNames[8], type: .typeText, frame: rect, ratio: 0.4, popup: nil))
        
        self.tabelItems = items
        
        
        identiCodeConfirm = UIButton(frame: CGRect(x: startX, y: identiCodeY, width: 100, height: itemHeight))
        identiCodeConfirm.titleLabel?.font = UIFont.systemFont(ofSize: itemHeight * 0.57)
        identiCodeConfirm.setTitle("获取验证码", for: .normal)
        identiCodeConfirm.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        identiCodeConfirm.setTitleColor(UIColor.white, for: .highlighted)
        identiCodeConfirm.addTarget(self, action: #selector(onIdentiCodeObtain(_:)), for: .touchUpInside)
        self.view.addSubview(identiCodeConfirm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onConfirmButtonTapped(_ sender: Any) {
        
    }
    
    @objc func onIdentiCodeObtain(_ sender: Any){
        print("获取验证码")
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
