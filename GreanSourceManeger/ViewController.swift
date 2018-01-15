//
//  ViewController.swift
//  GreanSourceManeger
//
//  Created by 星空 on 2018/1/10.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnLogin:UIButton!
    @IBOutlet var btnRegister:UIButton!
    @IBOutlet var btnRefind:UIButton!
    @IBOutlet var btnRememberPass:UIButton!
    @IBOutlet var btnAutoLogin:UIButton!
    
    //var color:UIColor!
    
    func initViews() {
        //btnLogin.layer.borderWidth = 1
        btnLogin.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor //  UIColor.green.cgColor
        btnLogin.layer.cornerRadius = 5
        
        //btnLogin.layer.masksToBounds = true
        
        btnLogin.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        btnRegister.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        btnRefind.setTitleColor(ColorUtils.mainThemeColor, for: .normal)
        btnRegister.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        btnRefind.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
        
    }
    
    @objc func onClick(_ sender : UIButton) {
        if sender == btnLogin {
            self.performSegue(withIdentifier: "toMain", sender: self)
        }else if sender == btnRegister
        {
            self.performSegue(withIdentifier: "toRegister", sender: self)
        }else if sender == btnRefind{
            self.performSegue(withIdentifier: "toRefind", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

