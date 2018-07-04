//
//  EmergencyFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

enum OnOrOffState: Int {
    case off = 0
    case on = 1
    case auto = 2
}

protocol OnOrOffDelegate {
    func stateChange(onorOffButton: OnOrOffButton)
    func totalstateChange(totalonorOffButton:totalOnOrOffButton)
}


class totalOnOrOffButton {
    var labelOn: UILabel!
    var labelOff: UILabel!
    
    var switchOn: UISwitch!
    //var switchOff: UISwitch!
    
    var state: OnOrOffState!
    
    var delegate:  OnOrOffDelegate?
    
    init(parentView: UIView,  frameOn: CGRect, frameOff: CGRect) {
        
        let onX = frameOn.origin.x
        let onY = frameOn.origin.y
        let onW = frameOn.size.width / 2 - 2
        let onH = frameOn.size.height
        
        let offX = frameOff.origin.x - 5
        let offY = frameOff.origin.y
        let offW = frameOff.size.width / 2 - 2
        let offH = frameOff.size.height
        
        let frameOnLabel = CGRect(x: onX, y: onY, width: onW, height: onH)
        let frameOnSwitch = CGRect(x: onX + onW + 8, y: onY, width: onW, height: onH)
    
        let frameOffLabel = CGRect(x: offX, y: offY, width: offW, height: offH)
        //let frameOffSwitch = CGRect(x: offX + offW + 1, y: offY, width: offW, height: offH)
        
        labelOn = UILabel(frame: frameOnLabel)
        labelOn.text = "急停"
        //labelOn.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"];
    
        labelOn.adjustFontByScreenHeight(isTitle:true)
        labelOn.textAlignment = .center
        switchOn = UISwitch(frame: frameOnSwitch)
        switchOn.center = CGPoint(x: onX + onW + onW / 2 + 2, y: onY + onH/2)
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667.0 {
            switchOn.transform = CGAffineTransform(scaleX: 0.9,y: 0.8);
        } else if screenH >= 667.0 && screenH < 736.0 {
            switchOn.transform = CGAffineTransform(scaleX: 1.1,y: 0.95);
        } else if screenH >= 736.0 {
            switchOn.transform = CGAffineTransform(scaleX: 1.2,y: 1.0);
        }
        
        
        labelOff = UILabel(frame: frameOffLabel)
        labelOff.text = "自动"
        labelOff.adjustFontByScreenHeight(isTitle:true)
        labelOff.textAlignment = .center
        //switchOff = UISwitch(frame: frameOffSwitch)
        //switchOff.center = CGPoint(x: offX + offW + offW / 2 + 1, y: offY + offH/2)
        
        state = .on
        
        parentView.addSubview(labelOn)
        parentView.addSubview(switchOn)
        parentView.addSubview(labelOff)
    
        switchOn.addTarget(self, action: #selector(totalswitchOnChange(_:)), for: UIControlEvents.valueChanged)
        
    }
    
    @objc func totalswitchOnChange(_ sender: UISwitch) {
        
        if sender.isOn {
            self.state = .on
            print("On")
        }else{
            self.state = .off
            print("off")
        }
       self.delegate?.totalstateChange(totalonorOffButton: self)
    }
    
    
    func settotalState(newState: OnOrOffState) {
        switch newState {
        case .on:
            self.switchOn.setOn(true, animated: true)
        case .off:
            self.switchOn.setOn(false, animated: true)
        case .auto:
            self.switchOn.setOn(true, animated: true)
        }
        self.state = newState
    }
}

class OnOrOffButton {
    var labelOn: UILabel!
    var labelOff: UILabel!
    
    var switchOn: UISwitch!
    //var switchOff: UISwitch!
    
    var state: OnOrOffState!
    var index: Int!
    
    var delegate:  OnOrOffDelegate?
    
