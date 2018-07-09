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
    
    convenience init(frame: CGRect, titleRatio: CGFloat, titles: [String], contents: [String] , status: CBool){
        self.init(frame: frame)
        
        guard titles.count <= contents.count else {
            print("初始化数据格式错误")
            return
        }
    
        let itemHeight = itemFrame.height / 5
        
        let itemWidth = itemFrame.width
        let ox: CGFloat = 0
        let oy: CGFloat = itemHeight
        
        let screenH = UIScreen.main.bounds.height
        var topMargin:CGFloat = 10
        if screenH >= 568.0 && screenH < 667.0 {
            topMargin = 10
        } else if screenH >= 667.0 && screenH < 736.0 {
            topMargin = 20
        } else if screenH >= 736.0 {
            topMargin = 30
        }
        
        let titleFrame = CGRect(x: ox, y: oy, width: itemWidth, height: itemHeight)
        let contentFrame = CGRect(x: ox + 30 , y: oy + itemHeight+topMargin, width: itemWidth, height: itemHeight)
        
        let titleLabel = UILabel(frame: titleFrame)
        self.titleLabels.append(titleLabel)
        self.addSubview(titleLabel)
        
        let contentLabel = UILabel(frame: contentFrame)
        self.contentLabels.append(contentLabel)
        self.addSubview(contentLabel)
        titleLabel.text = titles[0]
        contentLabel.text = contents[0]
        titleLabel.adjustFontByScreenHeight()
        contentLabel.adjustFontByScreenHeight()
        titleLabel.textAlignment = .left
        contentLabel.textAlignment = .left
        
        let titleFrame1 = CGRect(x: ox, y: oy + 2 * itemHeight + topMargin * 2, width: itemWidth, height: itemHeight)
        let contentFrame1 = CGRect(x: ox + 15, y: oy + 3 * itemHeight  + topMargin * 3, width: itemWidth, height: itemHeight)
        let contentFrame2 = CGRect(x: ox  + 30, y: oy + 4 * itemHeight  + topMargin * 4 , width: itemWidth, height: itemHeight)
        let titleLabel1 = UILabel(frame: titleFrame1)
        self.titleLabels.append(titleLabel1)
        self.addSubview(titleLabel1)
        
        let contentLabel1 = UILabel(frame: contentFrame1)
        self.contentLabels.append(contentLabel1)
        self.addSubview(contentLabel1)
        
        let contentLabel2 = UILabel(frame: contentFrame2)
        self.contentLabels.append(contentLabel2)
        self.addSubview(contentLabel2)
        titleLabel1.text = titles[1]
        contentLabel1.text = contents[1]
        contentLabel2.text = contents[2]
        titleLabel1.adjustFontByScreenHeight()
        contentLabel1.adjustFontByScreenHeight()
        contentLabel2.adjustFontByScreenHeight()
        titleLabel1.textAlignment = .left
        contentLabel1.textAlignment = .left
        contentLabel2.textAlignment = .left
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.itemFrame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
