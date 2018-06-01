//
//  ProjectInfoViewController.swift
//  ShowCollectData
//
//  Created by 星空 on 2018/1/21.
//  Copyright © 2018年 星空. All rights reserved.
//

import UIKit

//项目信息界面
class ProjectInfoViewController: BasePageViewController, BMKMapViewDelegate, BMKLocationServiceDelegate{

    let titles: [String] = ["项目名称：", "项目位置：", "设计处理量：", "排放标准：", "达标排放量：", "太阳能发电电能："]
    let contents: [String] = ["", "", "", "", "", ""]
    
    
    var mapView: BMKMapView!
    var btnBack: UIButton!
    var locService: BMKLocationService!
    var isLocAvaliable: Bool = false
    
    
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
        mapView.showsUserLocation = true
        mapView.showMapScaleBar = true
        mapView.compassPosition = CGPoint(x: 10, y: 10)
        mapView.userTrackingMode = BMKUserTrackingModeHeading
        mapView.zoomLevel = 18
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
        locService = BMKLocationService()
        locService.delegate = self
        locService.startUserLocationService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTitleView(titleHeight: 40)
        
        let infoOffsetX: CGFloat = 50
        let infoOffsetY: CGFloat = 100
        let infoFrameW: CGFloat = itemBgWidth - infoOffsetX - infoOffsetX
        let infoFrameH: CGFloat = itemBgHeight - infoOffsetY - 20
        
        let infoFrame = CGRect(x: infoOffsetX, y: infoOffsetY, width: infoFrameW, height: infoFrameH)
        addInfoView(infoViewFrame: infoFrame, titleRatio: 0.4, titles: titles, contents: contents)
        
        //地图按钮在信息框的第几排
        let mapBtnIndex: CGFloat = 1
        //信息框的一排的高度
        let infoFrameItemH:CGFloat = infoFrameH / CGFloat(titles.count)
        
        let mapBtnW:CGFloat = 45
        let mapBtnH:CGFloat = 30
        let mapBtnOffsetX: CGFloat = itemBgWidth - infoOffsetX
        let mapBtnOffsetY: CGFloat = infoOffsetY + mapBtnIndex * infoFrameItemH + (infoFrameItemH - mapBtnH) / 2
        
        let mapBtnFrame = CGRect(x: mapBtnOffsetX, y: mapBtnOffsetY, width: mapBtnW, height: mapBtnH)
        addButton(buttonframe: mapBtnFrame, title: "地图", target: self, action: #selector(onBtnMapClicked(_:)), for: .touchUpInside)
        
        refreshMapView()
       
        
        guard let projects = self.allProjects else { return }
        if projects.count > 0 {
            self.selectedProject = projects[0]
        }
        
        //获取保存的数据
        let accountDefaults = UserDefaults.standard
        guard let projectId = accountDefaults.value(forKey: loginAccount+"_"+Keys.selectedProjectId) else{ return }
        let id = projectId as! Int
        for project in projects {
            if id == project.id {
                self.selectedProject = project
                    break
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
        mapView.delegate = nil
    }
    
    override func refreshProject() {
        NSLog("Refresh Project!!")
        NSLog("选中的项目："+self.selectedProject.toJSON())
        
        ClientRequest.getTotalPChg(projectId: self.selectedProject.id){
            resProjectInfo in
            if let projectInfo = resProjectInfo {
                //失败
                if projectInfo.retCode == 1{
                    let error:String = projectInfo.msg
                    NSLog("error: " + error)
                    let errorMsg = "错误：" + error
                    ToastHelper.showGlobalToast(message: errorMsg)
                    return
                }
                //返回码不为1，查找成功！
                NSLog("success!!!")
                self.refreshInfomation(projectInfo: projectInfo)
            }
            else{
                ToastHelper.showGlobalToast(message: "获取数据失败！")
            }
            
        }
    }
    
    func refreshInfomation(projectInfo: ShowProjectInfo!){
        
        self.infomationView.refreshOneContent(at: 0, content: selectedProject.projectName)
        self.infomationView.refreshOneContent(at: 1, content: selectedProject.locationName+selectedProject.street)
        self.infomationView.refreshOneContent(at: 2, content: String(selectedProject.capability) + "D/T")
        self.infomationView.refreshOneContent(at: 3, content: emissionStdAccessment[selectedProject.emissionStandards])
        
        
        self.infomationView.refreshOneContent(at: 4, content: String(selectedProject.state) + "D/T")
        
        let totalPchg:Float = Float(projectInfo.projectTotalPChg) / 100
        self.infomationView.refreshOneContent(at: 5, content: String(totalPchg)+"KWh")
        
        if let longtitude = projectInfo.longtitude, let altitude = projectInfo.altitude {
            self.isLocAvaliable  = true
            let long = CLLocationDegrees(longtitude)
            let la = CLLocationDegrees(altitude)
            let coordinate = CLLocationCoordinate2D(latitude: la!, longitude: long!)
            mapLocation(locationCoordinate: coordinate)
        }else{
            self.isLocAvaliable = false
        }
        
    }
    
    func mapLocation(locationCoordinate: CLLocationCoordinate2D){
        //设置地图的显示范围（越小越精确）
        let span = BMKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //设置地图最终显示区域
        let region = BMKCoordinateRegion(center: locationCoordinate, span: span)
        mapView?.region = region
        
        // 添加一个标记点(PointAnnotation）
        let annotation =  BMKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "项目位置"
        mapView!.addAnnotation(annotation)
    }
    
    @objc func onBtnMapClicked(_ sender:UIButton) {
        guard (self.selectedProject) != nil else {
            NSLog("未选择项目")
            ToastHelper.showGlobalToast(message: "未选择项目！")
            return
        }
        
        if !isLocAvaliable{
            ToastHelper.showGlobalToast(message: "定位不可用！")
            return
        }
        
        self.itemBgView.isHidden = true
        self.mapView.isHidden = false
        self.btnBack.isHidden = false
        
        //mapLocation()
    }
    
    @objc func onBtnBackClicked(_ sender: UIButton){
        self.btnBack.isHidden = true
        self.mapView.isHidden = true
        self.itemBgView.isHidden = false
    }
    
    //获取到位置变化
    func didUpdate(_ userLocation: BMKUserLocation!) {
        //mapLocation(locationCoordinate: userLocation.location.coordinate)
    }
    
    //获取到方向变化
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        
    }
    
}
