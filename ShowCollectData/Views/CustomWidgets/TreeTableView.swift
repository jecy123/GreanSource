//
//  TreeTableView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/27.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol TreeTableDelegate {
    @objc optional func TreeTable(_ treeTableView: TreeTableView, section: Int, addressNames: [String], didSelectProject id: Int)
}


class TreeTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var mNodes1: [BaseItem]!
    var mNodes2: [BaseItem]!
    
    var treeTableDelegate: TreeTableDelegate?
    
    let NodeCellId = "nodeCell"
    //选项展开的图标
    let image_ex = "tree_ex.png"
    //选项未展开的图标
    let image_ec = "tree_ec.png"
    
    init(frame: CGRect, data1: [BaseItem], data2: [BaseItem]) {
        super.init(frame: frame, style: .plain)
        self.mNodes1 = data1
        self.mNodes2 = data2
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mNodes1.count
        }else if section == 1{
            return mNodes2.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 通过nib自定义tableviewcell
        let nib = UINib(nibName: "TreeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NodeCellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NodeCellId) as! TreeTableViewCell
        
        
        var node: BaseItem!
        
        if indexPath.section == 0 {
            node = mNodes1[indexPath.row]
        }else{
            node = mNodes2[indexPath.row]
        }
        
        //cell缩进
        cell.background.bounds.origin.x = -20.0 * CGFloat(node.level)
        
        //代码修改nodeIMG---UIImageView的显示模式.
        if !node.isLeaf {
            cell.nodeImage.contentMode = UIViewContentMode.center
            if node.isExpand {
                cell.nodeImage.image = UIImage(named: image_ex)
            }
            else{
                cell.nodeImage.image = UIImage(named: image_ec)
            }
        } else {
            cell.nodeImage.image = nil
        }
        
        cell.nodeName.text = node.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = systemNames[section]
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedNode: BaseItem!
        switch indexPath.section {
        case 0:
            selectedNode = mNodes1[indexPath.row]
        default:
            selectedNode = mNodes2[indexPath.row]
            
        }
        
        //let startPosition = indexPath.row + 1
        //var endPosition = startPosition
        
        if selectedNode.isLeaf {
            
            //var parentNode = selectedNode
            
            let names:[String] = AddressUtils.queryLocationNames(itemNode: selectedNode)
            
//            while parentNode != nil{
//                names.append(parentNode!.name)
//                parentNode = parentNode!.parent
//            }
            guard names.count == 4 else{
                print("地址数据获取失败")
                return
            }
            //叶子节点被选中
            self.treeTableDelegate?.TreeTable!(self, section: indexPath.section, addressNames: names, didSelectProject: Int(selectedNode.id)!)
            return
        }else{
            if selectedNode.isExpand{
                //endPosition += AddressUtils.getAnimateSubCnt(selectedNode)
                selectedNode.setExpand(false)
                
            }else{
                selectedNode.setExpand(true)
                //endPosition += AddressUtils.getAnimateSubCnt(selectedNode)
            }
        }
        switch indexPath.section {
        case 0:
            mNodes1 = AddressUtils.getVisibleItems(section: indexPath.section)
        case 1:
            mNodes2 = AddressUtils.getVisibleItems(section: indexPath.section)
        default:
            break
        }
        self.reloadData()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
