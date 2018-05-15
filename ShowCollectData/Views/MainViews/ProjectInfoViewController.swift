//
//  ProjectInfoViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/21.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目信息界面
class ProjectInfoViewController: BasePageViewController, BMKMapViewDelegate{

    let titles: [String] = ["项目名称：", "项目位置：", "设计处理量：", "排放标准：", "达标排放量：", "太阳能发电电能："]
    let contents: [String] = ["", "", "", "", "", ""]
    
    var mapView: BMKMapView!
    var btnBack: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViews(){
        mapView = BMKMapView()
        self.view.addSubview(mapView)
        mapView.isHidden = true
        
        btnBack = UIButton()
        btnBack.addTarget(self, action: #selector(onBtnBackClicked(_:)), for: .touchUpInside)
        btnBack.setTitle("返回", for: .normal)
        btnBack.setTitleColor(UIColor.white, for: .normal)
        btnBack.setTitleColor(UIColor.gray, for: .highlighted)
        btnBack.layer.cornerRadius = 5
        btnBack.layer.backgroundColor = ColorUtils.mainThemeColor.cgColor
        btnBack.isHidden = true
        self.view.addSubview(btnBack)
    }
    
    func refreshMapView(){
        mapView.frame = CGRect(x: itemLeftPadding, y: itemTopPadding, width: itemBgWidth, height: itemBgHeight)
        btnBack.frame = CGRect(x: itemLeftPadding + itemBgWidth / 2 - 25, y: itemTopPadding + itemBgHeight - 40, width: 50, height: 30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTitleView(titleHeight: 40)
        
        let infoOffsetX: CGFloat = 60
        let infoOffsetY: CGFloat = 100
        let infoFrameW: CGFloat = itemBgWidth - infoOffsetX - infoOffsetX
        let infoFrameH: CGFloat = itemBgHeight - infoOffsetY - 20
        
        let infoFrame = CGRect(x: infoOffsetX, y: infoOffsetY, width: infoFrameW, height: infoFrameH)
        addInfoView(infoViewFrame: infoFrame, titleRatio: 0.4, titles: titles, contents: contents)
        
        //地图按钮在信息框的第几排
        let mapBtnIndex: CGFloat = 1
        //信息框的一排的高度
        let infoFrameItemH:CGFloat = infoFrameH / CGFloat(titles.count)
        
        let mapBtnW:CGFloat = 50
        let mapBtnH:CGFloat = 30
        let mapBtnOffsetX: CGFloat = itemBgWidth - infoOffsetX
        let mapBtnOffsetY: CGFloat = infoOffsetY + mapBtnIndex * infoFrameItemH + (infoFrameItemH - mapBtnH) / 2
        
        let mapBtnFrame = CGRect(x: mapBtnOffsetX, y: mapBtnOffsetY, width: mapBtnW, height: mapBtnH)
        addButton(buttonframe: mapBtnFrame, title: "地图", target: self, action: #selector(onBtnMapClicked(_:)), for: .touchUpInside)
        
        refreshMapView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
        mapView.delegate = nil
    }
    
    override func refreshProject() {
        print("Refresh Project!!")
        self.infomationView.refreshOneContent(at: 0, content: selectedProject.projectName)
        self.infomationView.refreshOneContent(at: 1, content: selectedProject.locationName)
        self.infomationView.refreshOneContent(at: 2, content: String(selectedProject.capability) + "D/T")
        self.infomationView.refreshOneContent(at: 3, content: String(selectedProject.emissionStandards) + "D/T")
        self.infomationView.refreshOneContent(at: 4, content: "0")
        self.infomationView.refreshOneContent(at: 5, content: selectedProject.street)
    }
    
    func mapLocation(){
        //地图中心点坐标
        let center = CLLocationCoordinate2D(latitude: 31.245087, longitude: 121.506656)
        //设置地图的显示范围（越小越精确）
        let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //设置地图最终显示区域
        let region = BMKCoordinateRegion(center: center, span: span)
        mapView?.region = region
        
        // 添加一个标记点(PointAnnotation）
        let annotation =  BMKPointAnnotation()
        var coor = CLLocationCoordinate2D()
        coor.latitude = 31.254087
        coor.longitude = 121.512656
        annotation.coordinate = coor
        annotation.title = "这里有只野生皮卡丘"
        mapView!.addAnnotation(annotation)
    }
    
    @objc func onBtnMapClicked(_ sender:UIButton) {
//        guard let project = self.selectedProject else {
//            NSLog("未选择项目")
//            ToastHelper.showGlobalToast(message: "未选择项目！")
//            return
//        }
        
        self.itemBgView.isHidden = true
        self.mapView.isHidden = false
        self.btnBack.isHidden = false
        
        mapLocation()
    }
    
    @objc func onBtnBackClicked(_ sender: UIButton){
        self.btnBack.isHidden = true
        self.mapView.isHidden = true
        self.itemBgView.isHidden = false
    }
}