    init(parentView: UIView, index: Int, frameOn: CGRect, frameOff: CGRect) {
        
        self.index = index
        
        let onX = frameOn.origin.x
        let onY = frameOn.origin.y
        let onW = frameOn.size.width / 2 - 1
        let onH = frameOn.size.height
        
        let offX = frameOff.origin.x - 2
        let offY = frameOff.origin.y
        let offW = frameOff.size.width / 2 - 1
        let offH = frameOff.size.height
        
        let frameOnLabel = CGRect(x: onX, y: onY, width: onW, height: onH)
        let frameOnSwitch = CGRect(x: onX + onW + 1, y: onY, width: onW, height: onH)
    
        let frameOffLabel = CGRect(x: offX, y: offY, width: offW, height: offH)
       // let frameOffSwitch = CGRect(x: offX + offW + 1, y: offY, width: offW, height: offH)
        
        labelOn = UILabel(frame: frameOnLabel)
        labelOn.text = "关"
        labelOn.adjustFontByScreenHeight()
        labelOn.textAlignment = .center
        switchOn = UISwitch(frame: frameOnSwitch)
        switchOn.center = CGPoint(x: onX + onW + onW / 2 + 1, y: onY + onH/2)
        switchOn.transform = CGAffineTransform(scaleX: 0.7,y: 0.6);
        
        labelOff = UILabel(frame: frameOffLabel)
        labelOff.text = "开"
        labelOff.adjustFontByScreenHeight()
        labelOff.textAlignment = .center
        //switchOff = UISwitch(frame: frameOffSwitch)
        //switchOff.center = CGPoint(x: offX + offW + offW / 2 + 1, y: offY + offH/2)
        
        state = .off//默认关闭
        
        parentView.addSubview(labelOn)
        parentView.addSubview(switchOn)
        parentView.addSubview(labelOff)
        //parentView.addSubview(switchOff)
        
        
        switchOn.addTarget(self, action: #selector(switchOnChange(_:)), for: UIControlEvents.valueChanged)
        
        //switchOff.addTarget(self, action: #selector(switchOffChange(_:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func switchOnChange(_ sender: UISwitch) {
   
        if sender.isOn {
            self.state = .on
            print("On")
        }else{
            self.state = .off
            print("off")
        }
        self.delegate?.stateChange(onorOffButton: self)
    }
    
    
    func setState(newState: OnOrOffState) {
        switch newState {
        case .on:
            self.switchOn.isHidden = false
            self.labelOn.isHidden = false
            self.labelOff.isHidden = false
            self.switchOn.setOn(true, animated: true)
        case .off:
            self.switchOn.isHidden = false
            self.labelOn.isHidden = false
            self.labelOff.isHidden = false
            self.switchOn.setOn(false, animated: true)
        case .auto:
            //self.switchOn.setOn(true, animated: true)
            self.switchOn.isHidden = true
            self.labelOn.isHidden = true
            self.labelOff.isHidden = true
        }
        self.state = newState
    }
}

protocol EmergencyFragmentDelegate{
    func fanStateChange(fragment: EmergencyFragment, index: Int, state: OnOrOffState)
    func totalStateChange(fragment: EmergencyFragment, state: OnOrOffState)
}
//紧急停运界面
class EmergencyFragment: UIView {
    
    let titles = ["风机：","备用风机：","水泵：","备用水泵："]
    
    var buttons: [OnOrOffButton] = []
    
    var labels:[UILabel] = []

    var totalbutton:totalOnOrOffButton?
    
    var verticalScrollView: UIScrollView!
    
