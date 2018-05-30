//
//  AuditingFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/29.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class AuditingFragment: UIView {
    
    let nodeCellId = "AuditingCell"
    
    var mAccounts: [ShowAccount]!{
        didSet{
            guard let userList = self.userListTableView else { return }
            userList.reloadData()
        }
    }
    
    var userListTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tableFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        userListTableView = UITableView(frame: tableFrame)
        userListTableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuditingFragment: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let accounts = self.mAccounts {
            return accounts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "AuditingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.nodeCellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: nodeCellId) as! AuditingCell
        
        let account = mAccounts[indexPath.row]
        if let name = account.name {
            cell.userName.text = name
        }
        if let phone = account.phone {
            cell.telPhone.text = phone
        }
        if let email = account.email {
            cell.email.text = email
        }
        if let type = account.type {
            if let userType:AccountType = AccountType(rawValue: type){
                switch userType {
                case .adminitor:
                    cell.userType.text = "管理员"
                case .EP:
                    cell.userType.text = "环保人员"
                case .mantainer:
                    cell.userType.text = "运维人员"
                }
            }
        }
        
        if let _ = account.locations {
            
        }
        if let time = account.createTime{
            cell.applyTime.text = time
        }
        
        cell.auditAcceptSwitch.setOn(false, animated: false)
        
        cell.auditRejectSwitch.setOn(false, animated: false)
        
        return cell
        
    }
    
}


