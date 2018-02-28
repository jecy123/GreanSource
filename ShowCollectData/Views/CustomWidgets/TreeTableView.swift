//
//  TreeTableView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/2/27.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class TreeTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var mNodes: [BaseItem]!
    
    let NodeCellId = "nodeCell"
    //选项展开的图标
    let image_ex = "tree_ex.png"
    //选项未展开的图标
    let image_ec = "tree_ec.png"
    
    init(frame: CGRect, data: [BaseItem]) {
        super.init(frame: frame, style: .plain)
        self.mNodes = data
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mNodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 通过nib自定义tableviewcell
        let nib = UINib(nibName: "TreeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NodeCellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NodeCellId) as! TreeTableViewCell
        
        let node: BaseItem = mNodes![indexPath.row]
        
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
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