    var delegate: EmergencyFragmentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(verticalScrollView)
        addtotalcontrolImage();
        addOnAndOffImage(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func addtotalcontrolImage() {
	    //let contentHeight: CGFloat = self.frame.height
        let contentWidth: CGFloat = self.frame.width
    
        var itemH: CGFloat = 50
        var titleW: CGFloat = 100
        var buttonW: CGFloat = 80
        var topMargin:CGFloat = 10
        
        let screenH = UIScreen.main.bounds.height
        
        if screenH >= 568.0 && screenH < 667.0 {
            itemH = 70
            titleW = 80
            buttonW = 100
            topMargin = 2
        } else if screenH >= 667.0 && screenH < 736.0 {
            itemH = 80
            titleW = 90
            buttonW = 110
            topMargin = 5
        } else if screenH >= 736.0 {
            itemH = 90
            titleW = 100
            buttonW = 120
            topMargin = 10
        }
    
        let paddingW: CGFloat = 10
        
        let itemTotalW = titleW + paddingW + buttonW + paddingW + buttonW
        let leftMargin = (contentWidth - itemTotalW) / 2
	    
        let buttonOnFrame = CGRect(x: leftMargin + titleW , y: topMargin, width: buttonW, height: itemH)
        let buttonOffFrame = CGRect(x: leftMargin + titleW + paddingW + buttonW + paddingW, y: topMargin, width: buttonW, height: itemH)
        
        /******just for draw line*******/
       /* let mDevices = [ShowDevice]()
        let deviceY = topMargin + itemH - 50
        let devicesFrame = CGRect(x: 0, y: deviceY, width: contentWidth - topMargin, height: 50)
        let devicesTableView = DevicesTableView(frame: devicesFrame, devices: mDevices )
        self.verticalScrollView.addSubview(devicesTableView)*/
        /*******************/
        self.totalbutton = totalOnOrOffButton(parentView: self.verticalScrollView, frameOn: buttonOnFrame, frameOff: buttonOffFrame)
        self.totalbutton?.delegate = self
        let deviceY = topMargin + itemH - 10
        let rect4 = CGRect(x: topMargin, y: deviceY, width: contentWidth - topMargin - topMargin, height: 1)
        let bottomLine = UIView(frame: rect4)
        bottomLine.backgroundColor = ColorUtils.itemTitleViewBgColor
        self.addSubview(bottomLine)

    }

 
    func addOnAndOffImage(titles: [String]) {
        let contentHeight: CGFloat = self.frame.height
        let contentWidth: CGFloat = self.frame.width
        
        let itemSize = CGFloat(titles.count)
        
        var itemH: CGFloat = 50
        var titleW: CGFloat = 100
        var buttonW: CGFloat = 80
        
        let screenH = UIScreen.main.bounds.height
        let topMarginfix:CGFloat = 20
        var paddingH: CGFloat = 10
        var paddingW: CGFloat = 10
        
        if screenH >= 568.0 && screenH < 667.0 {
            itemH = 40
            titleW = 80
            buttonW = 70
          //  topMarginfix = 20
            paddingH = 3
            paddingW = 3
        } else if screenH >= 667.0 && screenH < 736.0 {
            itemH = 45
            titleW = 90
            buttonW = 75
          //  topMarginfix = 20
            paddingH = 4
            paddingW = 4
        } else if screenH >= 736.0 {
            itemH = 50
            titleW = 100
            buttonW = 80
         //   topMarginfix = 20
            paddingH = 5
            paddingW = 5
        }
        
        
        let itemTotalH = itemSize * itemH + (itemSize-1) * paddingH
        let topMargin = (contentHeight - itemTotalH) / 2
        
        let itemTotalW = titleW + paddingW + buttonW + paddingW + buttonW
        let leftMargin = (contentWidth - itemTotalW) / 2
        
        let ox = leftMargin
        var oy = topMargin + topMarginfix
        
        var i = 0
        for title in titles {
            let labelFrame = CGRect(x: ox, y: oy, width: titleW, height: itemH)
            let label = UILabel(frame: labelFrame)
            label.text = title
            label.textAlignment = .right
            label.adjustFontByScreenHeight()
            self.verticalScrollView.addSubview(label)
            
            let buttonOnFrame = CGRect(x: ox + titleW + paddingW, y: oy, width: buttonW, height: itemH)
            let buttonOffFrame = CGRect(x: ox + titleW + paddingW + buttonW + paddingW, y: oy, width: buttonW, height: itemH)
            
            let button = OnOrOffButton(parentView: self.verticalScrollView, index: i,frameOn: buttonOnFrame, frameOff: buttonOffFrame)
            button.delegate = self
            self.buttons.append(button)
            self.labels.append(label)
            
            oy += (itemH + paddingH)
            i+=1
        }
    }
    
    func refreshdata(state0:Int){
        print ("3333333")
        print(state0)
        switch(state0){
            case 0:
                self.labels[0].isHidden = false
                self.labels[1].isHidden = false
                self.labels[2].isHidden = false
                self.labels[3].isHidden = false
                self.buttons[0].setState(newState: .off)
                self.buttons[1].setState(newState: .off)
                self.buttons[2].setState(newState: .off)
                self.buttons[3].setState(newState: .off)
            case 1:
                self.labels[0].isHidden = true
                self.labels[1].isHidden = true
                self.labels[2].isHidden = true
                self.labels[3].isHidden = true
                self.buttons[0].setState(newState: .auto)
                self.buttons[1].setState(newState: .auto)
                self.buttons[2].setState(newState: .auto)
                self.buttons[3].setState(newState: .auto)
            default:
                break
        }
    }
    
    func refreshDeviceData(devices: [ShowDevice]){
        guard devices.count >= 1 else {
            return
        }
        
        let device = devices[0]
        
        let deviceState0 = OnOrOffState(rawValue: Int(device.sw0))
        let deviceState1 = OnOrOffState(rawValue: Int(device.sw1))
        let deviceState2 = OnOrOffState(rawValue: Int(device.sw2))
        let deviceState3 = OnOrOffState(rawValue: Int(device.sw3))
        
        if let state0 = deviceState0, let state1 = deviceState1, let state2 = deviceState2, let state3 = deviceState3 {
            switch(state0){
                case .off:
                    self.totalbutton?.settotalState(newState:.off)
                    self.labels[0].isHidden = false
                    self.labels[1].isHidden = false
                    self.labels[2].isHidden = false
                    self.labels[3].isHidden = false
                case .on:
                    self.totalbutton?.settotalState(newState:.off)
                    self.labels[0].isHidden = false
                    self.labels[1].isHidden = false
                    self.labels[2].isHidden = false
                    self.labels[3].isHidden = false
                case .auto:
                    self.totalbutton?.settotalState(newState:.on)
                    self.labels[0].isHidden = true
                    self.labels[1].isHidden = true
                    self.labels[2].isHidden = true
                    self.labels[3].isHidden = true
                    self.buttons[0].setState(newState: .auto)
                    self.buttons[1].setState(newState: .auto)
                    self.buttons[2].setState(newState: .auto)
                    self.buttons[3].setState(newState: .auto)
                    return
            }
            self.buttons[0].setState(newState: state0)
            self.buttons[1].setState(newState: state1)
            self.buttons[2].setState(newState: state2)
            self.buttons[3].setState(newState: state3)
           // print(state0,state1,state2,state3);
        }
    }
    
    
}

extension EmergencyFragment: OnOrOffDelegate {
    func stateChange(onorOffButton: OnOrOffButton) {
        print(String(onorOffButton.index) + " " + String(onorOffButton.state.rawValue))
        delegate?.fanStateChange(fragment: self, index: onorOffButton.index, state: onorOffButton.state)
    }
    func totalstateChange(totalonorOffButton: totalOnOrOffButton) {
        print(String(totalonorOffButton.state.rawValue))
        delegate?.totalStateChange(fragment: self, state: totalonorOffButton.state)
    }
}
