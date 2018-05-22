//
//  MyGifView.swift
//  Demo2
//
//  Created by 星空 on 2018/5/18.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

class MyGifView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var width:CGFloat{return self.frame.size.width}
    var height:CGFloat{return self.frame.size.height}
    private var gifurl:URL! // 把本地图片转化成URL
    private var imageArr:Array<CGImage> = [] // 图片数组(存放每一帧的图片)
    private var timeArr:Array<NSNumber> = [] // 时间数组(存放每一帧的图片的时间)
    private var totalTime:Float = 0 // gif动画时间
    /**
     *  加载本地GIF图片
     */
    func showGIFImageWithLocalName(name:String) {
        gifurl = Bundle.main.url(forResource: name, withExtension: "gif")
        self.creatKeyFrame()
    }
    
    // 加载网络端的GIF图片
    func showGIFImageFromNetWork(url:NSURL) {
        let fileName = self.getMD5StringFromString(string: url.absoluteString!)
        let filePath = NSHomeDirectory()+"/Library/Caches/YDWGIF/" + fileName + ".gif"
        if FileManager.default.fileExists(atPath: filePath) {
            self.gifurl = URL(fileURLWithPath: filePath)
            self.creatKeyFrame()
        } else {
            let session = URLSession.shared
            let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    let path = NSURL(fileURLWithPath: filePath)
                    do {
                        try data?.write(to: path as URL)
                        self.gifurl = URL(fileURLWithPath: filePath)
                        self.creatKeyFrame()
                    } catch {
                        
                    }
                }
            })
            task.resume()
        }
    }
    
    /**
     *  获取GIF图片的每一帧 有关的东西  比如：每一帧的图片、每一帧的图片执行的时间
     */
    private func creatKeyFrame() {
        
        self.layer.removeAnimation(forKey: "MyGifView")
        imageArr.removeAll()
        timeArr.removeAll()
        //self.layer.removeAllAnimations()
        
        let url:CFURL = gifurl as CFURL
        let gifSource = CGImageSourceCreateWithURL(url, nil)
        let imageCount = CGImageSourceGetCount(gifSource!)
        
        for i in 0..<imageCount {
            let imageRef = CGImageSourceCreateImageAtIndex(gifSource!, i, nil) // 取得每一帧的图片
            imageArr.append(imageRef!)
            
            
            guard let sourceDict = CGImageSourceCopyPropertiesAtIndex(gifSource!, i, nil) as NSDictionary? else {
                print("转换失败！")
                return
                
            }
            let gifDict = sourceDict[String(kCGImagePropertyGIFDictionary)] as! NSDictionary
            //let gifDict = CFDictionaryGetValue(sourceDict, String(kCGImagePropertyGIFDictionary)) as! NSDictionary
            let time = gifDict[String(kCGImagePropertyGIFUnclampedDelayTime)] as! NSNumber//每一帧的动画时间
            timeArr.append(time)
            totalTime += time.floatValue
            
            // 获取图片的尺寸 (适应)
            let imageWitdh = sourceDict[String(kCGImagePropertyPixelWidth)] as! NSNumber
            let imageHeight = sourceDict[String(kCGImagePropertyPixelHeight)] as! NSNumber
            if ((imageWitdh.floatValue)/(imageHeight.floatValue) != Float((width)/(height))) {
                self.fitScale(imageWitdh: CGFloat(imageWitdh.floatValue), imageHeight: CGFloat(imageHeight.floatValue))
            }
        }
        
        self.showAnimation()
    }
    
    /**
     *  (适应)
     */
    private func fitScale(imageWitdh:CGFloat, imageHeight:CGFloat) {
        var newWidth:CGFloat
        var newHeight:CGFloat
        if imageWitdh/imageHeight > width/height {
            newWidth = width
            newHeight = width/(imageWitdh/imageHeight)
        } else {
            newWidth = height/(imageHeight/imageWitdh)
            newHeight = height;
        }
        let point = self.center;
        self.frame.size = CGSize(width: newWidth, height: newHeight)
        self.center = point;
    }
    
    /**
     *  展示动画
     */
    private func showAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "contents")
        var current:Float = 0
        var timeKeys:Array<NSNumber> = []
        
        for time in timeArr {
            timeKeys.append(NSNumber(value: current/totalTime))
            current += time.floatValue
        }
        animation.keyTimes = timeKeys
        animation.values = imageArr
        animation.repeatCount = HUGE;
        animation.duration = TimeInterval(totalTime)
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: "MyGifView")
    }
    

    
    // 将string转为MD5
    func getMD5StringFromString(string:String) -> String {
        let str = string.cString(using: .utf8)
        
        let strlen = CC_LONG(string.lengthOfBytes(using: .utf8))
        let digeTlen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digeTlen)
        CC_MD5(str!, strlen, result)
        let hash = NSMutableString()
        for i in 0..<digeTlen {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash as String)
    }
    
    // 清除图片缓存方法
    func cleanCache() {
        let folderPath = NSHomeDirectory()+"/Library/Caches/YDWGIF/"
        let manager = FileManager.default
        do {
            let fileName = try? manager.contentsOfDirectory(atPath: folderPath)
            for name in fileName! {
                try? manager.removeItem(atPath: folderPath+name)
            }
        }
//        catch {
//            NSLog("Error is %@", folderPath)
//        }
    }

}
