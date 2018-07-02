//
//  RunningDataFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class RunningDataFragment: UIView {
    
    var projectType: Int! {
        didSet{
            guard let deviceInfoText = self.deviceInfoText else { return }
            if projectType == ShowProject.PROJ_TYPE_SUNPOWER || projectType == ShowProject.PROJ_TYPE_SMART {
                deviceInfoText.text = "太阳能污水处理控制器"
            } else if projectType == ShowProject.PROJ_TYPE_WATER {
                deviceInfoText.text = "水体太阳能控制器"
            }
            
        }
    }
    var btnBack:    UIButton!
    
    var solarGif:   UIImageView!
    var deviceGif:  MyGifView!
    var batteryGif: MyGifView!
    //stat1~4Gif 分别代表风机、备用风机、水泵、备用水泵的状态gif图
    var stat1Gif:   MyGifView!
    var stat2Gif:   MyGifView!
    var stat3Gif:   MyGifView!
    var stat4Gif:   MyGifView!
    
    var solarInfoText: UITextView!
    var deviceInfoText: UITextView!
    var batteryInfoText: UITextView!
    var stat1InfoText: UITextView!
    var stat2InfoText: UITextView!
    var stat3InfoText: UITextView!
    var stat4InfoText: UITextView!
    
    func initGifViews(){
        
        print("屏幕高度 = \(UIScreen.main.bounds.height)")
        let scaleRate: CGFloat = 35 / 568
        var gifHeight: CGFloat = scaleRate * UIScreen.main.bounds.height
        var gifWidth: CGFloat = gifHeight
        var padding: CGFloat = 0
        let statGifCount: CGFloat = 4
        
        //边距
        let margin: CGFloat = 2
        //去除左右边距的内容宽度
        let contentWidth: CGFloat = self.frame.width - margin - margin
        
        if statGifCount * gifWidth >= contentWidth {
            padding = 4
            gifWidth = contentWidth / statGifCount - padding
            gifHeight = gifWidth
        }else{
            padding = contentWidth / statGifCount - gifWidth
        }
        
        
        //单排文本的高度
        let singleLineTextHeight:CGFloat = gifHeight / 3
        //整个gif视图的最大高度
        let maxHeight: CGFloat = gifHeight + singleLineTextHeight * 2 + gifHeight + singleLineTextHeight * 3 + gifHeight + singleLineTextHeight * 2
        
        let maxY: CGFloat = self.frame.height - 40
        let marginY: CGFloat = (maxY - maxHeight) / 2
        
        let startX: CGFloat = margin + padding + gifWidth / 2
        let startY: CGFloat = marginY
        
        solarGif = UIImageView(frame: CGRect(x: startX, y: startY, width: gifWidth, height: gifHeight))
        self.addSubview(solarGif)
        
        solarInfoText = UITextView(frame: CGRect(x: startX + gifWidth + margin, y: startY, width: gifWidth * 3 / 2, height: gifHeight))
        solarInfoText.backgroundColor = ColorUtils.selectedBtnColor
        solarInfoText.textColor = UIColor.white
        solarInfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(solarInfoText)
        
        let arrowDownImageH: CGFloat = singleLineTextHeight * 2 - 4
        let arrowDownImageW: CGFloat = 20
        let arrowDownImageX: CGFloat = margin + padding + gifWidth - 10
        let arrowDownImageY: CGFloat = startY + gifHeight + 2
        
        let arrowDownImage = UIImageView(frame: CGRect(x: arrowDownImageX, y: arrowDownImageY, width: arrowDownImageW, height: arrowDownImageH))
        arrowDownImage.image = UIImage(named: "arrowdown")
        arrowDownImage.contentMode = .scaleAspectFit
        self.addSubview(arrowDownImage)
        
        let deviceX: CGFloat = startX
        let deviceY: CGFloat = startY + gifHeight + singleLineTextHeight * 2
        
        deviceGif = MyGifView(frame: CGRect(x: deviceX, y: deviceY, width: gifWidth, height: gifHeight))
        self.addSubview(deviceGif)
        
        let dis: CGFloat = 2 * (padding + gifWidth)
        
        let arrowMargin: CGFloat = gifHeight / 9 * 2
        let arrowX: CGFloat = deviceX + gifWidth + padding
        let arrowY: CGFloat = deviceY + arrowMargin
        let arrowW: CGFloat = gifWidth
        let arrowH: CGFloat = gifHeight / 6
        
        let arrowLeft = UIImageView(frame: CGRect(x: arrowX, y: arrowY, width: arrowW, height: arrowH))
        arrowLeft.image = UIImage(named: "arrownew_left")
        arrowLeft.contentMode = .scaleToFill
        self.addSubview(arrowLeft)
        
        let arrowRight = UIImageView(frame: CGRect(x: arrowX, y: arrowY + arrowH + arrowMargin, width: arrowW, height: arrowH))
        arrowRight.image = UIImage(named: "arrownew_right")
        arrowRight.contentMode = .scaleToFill
        self.addSubview(arrowRight)
        
        let batteryX: CGFloat = deviceX + dis
        let batteryY: CGFloat = deviceY
        
        batteryGif = MyGifView(frame: CGRect(x: batteryX, y: batteryY, width: gifWidth, height: gifHeight))
        batteryGif.showGIFImageWithLocalName(name: "battery_pack")
        self.addSubview(batteryGif)
        
        batteryInfoText = UITextView(frame: CGRect(x: batteryX + gifWidth + margin, y: batteryY, width: gifWidth - 5, height: gifHeight))
        batteryInfoText.backgroundColor = ColorUtils.selectedBtnColor
        batteryInfoText.textColor = UIColor.white
        batteryInfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(batteryInfoText)
        
        
        let deviceInfoW: CGFloat = 130
        let deviceInfoH: CGFloat = singleLineTextHeight
        let deviceInfoX: CGFloat = deviceX + gifWidth / 2 - deviceInfoW / 2
        let deviceInfoY: CGFloat = deviceY + gifHeight
        
        
        deviceInfoText = UITextView(frame: CGRect(x: deviceInfoX, y: deviceInfoY, width: deviceInfoW, height: deviceInfoH))
        deviceInfoText.backgroundColor = ColorUtils.selectedBtnColor
        deviceInfoText.textColor = UIColor.white
        
        deviceInfoText.textAlignment = .center
        deviceInfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(deviceInfoText)

        let verticalLineW: CGFloat = 4
        let verticalLineH: CGFloat = singleLineTextHeight
        let verticalLineX: CGFloat = deviceX + gifWidth/2 - verticalLineW / 2
        let verticalLineY: CGFloat = deviceInfoY + deviceInfoH
        
        let verticalLine = UIView(frame: CGRect(x: verticalLineX, y: verticalLineY, width: verticalLineW, height: verticalLineH))
        verticalLine.layer.backgroundColor = ColorUtils.selectedBtnColor.cgColor
        self.addSubview(verticalLine)
        
        let horizontalLineW: CGFloat = 3 * (gifWidth + padding)
        let horizontalLineH: CGFloat = 2
        let horizontalLineX: CGFloat = margin + padding/2 + gifWidth / 2
        let horizontalLineY: CGFloat = verticalLineY + verticalLineH
        let horizontalLine = UIView(frame: CGRect(x: horizontalLineX, y: horizontalLineY, width: horizontalLineW, height: horizontalLineH))
        horizontalLine.layer.backgroundColor = ColorUtils.selectedBtnColor.cgColor
        self.addSubview(horizontalLine)
        
        let arrowDownW: CGFloat = singleLineTextHeight - 2
        let arrowDownH: CGFloat = singleLineTextHeight - 2
        var arrowDownX: CGFloat = horizontalLineX - arrowDownH / 2
        let arrowDownY: CGFloat = horizontalLineY + horizontalLineH
        
        
        let arrowDown1 = UIImageView(frame: CGRect(x: arrowDownX, y: arrowDownY, width: arrowDownW, height: arrowDownH))
        arrowDown1.image = UIImage(named: "arrowdown")
        arrowDown1.contentMode = .scaleAspectFit
        self.addSubview(arrowDown1)
        
        arrowDownX += (padding + gifWidth)
        let arrowDown2 = UIImageView(frame: CGRect(x: arrowDownX, y: arrowDownY, width: arrowDownW, height: arrowDownH))
        arrowDown2.image = UIImage(named: "arrowdown")
        arrowDown2.contentMode = .scaleAspectFit
        self.addSubview(arrowDown2)
        
        arrowDownX += (padding + gifWidth)
        let arrowDown3 = UIImageView(frame: CGRect(x: arrowDownX, y: arrowDownY, width: arrowDownW, height: arrowDownH))
        arrowDown3.image = UIImage(named: "arrowdown")
        arrowDown3.contentMode = .scaleAspectFit
        self.addSubview(arrowDown3)
        
        arrowDownX += (padding + gifWidth)
        let arrowDown4 = UIImageView(frame: CGRect(x: arrowDownX, y: arrowDownY, width: arrowDownW, height: arrowDownH))
        arrowDown4.image = UIImage(named: "arrowdown")
        arrowDown4.contentMode = .scaleAspectFit
        self.addSubview(arrowDown4)
        
        var deviceStateX: CGFloat = margin + padding / 2
        let deviceState1Y: CGFloat = arrowDownY + arrowDownH
        
        stat1Gif = MyGifView(frame: CGRect(x: deviceStateX, y: deviceState1Y, width: gifWidth, height: gifHeight))
        self.addSubview(stat1Gif)
        
        deviceStateX += (padding + gifWidth)
        stat2Gif = MyGifView(frame: CGRect(x: deviceStateX, y: deviceState1Y, width: gifWidth, height: gifHeight))
        self.addSubview(stat2Gif)
        
        deviceStateX += (padding + gifWidth)
        stat3Gif = MyGifView(frame: CGRect(x: deviceStateX, y: deviceState1Y, width: gifWidth, height: gifHeight))
        self.addSubview(stat3Gif)
        
        deviceStateX += (padding + gifWidth)
        stat4Gif = MyGifView(frame: CGRect(x: deviceStateX, y: deviceState1Y, width: gifWidth, height: gifHeight))
        self.addSubview(stat4Gif)
        
        let deviceStateTextW: CGFloat = padding + gifWidth - 2
        let deviceStateTextH: CGFloat = singleLineTextHeight * 2
        var deviceStateTextX: CGFloat = horizontalLineX - deviceStateTextW / 2
        let deviceStateTextY: CGFloat = deviceState1Y + gifHeight
        
        stat1InfoText = UITextView(frame: CGRect(x: deviceStateTextX, y: deviceStateTextY, width: deviceStateTextW, height: deviceStateTextH))
        stat1InfoText.backgroundColor = ColorUtils.selectedBtnColor
        stat1InfoText.textColor = UIColor.white
        stat1InfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(stat1InfoText)
        
        deviceStateTextX += (deviceStateTextW + 2)
        stat2InfoText = UITextView(frame: CGRect(x: deviceStateTextX, y: deviceStateTextY, width: deviceStateTextW, height: deviceStateTextH))
        stat2InfoText.backgroundColor = ColorUtils.selectedBtnColor
        stat2InfoText.textColor = UIColor.white
        stat2InfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(stat2InfoText)
        
        deviceStateTextX += (deviceStateTextW + 2)
        stat3InfoText = UITextView(frame: CGRect(x: deviceStateTextX, y: deviceStateTextY, width: deviceStateTextW, height: deviceStateTextH))
        stat3InfoText.backgroundColor = ColorUtils.selectedBtnColor
        stat3InfoText.textColor = UIColor.white
        stat3InfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(stat3InfoText)
        
        deviceStateTextX += (deviceStateTextW + 2)
        stat4InfoText = UITextView(frame: CGRect(x: deviceStateTextX, y: deviceStateTextY, width: deviceStateTextW, height: deviceStateTextH))
        stat4InfoText.backgroundColor = ColorUtils.selectedBtnColor
        stat4InfoText.textColor = UIColor.white
        stat4InfoText.contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        self.addSubview(stat4InfoText)
        
       // let marginLeft: CGFloat = self.frame.width - 
        
    }
    
    func resetDeviceData(){
        guard let solarGif = self.solarGif, let deviceGif = self.deviceGif, let batteryGif = self.batteryGif, let stat1Gif = self.stat1Gif, let stat2Gif = self.stat2Gif, let stat3Gif = self.stat3Gif, let stat4Gif = self.stat4Gif else { return }
        
        solarGif.setImage(name: "solar_panel_good", type: "png")
        deviceGif.showGIFImageWithLocalName(name: "solar_sewage_controller_bad")
        batteryGif.showGIFImageWithLocalName(name: "battery_pack")
        stat1Gif.showGIFImageWithLocalName(name: "fan_good")
        stat2Gif.showGIFImageWithLocalName(name: "fan_good")
        stat3Gif.showGIFImageWithLocalName(name: "waterpump_good")
        stat4Gif.showGIFImageWithLocalName(name: "waterpump_good")
        
        guard let solarInfoText = self.solarInfoText, let deviceInfoText = self.deviceInfoText, let batteryInfoText = self.batteryInfoText, let stat1InfoText = self.stat1InfoText, let stat2InfoText = self.stat2InfoText, let stat3InfoText = self.stat3InfoText, let stat4InfoText = self.stat4InfoText else { return }
        
        
        //根据屏幕高度设定字体大小
        let screenH = UIScreen.main.bounds.height
        var fontSize: CGFloat = 0
        if screenH >= 568.0 && screenH < 667 {
            fontSize = 9
        } else if screenH >= 667.0 && screenH < 736.0 {
            fontSize = 10
        } else if screenH >= 736.0{
            fontSize = 11
        }
        
        solarInfoText.font = UIFont.systemFont(ofSize: fontSize)
        deviceInfoText.font = UIFont.systemFont(ofSize: fontSize)
        batteryInfoText.font = UIFont.systemFont(ofSize: fontSize)
        stat1InfoText.font = UIFont.systemFont(ofSize: fontSize)
        stat2InfoText.font = UIFont.systemFont(ofSize: fontSize)
        stat3InfoText.font = UIFont.systemFont(ofSize: fontSize)
        stat4InfoText.font = UIFont.systemFont(ofSize: fontSize)
        
        
        
        solarInfoText.isEditable = false
        deviceInfoText.isEditable = false
        batteryInfoText.isEditable = false
        stat1InfoText.isEditable = false
        stat2InfoText.isEditable = false
        stat3InfoText.isEditable = false
        stat4InfoText.isEditable = false
        
        solarInfoText.text = ""
        deviceInfoText.text = ""
        batteryInfoText.text = ""
        stat1InfoText.text = ""
        stat2InfoText.text = ""
        stat3InfoText.text = ""
        stat4InfoText.text = ""
        
        if projectType == ShowProject.PROJ_TYPE_SMART || projectType == ShowProject.PROJ_TYPE_SUNPOWER {
            deviceInfoText.text = "太阳污水处理控制器"
        }else if projectType == ShowProject.PROJ_TYPE_WATER {
            deviceInfoText.text = "水体太阳能控制器"
        }
    }
    
    func refreshDeviceData(deviceData: ShowDeviceData){
        
        if projectType == ShowProject.PROJ_TYPE_SMART || projectType == ShowProject.PROJ_TYPE_SUNPOWER {
            self.deviceInfoText.text = "太阳污水处理控制器"
        }else if projectType == ShowProject.PROJ_TYPE_WATER {
            self.deviceInfoText.text = "水体太阳能控制器"
        }
        
        
        if let isOffline = deviceData.offline {
            if isOffline {
                self.solarInfoText.text = "无法获取数据"
                self.batteryInfoText.text = "无法获取数据"
                self.stat1InfoText.text = "无法获取数据"
                self.stat2InfoText.text = "无法获取数据"
                self.stat3InfoText.text = "无法获取数据"
                self.stat4InfoText.text = "无法获取数据"
            }else {
                
                deviceGif.showGIFImageWithLocalName(name: "solar_sewage_controller_good")
                
                if let vssn = deviceData.vssun, let ichg = deviceData.ichg, let pchg = deviceData.pchg{
                    if vssn == "0" && ichg == "0" {
                        solarGif.setImage(name: "solar_panel_bad", type: "png")
                    }else{
                        solarGif.setImage(name: "solar_panel_good", type: "png")
                    }
                    
                    let vssnD: Double = Double(vssn)! / 10.0
                    let ichgD: Double = Double(ichg)! / 10.0
                    let pchgD: Double = Double(pchg)! / 100.0
                    
                    var solarInfoStr:String = ""
                    solarInfoStr += String(vssnD)+"V\n"
                    solarInfoStr += String(ichgD)+"A\n"
                    solarInfoStr += String(pchgD)+"KWh\n"
                    solarInfoText.text = solarInfoStr
                }
                
                //显示电池电压容量、电池剩余百分数、电池温度
                let batteryVoltage = Double(deviceData.vbat)! / 10.0
                let batteryLevel = Int(deviceData.level)!
                let batteryTemp = Int(deviceData.temp)!
              
                var batteryStr = ""
                batteryStr += String(batteryVoltage) + "V\n"
                batteryStr += String(batteryLevel) + "%\n"
                batteryStr += String(batteryTemp)+"°C"
                batteryInfoText.text = batteryStr
                
                
                //显示风机、备用风机、水泵、备用水泵的电流和功耗
                let fanEleCurrent = Double(deviceData.ild1)! / 10.0
                let backFanEleCurrent = Double(deviceData.ild2)! / 10.0
                let waterPumpEleCurrent = Double(deviceData.ild3)! / 10.0
                let backWaterPumpCurrent = Double(deviceData.ild4)! / 10.0
                
                let fanConsumption = deviceData.ecd1!
                let backFanConsumption = deviceData.ecd2!
                let waterPumpFanConsumption = deviceData.ecd3!
                let backWaterPumpConsumption = deviceData.ecd4!
                
                var fanStr = ""
                fanStr += String(fanEleCurrent) + "A\n"
                fanStr += String(fanConsumption) + "KWh"
                self.stat1InfoText.text = fanStr
                
                var backFanStr = ""
                backFanStr += String(backFanEleCurrent) + "A\n"
                backFanStr += String(backFanConsumption) + "KWh"
                self.stat2InfoText.text = backFanStr
                
                var waterStr = ""
                waterStr += String(waterPumpEleCurrent) + "A\n"
                waterStr += String(waterPumpFanConsumption) + "KWh"
                self.stat3InfoText.text = waterStr

                var backWaterStr = ""
                backWaterStr += String(backWaterPumpCurrent) + "A\n"
                backWaterStr += String(backWaterPumpConsumption) + "KWh"
                self.stat4InfoText.text = backWaterStr
                
                guard let stat = deviceData.stat else { return }
                
                let state = StringUtils.hexStringToUInt16(value: stat)!
                
                //确定电池状态
                switch state & 0x0008 {
                case 0:
                    if deviceData.ichg == "0" {
                        
                        if batteryLevel < 20 { self.batteryGif.showGIFImageWithLocalName(name: "battery0") }
                        else if batteryLevel < 40 { self.batteryGif.showGIFImageWithLocalName(name: "battery1") }
                        else if batteryLevel < 60 { self.batteryGif.showGIFImageWithLocalName(name: "battery2") }
                        else if batteryLevel < 80 { self.batteryGif.showGIFImageWithLocalName(name: "battery3") }
                        else if batteryLevel < 100 { self.batteryGif.showGIFImageWithLocalName(name: "battery4") }
                        else { self.batteryGif.showGIFImageWithLocalName(name: "battery5") }
                    }else {
                        self.batteryGif.showGIFImageWithLocalName(name: "battery_pack")
                    }
                case 8:
                    self.batteryGif.showGIFImageWithLocalName(name: "battery_bad")
                default:
                    break
                }
                
                
                //确定风机的状态
                switch state & 0x8000 {
                case 0:
                    self.stat1Gif.showGIFImageWithLocalName(name: "fan_stop")
                case 0x8000:
                    if fanEleCurrent == 0.0 {
                        self.stat1Gif.showGIFImageWithLocalName(name: "fan_bad")
                    }else {
                        self.stat1Gif.showGIFImageWithLocalName(name: "fan_good")
                    }
                default:
                    break
                }
                
                //确定备用风机的状态
                switch state & 0x4000 {
                case 0:
                    self.stat2Gif.showGIFImageWithLocalName(name: "fan_stop")
                case 0x4000:
                    if backFanEleCurrent == 0.0 {
                        self.stat2Gif.showGIFImageWithLocalName(name: "fan_bad")
                    }else {
                        self.stat2Gif.showGIFImageWithLocalName(name: "fan_good")
                    }
                default:
                    break
                    
                }
                
                ////确定水泵的状态
                switch state & 0x2000 {
                case 0:
                    self.stat3Gif.showGIFImageWithLocalName(name: "waterpump_stop")
                case 0x2000:
                    if waterPumpEleCurrent == 0.0 {
                        self.stat3Gif.showGIFImageWithLocalName(name: "waterpump_bad")
                    }else {
                        self.stat3Gif.showGIFImageWithLocalName(name: "waterpump_good")
                    }
                default:
                    break
                    
                }
                
                //确定备用水泵的状态
                switch state & 0x1000 {
                case 0:
                    self.stat4Gif.showGIFImageWithLocalName(name: "waterpump_stop")
                case 0x1000:
                    if backWaterPumpCurrent == 0.0 {
                        self.stat4Gif.showGIFImageWithLocalName(name: "waterpump_bad")
                    }else {
                        self.stat4Gif.showGIFImageWithLocalName(name: "waterpump_good")
                    }
                default:
                    break
                    
                }
            }
        }
        
    }
    
    init(frame: CGRect, target: Any?, onBackBtnClickAction: Selector) {
        super.init(frame: frame)
        
        initGifViews()
       
        
        var w: CGFloat = 30
        var h: CGFloat = 20
        var backBtnFontSize: CGFloat = 0
        
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667 {
            w = 30
            h = 20
            backBtnFontSize = 12
        } else if screenH >= 667.0 && screenH < 736.0 {
            w = 40
            h = 25
            backBtnFontSize = 14
        } else if screenH >= 736.0{
            w = 50
            h = 30
            backBtnFontSize = 16
        }
        
        let x: CGFloat = (frame.width - w) / 2
        let y: CGFloat = frame.height - h - 5
        
        self.btnBack = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
        self.btnBack.setTitle("返回", for: .normal)
        self.btnBack.titleLabel?.font = UIFont.systemFont(ofSize: backBtnFontSize)
        self.btnBack.setTitleColor(UIColor.white, for: .normal)
        self.btnBack.layer.cornerRadius = 5
        self.btnBack.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        self.btnBack.addTarget(target, action: onBackBtnClickAction, for: .touchUpInside)
        
        self.addSubview(self.btnBack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func setImage(name: String, type: String) {
        let filePath = Bundle.main.path(forResource: name, ofType: type)
        self.image = UIImage(contentsOfFile: filePath!)
    }
}
