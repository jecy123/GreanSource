//
//  AuditingFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/29.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol AuditingFragmentDelegate {
    @objc optional func doAcceptAudit(cell id: Int)
    @objc optional func doRejectAudit(cell id: Int)
}

class AuditingFragment: UIView {
    
    var delegate: AuditingFragmentDelegate?
    
    let nodeCellId = "AuditingCell"
    
    var mAccounts: [ShowAccount]!{
        didSet{
            guard let userList = self.userListTableView else {
                showTableOrNot(isShow: false)
                return
            }
            if let accounts = mAccounts {
                userList.reloadData()
                if accounts.count > 0 {
                    showTableOrNot(isShow: true)
                } else {
                    showTableOrNot(isShow: false)
                }
            }
        }
        
    }
    
    var userListTableView: UITableView!
    var emptyTipView: UILabel!
    
    
    func addTableView() {
        let tableFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        userListTableView = UITableView(frame: tableFrame)
        self.addSubview(userListTableView)
        
        userListTableView.tableFooterView = UIView(frame: CGRect.zero)
        userListTableView.rowHeight = 230
        userListTableView.dataSource = self
    }
    
    func showTableOrNot(isShow: Bool) {
        if isShow {
            self.emptyTipView.isHidden = true
            self.userListTableView.isHidden = false
        }else {
            self.emptyTipView.isHidden = false
            self.userListTableView.isHidden = true
        }
    }
    
    func addEmptyTipView(){
        let tipViewH: CGFloat = 40
        let tipViewW: CGFloat = 120
        let tipViewX: CGFloat = (self.frame.width - tipViewW) / 2
        let tipViewY: CGFloat = (self.frame.height - tipViewH) / 2
        
        let tipViewFrame = CGRect(x: tipViewX, y: tipViewY, width: tipViewW, height: tipViewH)
        emptyTipView = UILabel(frame: tipViewFrame)
        emptyTipView.text = "没有需要审核"
        self.addSubview(emptyTipView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTableView()
        addEmptyTipView()
        showTableOrNot(isShow: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuditingFragment: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
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
        cell.delegate = self
        
        cell.cellIdNo = indexPath.row
        
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
        
        if let locationIds = account.locationIds{
            let res = AddressUtils.queryAddressNames(by: locationIds)
            let locationName = res.province + res.city + res.area
            cell.projectAddress.text = locationName
        }
        if let time = account.createTime{
            cell.applyTime.text = time
        }
        
        cell.auditAcceptSwitch.setOn(false, animated: false)
        
        cell.auditRejectSwitch.setOn(false, animated: false)
        
        return cell
        
    }
    
}

extension AuditingFragment: AuditingCellDelegate {
    func doAuditingAccept(cellId: Int) {
        delegate?.doAcceptAudit?(cell: cellId)
    }
    
    func doAuditingReject(cellId: Int) {
        delegate?.doRejectAudit?(cell: cellId)
    }
}


