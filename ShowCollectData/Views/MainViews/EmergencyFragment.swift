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
}

class OnOrOffButton {
    var labelOn: UILabel!
    var labelOff: UILabel!
    
    var switchOn: UISwitch!
    var switchOff: UISwitch!
    
    var state: OnOrOffState!
    var index: Int!
    
    var delegate:  OnOrOffDelegate?
    
    init(parentView: UIView, index: Int, frameOn: CGRect, frameOff: CGRect) {
        
        self.index = index
        
        let onX = frameOn.origin.x
        let onY = frameOn.origin.y
        let onW = frameOn.size.width / 2 - 1
        let onH = frameOn.size.height
        
        let offX = frameOff.origin.x
        let offY = frameOff.origin.y
        let offW = frameOff.size.width / 2 - 1
        let offH = frameOff.size.height
        
        let frameOnLabel = CGRect(x: onX, y: onY, width: onW, height: onH)
        let frameOnSwitch = CGRect(x: onX + onW + 1, y: onY, width: onW, height: onH)
    
        let frameOffLabel = CGRect(x: offX, y: offY, width: offW, height: offH)
        let frameOffSwitch = CGRect(x: offX + offW + 1, y: offY, width: offW, height: offH)
        
        labelOn = UILabel(frame: frameOnLabel)
        labelOn.text = "开"
        labelOn.textAlignment = .center
        switchOn = UISwitch(frame: frameOnSwitch)
        switchOn.center = CGPoint(x: onX + onW + onW / 2 + 1, y: onY + onH/2)
        
        labelOff = UILabel(frame: frameOffLabel)
        labelOff.text = "关"
        labelOff.textAlignment = .center
        switchOff = UISwitch(frame: frameOffSwitch)
        switchOff.center = CGPoint(x: offX + offW + offW / 2 + 1, y: offY + offH/2)
        
        state = .auto
        
        parentView.addSubview(labelOn)
        parentView.addSubview(switchOn)
        
        parentView.addSubview(labelOff)
        parentView.addSubview(switchOff)
        
        
        switchOn.addTarget(self, action: #selector(switchOnChange(_:)), for: UIControlEvents.valueChanged)
        
        switchOff.addTarget(self, action: #selector(switchOffChange(_:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func switchOnChange(_ sender: UISwitch) {
        
        if self.switchOff.isOn {
            self.switchOff.setOn(false, animated: true)
        }
        if sender.isOn {
            self.state = .on
            print("On")
        }else{
            self.state = .auto
            print("Auto")
        }
        self.delegate?.stateChange(onorOffButton: self)
    }
    
    @objc func switchOffChange(_ sender: UISwitch) {
        
        if self.switchOn.isOn {
            self.switchOn.setOn(false, animated: true)
        }
        
        if sender.isOn {
            self.state = .off
            print("Off")
        }else{
            self.state = .auto
            print("Auto")
        }
        self.delegate?.stateChange(onorOffButton: self)
    }
    
    func setState(newState: OnOrOffState) {
        switch newState {
        case .on:
            self.switchOn.setOn(true, animated: true)
            self.switchOff.setOn(false, animated: true)
        case .off:
            self.switchOn.setOn(false, animated: true)
            self.switchOff.setOn(true, animated: true)
        case .auto:
            self.switchOn.setOn(false, animated: true)
            self.switchOff.setOn(false, animated: true)
        }
        self.state = newState
    }
}

protocol EmergencyFragmentDelegate{
    func fanStateChange(fragment: EmergencyFragment, index: Int, state: OnOrOffState)
}
//紧急停运界面
class EmergencyFragment: UIView {
    
    let titles = ["风机：","备用风机：","水泵：","备用水泵："]
    
    var buttons: [OnOrOffButton] = []
    
    var verticalScrollView: UIScrollView!
    
    var delegate: EmergencyFragmentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(verticalScrollView)
        
        addOnAndOffImage(titles: titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOnAndOffImage(titles: [String]) {
        let contentHeight: CGFloat = self.frame.height
        let contentWidth: CGFloat = self.frame.width
        
        let itemSize = CGFloat(titles.count)
        
        let itemH: CGFloat = 50
        let titleW: CGFloat = 100
        let buttonW: CGFloat = 80
        
        let paddingH: CGFloat = 10
        let paddingW: CGFloat = 10
        
        let itemTotalH = itemSize * itemH + (itemSize-1) * paddingH
        let topMargin = (contentHeight - itemTotalH) / 2
        
        let itemTotalW = titleW + paddingW + buttonW + paddingW + buttonW
        let leftMargin = (contentWidth - itemTotalW) / 2
        
        let ox = leftMargin
        var oy = topMargin
        
        var i = 0
        for title in titles {
            let labelFrame = CGRect(x: ox, y: oy, width: titleW, height: itemH)
            let label = UILabel(frame: labelFrame)
            label.text = title
            label.textAlignment = .right
            self.verticalScrollView.addSubview(label)
            
            let buttonOnFrame = CGRect(x: ox + titleW + paddingW, y: oy, width: buttonW, height: itemH)
            let buttonOffFrame = CGRect(x: ox + titleW + paddingW + buttonW + paddingW, y: oy, width: buttonW, height: itemH)
            
            let button = OnOrOffButton(parentView: self.verticalScrollView, index: i,frameOn: buttonOnFrame, frameOff: buttonOffFrame)
            button.delegate = self
            self.buttons.append(button)
            
            oy += (itemH + paddingH)
            i+=1
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
            self.buttons[0].setState(newState: state0)
            self.buttons[1].setState(newState: state1)
            self.buttons[2].setState(newState: state2)
            self.buttons[3].setState(newState: state3)
        }
    }
    
    
}

extension EmergencyFragment: OnOrOffDelegate {
    func stateChange(onorOffButton: OnOrOffButton) {
        //print(String(onorOffButton.index) + " " + String(onorOffButton.state.rawValue))
        delegate?.fanStateChange(fragment: self, index: onorOffButton.index, state: onorOffButton.state)
    }
}
