//
//  TimingRunFragment.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/5/22.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//定时运行界面
class TimingRunFragment: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var timeCollectionView: UICollectionView!
    var submitButton: UIButton!
    
    var checked: [Bool] = [Bool].init(repeating: false, count: 48)
    var timeTitles: [String] =
        ["0:00-0:30","0:30-1:00","1:00-1:30"
            ,"1:30-2:00","2:00-2:30","2:30-3:00"
            ,"3:00-3:30","3:30-4:00","4:00-4:30"
            ,"4:30-5:00","5:00-5:30","5:30-6:00"
            ,"6:00-6:30","6:30-7:00","7:00-7:30"
            ,"7:30-8:00","8:00-8:30","8:30-9:00"
            ,"9:00-9:30","9:30-10:00","10:00-10:30"
            ,"10:30-11:00","11:00-11:30","11:30-12:00"
            ,"12:00-12:30","12:30-13:00","13:00-13:30"
            ,"13:30-14:00","14:00-14:30","14:30-15:00"
            ,"15:00-15:30","15:30-16:00","16:00-16:30"
            ,"16:30-17:00","17:00-17:30","17:30-18:00"
            ,"18:00-18:30","18:30-19:00","19:00-19:30"
            ,"19:30-20:00","20:00-20:30","20:30-21:00"
            ,"21:00-21:30","21:30-22:00","22:00-22:30"
            ,"22:30-23:00","23:00-23:30","23:30-0:00"]
    
    let nodeCellId = "TimingRunView"
    
    
    func initCollectView()  {
        
        let margin: CGFloat = 8
        
        let itemWidth:CGFloat = (self.frame.width - margin * 4) / 3
        let itemHeigh: CGFloat = (itemWidth) / 3
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeigh)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = margin
        layout.scrollDirection = .vertical
        
        
        let rect = CGRect(x: margin, y: 8, width: self.frame.width - margin - margin, height: self.frame.height - 48)
        
        
        self.timeCollectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        self.addSubview(timeCollectionView)
        self.timeCollectionView.backgroundColor = UIColor.white
        self.timeCollectionView.allowsMultipleSelection = true
        
        let nib = UINib(nibName: "TimeCollectionViewCell", bundle: nil)
        self.timeCollectionView.register(nib, forCellWithReuseIdentifier: nodeCellId)
        
        self.timeCollectionView.dataSource = self
        self.timeCollectionView.delegate = self
        
    }
    
    func initSubmitButton(target: Any?, action: Selector, events: UIControlEvents) {
        
        
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        let screenH = UIScreen.main.bounds.height
        if screenH >= 568.0 && screenH < 667 {
            w = 60
            h = 20
        } else if screenH >= 667.0 && screenH < 736.0 {
            w = 80
            h = 25
        } else if screenH >= 736.0{
            w = 100
            h = 30
        }
        
        let x: CGFloat = (frame.width - w) / 2
        let y: CGFloat = frame.height - h - 5
        
        self.submitButton = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
        self.submitButton.setTitle("提交配置", for: .normal)
        self.submitButton.titleLabel?.adjustFontByScreenHeight()
        self.submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.layer.cornerRadius = 5
        self.submitButton.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        self.submitButton.addTarget(target, action: action, for: events)
        //self.submitButton.addTarget(self, action: #selector(onSubmitButtonClicked(_:)), for: .touchUpInside)
        self.addSubview(self.submitButton)
    }
    
    @objc func onSubmitButtonClicked(_ sender: UIButton) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCollectView()
        initSubmitButton(target: self, action: #selector(onSubmitButtonClicked(_:)), events: .touchUpInside)
    }
    
    init(frame: CGRect, target: Any?, action: Selector, events: UIControlEvents){
        super.init(frame: frame)
        
        initCollectView()
        initSubmitButton(target: target, action: action, events: events)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshTimingRunData(mode: ProjectWorkingMode) {
        guard mode.halfHours.count == 48 else {
            return
        }
        
        var i = 0
        for hH in mode.halfHours {
            if hH == 0 {
                self.checked[i] = false
            }else{
                self.checked[i] = true
            }
            i+=1
        }
        
        self.timeCollectionView.reloadData()
    }
    
    
}

extension TimingRunFragment: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeTitles.count
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: TimeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: nodeCellId, for: indexPath) as! TimeCollectionViewCell

        cell.data = TimeCellData(title: self.timeTitles[indexPath.row], checked: self.checked[indexPath.row])
        return cell

    }
}

extension TimingRunFragment: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if self.checked[index] {
            self.checked[index] = false
        }else {
            self.checked[index] = true
        }
        self.timeCollectionView.reloadItems(at: [indexPath])
        //self.timeCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if self.checked[index] {
            self.checked[index] = false
        }else {
            self.checked[index] = true
        }
        self.timeCollectionView.reloadItems(at: [indexPath])
        //self.timeCollectionView.reloadData()
    }
}
