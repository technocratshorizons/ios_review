 
import UIKit
 import Kingfisher
 import MapKit

class facilityprofileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate {

    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var mapForLocation: MKMapView!

 
    @IBOutlet weak var BtnInfo: UIButton!
    @IBOutlet weak var Btnbook: UIButton!
    @IBOutlet weak var BtnMap: UIButton!
    @IBOutlet weak var tbl: UITableView!
    var detailsDicData = NSDictionary()
    
    var varieantArray = NSMutableArray()
    @IBOutlet weak var addressFacility: UILabel!
    @IBOutlet weak var facilityTiming: UILabel!
    @IBOutlet weak var discriptionDetail: UILabel!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(detailsDicData)
        let dicData = detailsDicData.value(forKey: "variants") as! NSArray
        for checkData in dicData
        {
            self.varieantArray.addObjects(from: [checkData])
        }
        facilityName.text      = detailsDicData.object(forKey: "facility_name")     as? String
        addressFacility.text   = detailsDicData.object(forKey: "address")           as? String
        facilityTiming.text    = detailsDicData.object(forKey: "openclose")         as? String
        discriptionDetail.text = detailsDicData.object(forKey: "description")       as? String
        openMapForPlace(Latitude: (detailsDicData.object(forKey: "lat")             as? String)!, Longitutde: (detailsDicData.object(forKey: "long") as? String)!)
        let url                =  URL(string:detailsDicData.object(forKey: "image") as! String)
        
        backgroundImage.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)

        Btnbook.backgroundColor  = UIColor.init(red: 0/255.0, green: 103/255.0, blue: 138/255.0, alpha: 1)
        BtnInfo.backgroundColor  = UIColor.clear
        BtnMap.backgroundColor   = UIColor.clear


       self.viewDetails.isHidden = true
       self.viewMap.isHidden     = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return exploreArray.count
        return self.varieantArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell            = tableView.dequeueReusableCell(withIdentifier: "detailCell")
        let timeLAbel       = cell?.viewWithTag(112) as! UILabel
        let titleLabelCell  = cell?.viewWithTag(2)   as! UILabel
        let priceLabel      = cell?.viewWithTag(3)   as! UILabel
        let btnBookNow      = cell?.viewWithTag(4)   as! UIButton
        let addressFacility = cell?.viewWithTag(5)   as! UILabel

        btnBookNow.layer.cornerRadius = 5.0
        
        btnBookNow.addTarget(self, action: #selector(detailPage), for: .touchUpInside)
        btnBookNow.accessibilityIdentifier = String(indexPath.row)
        
        let DicData = varieantArray.object(at: indexPath.row) as! NSDictionary
        
        print(DicData)
        let opningTime          = (DicData.object(forKey: "option2") as! String).components(separatedBy: "-")
        print(opningTime)
        timeLAbel.text          = opningTime[0]
        priceLabel.text         = "$\(DicData.object(forKey: "price") as! String)"
        titleLabelCell.text     = "\(DicData.object(forKey: "product_name") as! String)"
        addressFacility.text    = "\(DicData.object(forKey: "address") as! String)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dicData  = exploreArray.object(at: indexPath.row)
//        performSegue(withIdentifier: "exploreDetailPage", sender: dicData)
    }
    
    @objc func detailPage(_ sender: UIButton)
    {
       // tblExplore1.reloadData()
        //  sender.backgroundColor = UIColor.yellow
        let selectedRow     = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        let indPath         = IndexPath(row: selectedRow, section: 0)
        print(indPath)
        let dicclickblock   = varieantArray[indPath.row] as! NSDictionary
        performSegue(withIdentifier: "varientBookingDetail", sender: dicclickblock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "exploreDetailPage" {
            if let nextVC = segue.destination as? explore2VC {
                nextVC.detailsDicData = (sender as! NSDictionary)
            }
        }
        else  if segue.identifier == "varientBookingDetail" {
            if let nextVC = segue.destination as? bookingViewController {
                nextVC.DicDAtaForBooking    = (sender as! NSDictionary)
                nextVC.segueIdentifier      = segue.identifier!
                nextVC.productNAmeString    = facilityName.text!

                

            }
        }
        
    }
    @IBAction func btnActionBook(_ sender: Any) {
        self.viewDetails.isHidden   = true
        self.tbl.isHidden           = false
        self.viewMap.isHidden       = true

        Btnbook.backgroundColor = UIColor.init(red: 0/255.0, green: 103/255.0, blue: 138/255.0, alpha: 1)
        Btnbook.backgroundColor = UIColor.clear
        BtnMap.backgroundColor  = UIColor.clear
     }
    
    @IBAction func btnActionDetails(_ sender: Any) {
         self.viewMap.isHidden      = true
        self.viewDetails.isHidden   = false
         self.tbl.isHidden          = true
        BtnInfo.backgroundColor     = UIColor.init(red: 0/255.0, green: 103/255.0, blue: 138/255.0, alpha: 1)
        Btnbook.backgroundColor     = UIColor.clear
        BtnMap.backgroundColor      = UIColor.clear
  }
    
    @IBAction func btnActionMap(_ sender: Any) {
        self.viewDetails.isHidden   = true
        self.tbl.isHidden           = true
         self.viewMap.isHidden      = false
        BtnMap.backgroundColor      = UIColor.init(red: 0/255.0, green: 103/255.0, blue: 138/255.0, alpha: 1)
        Btnbook.backgroundColor     = UIColor.clear
        BtnInfo.backgroundColor     = UIColor.clear
  }
    @IBAction func justBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func openMapForPlace(Latitude: String, Longitutde: String) {
        
        let latitude: CLLocationDegrees     = 37.2
        let longitude: CLLocationDegrees    = 22.9
        
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
