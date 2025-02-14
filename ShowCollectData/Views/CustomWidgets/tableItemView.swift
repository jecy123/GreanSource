//
//  tableItemView.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/11.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

@objc protocol TableItemViewDelegate{
    @objc optional func onDeleteBtnClicked(sender tableItem: TableItemView)
}

enum TableItemType{
    case typeText
    case typePopup
    case typeRemovableText
    case typeMultiLineText
    case typeTextRight
    case typePopupRight
    case typenull
}

class TableItem
{
    var itemName:String!
    var itemType:TableItemType!
    var itemFrame: CGRect!
    var itemLabelRatio: CGFloat!
    var withBottomLine: Bool!
    var isHidden: Bool!
    
    init(name: String, type: TableItemType, frame:CGRect, ratio:CGFloat, withBottomLine: Bool = false, isHidden:  Bool = false) {
        self.itemName = name
        self.itemType = type
        self.itemFrame = frame
        self.itemLabelRatio = ratio
        self.withBottomLine = withBottomLine
        self.isHidden = isHidden
    }
}

class TableItemView: UIView {
    var nameLabel:UILabel!
    var contentText:UITextField!
    var contentTextView: UITextView!
    var contentPopup:DropBoxView!
    var deleteButton: UIButton!
    var bottomLine: UIView!

    var itemHeight: CGFloat!
    
    var delegate: TableItemViewDelegate?
    
    var extraMsg: String!
    
    var parentVC: UIViewController!
    
    ///constructor
    convenience init(parentVC:UIViewController, item: TableItem)
    {
        let type = item.itemType
        let itemFrame = item.itemFrame!
        
        var frame = CGRect(x: itemFrame.origin.x, y: itemFrame.origin.y, width: itemFrame.size.width, height: itemFrame.size.height)
        
        let labelRatio = item.itemLabelRatio!
        let withBottomLine = item.withBottomLine!
        
        self.init(frame: itemFrame)
        self.itemHeight = itemFrame.height
        
        if withBottomLine {
            frame.size.height -= 1
        }
        
        let rect = CGRect(x: 5, y: 0, width: frame.width * labelRatio - 5, height: frame.height - 1)
        nameLabel = UILabel(frame: rect)
        if type == TableItemType.typeTextRight || type == TableItemType.typePopupRight {
            nameLabel.textAlignment = .right
        }
        else {
            nameLabel.textAlignment = .left
        }
        nameLabel.adjustsFontSizeToFitWidth = true
        //nameLabel.font = UIFont.systemFont(ofSize: frame.height * 0.57)
        nameLabel.adjustFontByScreenHeight()
        nameLabel.text = item.itemName
        
        
        self.addSubview(nameLabel)
        
        if type == TableItemType.typeText || type == TableItemType.typeTextRight{
            
            let rect2 = CGRect(x: frame.width * labelRatio + 5, y: 0, width: frame.width*(1 - labelRatio) - 5,
                               height: frame.height)
            
            contentText = UITextField(frame: rect2)
            contentText.returnKeyType = .done
            contentText.delegate = self
            contentText.adjustFontByScreenHeight()
            contentText.layer.masksToBounds = true
            contentText.layer.backgroundColor = UIColor.white.cgColor
            self.addSubview(contentText)
        }else if type == TableItemType.typeRemovableText {
            let deleteButtonPadding: CGFloat = 10
            let deleteButtonHeight: CGFloat = frame.height - deleteButtonPadding * 2
            let deleteButtonWidth: CGFloat = 60
            
            let rect2 = CGRect(x:frame.width * labelRatio + 5, y:0, width:frame.width*(1 - labelRatio) - 5 - deleteButtonPadding * 2 - deleteButtonWidth, height:frame.height)
            contentText = UITextField(frame: rect2)
            contentText.returnKeyType = .done
            contentText.delegate = self
            contentText.adjustFontByScreenHeight()
            contentText.layer.masksToBounds = true
            contentText.layer.backgroundColor = UIColor.white.cgColor
            self.addSubview(contentText)
            
            
            let rect3 = CGRect(x:frame.width * labelRatio + 5 + rect2.width + deleteButtonPadding, y:deleteButtonPadding, width: deleteButtonWidth, height: deleteButtonHeight)
            deleteButton = UIButton(frame: rect3)
            deleteButton.layer.cornerRadius = 4
            deleteButton.layer.masksToBounds = true
            deleteButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
            deleteButton.setTitle("删除", for: .normal)
            deleteButton.setTitleColor(UIColor.white, for: .normal)
            deleteButton.setTitleColor(ColorUtils.itemTitleViewBgColor, for: .highlighted)
            deleteButton.addTarget(self, action: #selector(onDeleteBtnClicked(_:)), for: .touchUpInside)
            
            self.addSubview(deleteButton)
            setIsHidden(isHidden: item.isHidden)
        }else if type == TableItemType.typeMultiLineText {
            
            let rect2 = CGRect(x: frame.width * labelRatio + 5, y: 0, width: frame.width*(1 - labelRatio) - 5,
                               height: frame.height)
            contentTextView = UITextView(frame: rect2)
            contentTextView.returnKeyType = .done
            contentTextView.layer.masksToBounds = true
            contentTextView.layer.backgroundColor = UIColor.white.cgColor
            contentTextView.delegate = self
            self.addSubview(contentTextView)
        }
        
        
        if withBottomLine {
            let rect4 = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
            bottomLine = UIView(frame: rect4)
            bottomLine.backgroundColor = ColorUtils.itemTitleViewBgColor
            self.addSubview(bottomLine)
            
        }

        self.parentVC = parentVC
    }
    
    func setIsHidden(isHidden: Bool) {
        if isHidden {
            self.frame.size.height = 0
        }else{
            self.frame.size.height = self.itemHeight
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func onDeleteBtnClicked(_ sender: UIButton){
        self.delegate?.onDeleteBtnClicked?(sender: self)
    }

}

extension TableItemView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let vc = self.parentVC else { return textField.resignFirstResponder() }
        
        if textField.tag == -2 {
            let animationDuration : TimeInterval = 0.10
            UIView.beginAnimations("ResizeForKeyboard", context:nil)
            UIView.setAnimationDuration(animationDuration)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            
            let x = vc.view.frame.origin.x
            let rect = CGRect(x: x, y: 0, width: width, height: height)
            vc.view.frame = rect
            UIView.commitAnimations()
            textField.tag = 0
        }
        
        return textField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        guard let vc = self.parentVC else { return true }

        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        if textField.superview!.frame.origin.y + 400 > height{
            let animationDuration: TimeInterval = 0.2
            UIView.beginAnimations("ResizeForKeyboard", context: nil)
            UIView.setAnimationDuration(animationDuration)
        
            textField.tag = -2
            //上移100个单位，按实际情况设置
            let x = vc.view.frame.origin.x
            let rect = CGRect(x: x, y: -130, width: width, height: height)
            vc.view.frame = rect
            UIView.commitAnimations()
            
        }
        return true
    }
}

extension TableItemView: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textView.resignFirstResponder()
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        var textWidth = UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset).width
//        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
//        
//        let boundingRect = textView.bounds
//        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
//        
//        return numberOfLines <= 2;
//    }
}
