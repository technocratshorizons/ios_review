//
//  dealsNearViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 01/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class dealsNearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealsNearMe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore1Cell") as! explore1Cell
        
        let  titleEvent    = (cell.viewWithTag(1) as! UILabel)
        let  mobileNumber  = (cell.viewWithTag(5) as! UILabel)
        let  addressLabel  = (cell.viewWithTag(6) as! UILabel)
        let  openCloseTime = (cell.viewWithTag(8) as! UILabel)
        
        
        let DicData = dealsNearMe.object(at: indexPath.row) as! NSDictionary
        
        titleEvent.text   = DicData.object(forKey: "vendor")  as? String
        mobileNumber.text = DicData.object(forKey: "number")  as? String
        addressLabel.text = DicData.object(forKey: "address") as? String
        
        openCloseTime.text = "Open \(DicData.object(forKey: "open_time") as! String)-\(DicData.object(forKey: "close_time") as! String)"
        print(DicData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dicData  = dealsNearMe.object(at: indexPath.row)
        performSegue(withIdentifier: "dealsNearMe", sender: dicData)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "dealsNearMe" {
            if let nextVC = segue.destination as? explore2VC {
                nextVC.detailsDicData = (sender as! NSDictionary)
            }
        }
        
    }
    
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    var dealsNearMe = NSMutableArray()
    @IBOutlet weak var mapForLocation: MKMapView!

    @IBOutlet weak var dealsNearTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getdealsNearMeData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getdealsNearMeData() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id")
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let params =  ["user_id":userId!,"action":Cager.User.deals_near_me]as [String : Any]
        print(params)
        Alamofire.request( urlRequest, method: .post, parameters:params , encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                
                if response.result.isSuccess
                {
                    let ShortDic = response.result.value as! NSDictionary
                    let item2 = ShortDic.value(forKey: "success") as! NSNumber
                    
                    if item2 == 1
                    {
                        print(ShortDic)
                        let dicData = ShortDic.value(forKey: "data") as! NSArray
                        for checkData in dicData
                        {
                            self.dealsNearMe.addObjects(from: [checkData])
                        }
                        let latlong = ShortDic.value(forKey: "latlong") as! NSArray
                        
                        for checkData_latlong in latlong
                        {
                            // self.hotDealslatlongArray.addObjects(from: [checkData_latlong])
                            let lati = String(describing: (checkData_latlong as AnyObject).object(forKey: "latitude") as! NSNumber)
                            let long = String(describing: (checkData_latlong as AnyObject).object(forKey: "longitude") as! NSNumber)
                            
                            self.openMapForPlace(Latitude: lati, Longitutde: long)
                            
                        }
                        print(self.dealsNearMe.count)
                        self.dealsNearTable.reloadData()
                        
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                    }
                    else
                        
                    {
                        self.app_delegate.setUIBlockingEnabled(false)
                        common.showPositiveMessage(message: ShortDic.value(forKey: "message") as! String)
                    }
                }
                else
                {
                    self.app_delegate.setUIBlockingEnabled(false)
                    common.showPositiveMessage(message: "server not respond yet please try after some time!!!")
                    
                }
        }
    }
    func openMapForPlace(Latitude: String, Longitutde: String) {
        
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let _:CLLocationDistance = 10000
        _ = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        let latDelta:CLLocationDegrees = 0.01
        
        let longDelta:CLLocationDegrees = 0.01
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
        mapForLocation.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        //  objectAnnotation.title = detailsDicDataDetail.object(forKey: "address") as! String
        self.mapForLocation.addAnnotation(objectAnnotation)
    }
    
}


