//
//  UserInfoView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/6/26.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

protocol UserInfoDelegate {
    func onSignOut(button: UIButton)
}

class UserInfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: UserInfoDelegate?
    
    var labelAccount: UILabel!
    var labelUserType: UILabel!
    var labelTelephone: UILabel!
    var labelUserName: UILabel!
    var btnSignOut: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var itemH: CGFloat = 30
        let bottomLineH: CGFloat = 1
        let padding: CGFloat = bottomLineH * 3
        var startY: CGFloat = 0
        var ofsize = 14
        var bigsize = 16
        
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667.0 {
            itemH = 20
            ofsize = 12
            bigsize = 14
        } else if screenH >= 667.0 && screenH < 736.0 {
            itemH = 25
            ofsize = 14
            bigsize = 16
        } else if screenH >= 736.0 {
            itemH = 30
            ofsize = 16
            bigsize = 18
        }
 
        labelAccount = UILabel(frame: CGRect(x: 0, y: startY, width: frame.width, height: itemH))
        labelAccount.text = "账户信息"
        labelAccount.backgroundColor = ColorUtils.mainViewBackgroudColor
        labelAccount.font = UIFont.systemFont(ofSize: CGFloat(bigsize))
        
        startY += itemH + padding
        labelUserType = UILabel(frame: CGRect(x: 20, y: startY, width: frame.width, height: itemH))
        labelUserType.text = "用户类型："
        labelUserType.font = UIFont.systemFont(ofSize: CGFloat(ofsize))
        
        startY += itemH + bottomLineH
        let bottonLine1 = UIView(frame: CGRect(x: 0, y: startY, width: frame.width, height: bottomLineH))
        bottonLine1.layer.backgroundColor = ColorUtils.mainViewBackgroudColor.cgColor
        self.addSubview(bottonLine1)
        
        startY += bottomLineH * 2
        labelTelephone = UILabel(frame: CGRect(x: 20, y: startY, width: frame.width, height: itemH))
        labelTelephone.text = "手机号："
        labelTelephone.font = UIFont.systemFont(ofSize: CGFloat(ofsize))
        
        startY += itemH + bottomLineH
        let bottonLine2 = UIView(frame: CGRect(x: 0, y: startY, width: frame.width, height: bottomLineH))
        bottonLine2.layer.backgroundColor = ColorUtils.mainViewBackgroudColor.cgColor
        self.addSubview(bottonLine2)
        
        startY += bottomLineH * 2
        labelUserName = UILabel(frame: CGRect(x: 20, y: startY, width: frame.width, height: itemH))
        labelUserName.text = "姓名："
        labelUserName.font = UIFont.systemFont(ofSize: CGFloat(ofsize))
        
        startY += itemH + padding
        btnSignOut = UIButton(frame: CGRect(x: 0, y: startY, width: frame.width, height: itemH))
        btnSignOut.setTitle("退出登录", for: .normal)
        btnSignOut.layer.backgroundColor = ColorUtils.mainViewBackgroudColor.cgColor
        btnSignOut.setTitleColor(UIColor.black, for: .normal)
        btnSignOut.contentHorizontalAlignment = .left
        btnSignOut.setImage(UIImage(named: "arrow_sign_out"), for: .normal)
        btnSignOut.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        btnSignOut.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0)
        btnSignOut.imageView?.contentMode = .scaleAspectFit
        btnSignOut.addTarget(self, action: #selector(onSignOut(_:)), for: .touchUpInside)
        btnSignOut.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(bigsize))
        
        self.addSubview(labelAccount)
        self.addSubview(labelUserType)
        self.addSubview(labelTelephone)
        self.addSubview(labelUserName)
        self.addSubview(btnSignOut)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSignOut(_ sender: UIButton){
        self.delegate?.onSignOut(button: sender)
    }

}
