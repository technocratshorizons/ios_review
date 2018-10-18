//
//  mapScreenVC.swift
//  Cager
//
//  Created by mac on 19/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import Kingfisher

enum MyTheme {
    case light
    case dark
}
class mapScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate,CalenderDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotDealsArray.count
    //    return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore1Cell") as! explore1Cell
        
        let  productName    = (cell.viewWithTag(1)   as! UILabel)
        let  facilityName   = (cell.viewWithTag(123) as! UILabel)
        let  addressLabel   = (cell.viewWithTag(2)   as! UILabel)
        let  priceLabel     = (cell.viewWithTag(3)   as! UILabel)
        let  selectBtn      = (cell.viewWithTag(4)   as! UIButton)
        let  imageSports    = (cell.viewWithTag(5)   as! UIImageView)
        let  timeLabel      = (cell.viewWithTag(10)  as! UILabel)

        selectBtn.addTarget(self, action: #selector(detailPage), for: .touchUpInside)


        selectBtn.accessibilityIdentifier = String(indexPath.row)

        selectBtn.layer.cornerRadius = 15
     //   selectBtn.layer.borderWidth = 1.5
      //  selectBtn.layer.borderColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor


        let DicData = hotDealsArray.object(at: indexPath.row) as! NSDictionary
        let varientArrray = DicData.object(forKey: "variants") as! NSArray
        var varientDic = NSDictionary()
        for checkData in varientArrray
        {
            varientDic = checkData as! NSDictionary
        }
       
        

        print(DicData)

        let url =  URL(string:DicData.object(forKey: "image") as! String)

        imageSports.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)

        if DicData.object(forKey: "address") != nil{
            let address = String(describing: DicData.object(forKey: "address")!)
             addressLabel.text = "\(address)"
        }

        if varientDic.object(forKey: "option2") != nil {
            timeLabel.text = varientDic.object(forKey: "option2") as? String
        } else {
            timeLabel.text = DicData.object(forKey: "openclose") as? String
        }

        facilityName.text = DicData.object(forKey: "facility_name") as? String
        productName.text  = varientDic.object(forKey: "product_name") as? String

        priceLabel.text   = "$\(varientDic.object(forKey: "price") as! String)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //  let dicData  = hotDealsArray.object(at: indexPath.row)
       // performSegue(withIdentifier: "dealsDetail", sender: self)
        
    }
    
    @objc func detailPage(_ sender: UIButton)
    {
        tblExplore1.reloadData()
      //  sender.backgroundColor = UIColor.yellow
        let selectedRow = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        let indPath = IndexPath(row: selectedRow, section: 0)
        print(indPath)
        
        let dicclickblock = hotDealsArray[indPath.row] as! NSDictionary
        
        print(dicclickblock)

        performSegue(withIdentifier: "dealsDetail", sender: dicclickblock)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tblExplore1.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "dealsDetail" {
            if let nextVC = segue.destination as? bookingViewController {
                nextVC.DicDAtaForBooking = (sender as! NSDictionary)
                nextVC.segueIdentifier = segue.identifier!
            }
        }
    }
    
    let app_delegate            = UIApplication.shared.delegate as! AppDelegate
    var hotDealsArray           = NSMutableArray()
    var hotDealslatlongArray    = NSMutableArray()
    @IBOutlet weak var dateFilter    : UIButton!
    @IBOutlet weak var distanceFilter: UIButton!
    @IBOutlet weak var priceFilter   : UIButton!
    @IBOutlet weak var backButtn     : UIButton!
    @IBOutlet weak var distacne      : UILabel!
    @IBOutlet weak var dateLabel     : UILabel!
    @IBOutlet weak var priceLabel    : UILabel!
    var segueIdentifier         = String()
    @IBOutlet weak var mapForLocation: MKMapView!
    @IBOutlet weak var tblExplore1   : UITableView!
    
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateview: UIView!
    let dateFormatter = DateFormatter()
    var arrtayMonth = [String]()
    var arrtayWeek = [String]()
    var dateOfirthParameter = String()
    @IBOutlet var DatePickerDateView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet var datePickerOpen: UIButton!

    @IBOutlet var dateLabelShow: UILabel!
    @IBOutlet weak var nReconrdFound: UILabel!

  //  var calenderView = CalenderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        arrtayMonth = ["January","February","March","April","May","June","July","August","September","Octobre","November","December"]
        arrtayWeek = ["Sunday","Monday","Tuesday","Wednesday","Thrusday","Friday","Satarday"]
        
        nReconrdFound.center    = self.view.center
        let datePick            = UIDatePicker()
        datePicker.minimumDate  = datePick.date
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image                = UIImage(named: "list-button")
        
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let newAttributedString                 = NSMutableAttributedString()
        
        let myString:NSMutableAttributedString  = NSMutableAttributedString(string: " View Distance")
        newAttributedString.append(attachmentString)
        newAttributedString.append(myString)
        distacne.attributedText                 = newAttributedString
        
        
        let attachmentDate:NSTextAttachment = NSTextAttachment()
        attachmentDate.image                = UIImage(named: "Calendar")
        
        let attachmentStringDate:NSAttributedString = NSAttributedString(attachment: attachmentDate)
        let newAttributedStringDate                 = NSMutableAttributedString()
        
        let myStringDate:NSMutableAttributedString  = NSMutableAttributedString(string: " View Date")
        newAttributedStringDate.append(attachmentStringDate)
        newAttributedStringDate.append(myStringDate)
        dateLabel.attributedText                    = newAttributedStringDate
        
        
        let attachmentPrice:NSTextAttachment    = NSTextAttachment()
        attachmentPrice.image                   = UIImage(named: "Sort-up")
        
        let attachmentStringPrice:NSAttributedString    = NSAttributedString(attachment: attachmentPrice)
        let newAttributedStringPrice                    = NSMutableAttributedString()
        
        let myStringPrice:NSMutableAttributedString = NSMutableAttributedString(string: " Sort Price")
        newAttributedStringPrice.append(attachmentStringPrice)
        newAttributedStringPrice.append(myStringPrice)
        priceLabel.attributedText                   = newAttributedStringPrice
        
        
        print(segueIdentifier)
        if segueIdentifier == "manuallyHotdeals" || segueIdentifier == "showHotDEalsPae" || segueIdentifier == "showHotDealsRegardingThisProduct"
        {
            backButtn.isHidden = false
        }
        dateFilter.layer.cornerRadius = 30
        dateFilter.layer.borderWidth  = 1.5
        dateFilter.layer.borderColor  = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor
        
        distanceFilter.layer.cornerRadius = 30
        distanceFilter.layer.borderWidth  = 1.5
        distanceFilter.layer.borderColor  = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor
        
        priceFilter.layer.cornerRadius = 30
        priceFilter.layer.borderWidth  = 1.5
        priceFilter.layer.borderColor  = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor
        datePickerMethod(datePicker)
        buttonDoneClick(datePickerOpen)
        getHoteDealsData(filterType: "")


    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func filterChangeAccording(_ sender: UIButton) {
        if sender.tag == 101
        {
            self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "date_desc")
            
            sender.tag = 201
        }
        else if sender.tag == 102
        {
             self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "price_desc")
            sender.tag = 202

        }
        else if sender.tag == 103
        {
             self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "distance_desc")
            sender.tag = 203

        }
        else if sender.tag == 201
        {
            self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "date_asc")
            
            sender.tag = 101
        }
        else if sender.tag == 202
        {
            self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "price_asc")
            sender.tag = 102
            
        }
        else if sender.tag == 203
        {
            self.hotDealsArray.removeAllObjects()
            getHoteDealsData(filterType: "distance_asc")
            sender.tag = 103
            
        }
        tblExplore1.reloadData()
    }
    

    func getHoteDealsData(filterType: String) {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let _: String? = UserDefaults.standard.string(forKey: "user_id")
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        
        var lat = String()
        var long = String()
        
        if UserDefaults.standard.object(forKey: "applatitude") != nil
        {
            lat = UserDefaults.standard.object(forKey: "applatitude") as! String
            long = UserDefaults.standard.object(forKey: "applongitude") as! String
            
        }
        else
        {
            lat = "26.9124"
            long = "75.7873"
        }
        let params =  ["action":Cager.User.explore_list,"ulat":lat,"ulong":long,"filtertype":filterType,"deals_type":"hotdeal","datestring":dateOfirthParameter]as [String : Any]
//        dateOfirthParameter
        print(params)
        Alamofire.request( urlRequest, method: .post, parameters:params , encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.hotDealsArray.removeAllObjects()
                if response.result.isSuccess
                {
                    
                    let ShortDic = response.result.value as! NSDictionary
                    let item2 = ShortDic.value(forKey: "success") as! NSNumber
                    
                    if item2 == 1
                    {
                        
                        print(ShortDic)
                        let dicData = ShortDic.value(forKey: "data") as! NSArray
                        print(dicData.count as Any)
                        for checkData in dicData
                            {
                                self.hotDealsArray.addObjects(from: [checkData])
                        }
//                        let latlong = ShortDic.value(forKey: "latlong") as! NSArray!
//
//                        for checkData_latlong in latlong!
//                        {
//                           // self.hotDealslatlongArray.addObjects(from: [checkData_latlong])
//                            let lati = String(describing: (checkData_latlong as AnyObject).object(forKey: "latitude") as! NSNumber)
//                            let long = String(describing: (checkData_latlong as AnyObject).object(forKey: "longitude") as! NSNumber)
//
//                         //  self.openMapForPlace(Latitude: lati, Longitutde: long)
//
//                        }
                        self.nReconrdFound.isHidden = true
                        self.tblExplore1.isHidden = false
                        print(self.hotDealsArray.count)
                        self.tblExplore1.reloadData()
                       
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                    }
                    else
                        
                    {
                        self.tblExplore1.reloadData()
                        self.nReconrdFound.isHidden = false
                        self.tblExplore1.isHidden = true
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
    @IBAction func buttoncancelClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        dateview.isHidden = true
        // bottomContraints.constant = -173
    }
    
    @IBAction func buttonDoneClick(_ sender: UIButton)
    {
        
        // bottomContraints.constant = -173
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let fullName: String = dateFormatter.string(from: datePicker.date)
        let fullNameArr = fullName.components(separatedBy: "-")
        var Day = String()
        let date: String = fullNameArr[2]
        var month: String = fullNameArr[1]
        let months:Int = (month as NSString).integerValue
        month = arrtayMonth[months - 1]
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: datePicker.date)
        Day = arrtayWeek[weekDay - 1]
        
        print(weekDay)
        print(month)
        let year: String = fullNameArr[0]
        
         dateLabelShow.text = "\(Day), \(month) \(date), \(year)"
        self.view.endEditing(true)
        dateview.isHidden = true
        // getexploreData()
    }
    
    @IBAction func buttonDateClick(_ sender: UIButton)
    {
        
        //MARK:- new editing
//        self.view.endEditing(true)
//        //  bottomContraints.constant = 10
//        dateview.frame = CGRect(x:0, y:self.view.frame.size.height - 175, width: self.view.frame.size.width, height:175)
//        dateview.isHidden = false
        
        
        self.title = "select date"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor   = Style.bgColor
        calenderView.isHidden       = false
        view.addSubview(calenderView)
        calenderView.delegate       = self
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive       =   true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive    =   true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive      =   true
        calenderView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive  =   true
        calenderView.backgroundColor = UIColor.darkGray
        
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarBtnAction))
        
        self.navigationItem.leftBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
        
    }
    
    @IBAction func datePickerMethod(_ sender: UIDatePicker)
    {
        self.view.endEditing(true)
        dateFormatter.dateFormat    = "YYYY-MM-dd"
        let somedateString          = dateFormatter.string(from: sender.date)
        dateOfirthParameter         = somedateString
        //lbldate.text = somedateString
        print(somedateString)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        print(123)
    }
    
    @objc func dismissVC(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    lazy var  calenderView: CalenderView = {
        
        let calenderView = CalenderView(theme: MyTheme.dark)
        calenderView.translatesAutoresizingMaskIntoConstraints=false
        return calenderView
    }()
    
    func didTapDate(date: String, available: Bool) {
        if available == true {
            print(date)
            dateOfirthParameter         = date
            

            dateFormatter.dateFormat    = "YYYY-MM-dd"

     
            
            let fullNameArr         = date.components(separatedBy: "-")
            var Day                 = String()
            let dateSelect: String  = fullNameArr[2]
            var month: String       = fullNameArr[1]
            let months:Int          = (month as NSString).integerValue
            month                   = arrtayMonth[months]
            
           
            let weekDats    = dateFormatter.date(from: date)
            let myCalendar  = Calendar(identifier: .gregorian)
            let weekDay     = myCalendar.component(.weekday, from: weekDats!)
            Day             = arrtayWeek[weekDay]
            print(weekDay)
            print(month)
            let year: String = fullNameArr[0]
            
            dateLabelShow.text      = "\(Day), \(month) \(dateSelect), \(year)"
            self.view.endEditing(true)
            dateview.isHidden       = true
            calenderView.isHidden   = true
            
            getHoteDealsData(filterType: "")
            
            
        } else {
            showAlert()
        }
    }
    
    
    
    fileprivate func showAlert(){
        let alert = UIAlertController(title: "Unavailable", message: "This slot is already booked.\nPlease choose another date.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
