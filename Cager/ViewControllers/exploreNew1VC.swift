//
//  exploreNew1VC.swift
//  Cager
//
//  Created by mac on 19/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MapKit

class exploreNew1VC: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var btnWhere         : UIButton!
    @IBOutlet weak var btnWhen          : UIButton!
    @IBOutlet weak var mapForLocation   : MKMapView!
    @IBOutlet weak var productName      : UILabel!
    @IBOutlet weak var properAddress    : UILabel!

    var detailsDicDataDetail = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailsDicDataDetail)

        btnWhere.layer.cornerRadius = 8.0
        
        btnWhen.layer.cornerRadius = 8.0
        let lati = String(describing: detailsDicDataDetail.object(forKey: "latitude") as! NSNumber)
        let long = String(describing: detailsDicDataDetail.object(forKey: "longitude") as! NSNumber)
        //let address = String(describing: detailsDicDataDetail.object(forKey: "address") as! NSNumber)

      //  btnWhen.setTitle(detailsDicDataDetail.object(forKey: "longitude") as! String, for: .normal)
        
        let myAttribute = [ NSAttributedStringKey.foregroundColor: UIColor.white ]
        let myAttrString = NSAttributedString(string: "Where:\n \(detailsDicDataDetail.object(forKey: "address") as! String)", attributes: myAttribute)
        btnWhere.setAttributedTitle(myAttrString, for: .normal)
        btnWhere.titleLabel?.textAlignment = .center
        self.openMapForPlace(Latitude: lati, Longitutde: long)
      //  self.openMapForPlace(Latitude: lati, Longitutde: long, address: address)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
  //  func openMapForPlace(Latitude: String, Longitutde: String, address: String)
    
    func openMapForPlace(Latitude: String, Longitutde: String)
    
    {
        
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
        objectAnnotation.title = (detailsDicDataDetail.object(forKey: "address") as! String)
        self.mapForLocation.addAnnotation(objectAnnotation)
    }
}
