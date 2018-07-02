//
//  InfoView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/3/2.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    var titleLabels: [UILabel] = []
    var contentLabels: [UILabel] = []
    
    var itemFrame: CGRect!
    
    func refreshOnTitle(at index: Int, title: String?){
        guard index < titleLabels.count else {
            print("超出范围")
            return
        }
        self.titleLabels[index].text = title
    }
    
    func refreshOneContent(at index: Int, content: String?){
        guard index < contentLabels.count else {
            print("超出范围")
            return
        }
        self.contentLabels[index].text = content
        
    }
    
    func addOneContent(title: String?, content:String?, index: Int, titleRatio: CGFloat, itemHeight: CGFloat){
        let itemWidth = itemFrame.width
        let ox: CGFloat = 0
        let oy: CGFloat = itemHeight * CGFloat(index)
        
        let titleWidth = itemWidth * titleRatio
        let contentWidth = itemWidth - titleWidth
        
        let titleFrame = CGRect(x: ox, y: oy, width: titleWidth, height: itemHeight)
        let contentFrame = CGRect(x: ox + titleWidth, y: oy, width: contentWidth, height: itemHeight)
        
        let titleLabel = UILabel(frame: titleFrame)
        self.titleLabels.append(titleLabel)
        self.addSubview(titleLabel)
        
        let contentLabel = UILabel(frame: contentFrame)
        self.contentLabels.append(contentLabel)
        self.addSubview(contentLabel)
        
        titleLabel.text = title
        contentLabel.text = content
        
        titleLabel.adjustFontByScreenHeight()
        contentLabel.adjustFontByScreenHeight()
        
        //titleLabel.adjustsFontSizeToFitWidth = true
        //contentLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        contentLabel.numberOfLines = 2
        
        titleLabel.textAlignment = .left
        contentLabel.textAlignment = .left
    }
    
    convenience init(frame: CGRect, titleRatio: CGFloat, titles: [String], contents: [String]){
        self.init(frame: frame)
        
        guard titles.count <= contents.count else {
            print("初始化数据格式错误")
            return
        }
        
        
        let itemCnt = titles.count
        let itemHeight = itemFrame.height / CGFloat(itemCnt)
        
        for i in 0..<itemCnt {
            addOneContent(title: titles[i], content: contents[i], index: i, titleRatio: titleRatio, itemHeight: itemHeight)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.itemFrame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
