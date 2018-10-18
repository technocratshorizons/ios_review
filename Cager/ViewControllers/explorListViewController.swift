//
//  explorListViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 01/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import Kingfisher

//enum MyTheme {
//    case light
//    case dark
//}

class explorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate,CalenderDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreArray.count
     //   return 5

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore1Cell") as! explore1Cell
        
        let  titleEvent = (cell.viewWithTag(1) as! UILabel)
     //   let  mobileNumber = (cell.viewWithTag(5) as! UILabel)
       let  price = (cell.viewWithTag(4) as! UILabel)
        let  openCloseTime = (cell.viewWithTag(3) as! UILabel)
        let  miles = (cell.viewWithTag(2) as! UILabel)
        let  imageSports = (cell.viewWithTag(5) as! UIImageView)
        let  exploreDetailPahe = (cell.viewWithTag(709) as! UIButton)
        let  exploreNowClick = (cell.viewWithTag(101) as! UIButton)
        
        
        exploreNowClick.layer.cornerRadius = 15
       // exploreNowClick.layer.borderWidth = 1.5
      //  exploreNowClick.layer.borderColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor


        exploreNowClick.addTarget(self, action: #selector(detailPage), for: .touchUpInside)
        exploreNowClick.accessibilityIdentifier = String(indexPath.row)

        exploreDetailPahe.addTarget(self, action: #selector(detailPage), for: .touchUpInside)
        exploreDetailPahe.accessibilityIdentifier = String(indexPath.row)
        let DicData = exploreArray.object(at: indexPath.row) as! NSDictionary
        
        let url =  URL(string:DicData.object(forKey: "image") as! String)
        
        imageSports.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)
        
        var milesData = String()
        if DicData.object(forKey: "miles") != nil{
             milesData = String(describing: DicData.object(forKey: "miles")!)
            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image = UIImage(named: "location")
            let newAttributedString = NSMutableAttributedString()
            
            
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let myString:NSMutableAttributedString = NSMutableAttributedString(string: milesData)
            let _:NSMutableAttributedString = NSMutableAttributedString(string: " mi")
            
            newAttributedString.append(attachmentString)
            newAttributedString.append(myString)
         //   newAttributedString.append(mi)
            
          //  miles.attributedText = newAttributedString

        }

        titleEvent.text = DicData.object(forKey: "facility_name") as? String
  //      mobileNumber.text = DicData.object(forKey: "number") as? String
        price.text = DicData.object(forKey: "prices") as? String
        
        if DicData.object(forKey: "openclose") != nil{
            openCloseTime.text = "\(DicData.object(forKey: "openclose") as! String)"
            print(DicData)
        }
        miles.text = "\(milesData)"
        
        miles.text = ""

    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _  = exploreArray.object(at: indexPath.row)
       // performSegue(withIdentifier: "exploreDetailPage", sender: dicData)
       // performSegue(withIdentifier: "showBookingWithFacilityDirect", sender: dicData)

        
    }
    
    @objc func detailPage(_ sender: UIButton)
    {
        // tblExplore1.reloadData()
        //  sender.backgroundColor = UIColor.yellow
        let selectedRow = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        let indPath = IndexPath(row: selectedRow, section: 0)
        print(indPath)
        let dicclickblock = exploreArray[indPath.row] as! NSDictionary
        performSegue(withIdentifier: "showFacilityList", sender: dicclickblock)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "exploreDetailPage" {
            if let nextVC = segue.destination as? explore2VC {
                nextVC.detailsDicData = (sender as! NSDictionary)
            }
        }
        else if segue.identifier == "showFacilityList" {
            if let nextVC = segue.destination as? facilityprofileViewController {
                nextVC.detailsDicData = (sender as! NSDictionary)
            }
        }
        else if segue.identifier == "showFacilityList" {
            if let nextVC = segue.destination as? bookingViewController {
                nextVC.DicDAtaForBooking = (sender as! NSDictionary)
                nextVC.segueIdentifier = segue.identifier!
            }
        }
        
    }
    
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    var exploreArray = NSMutableArray()
    @IBOutlet weak var mapForLocation: MKMapView!
    var segueIdentifier = String()
    var listType = String()

    @IBOutlet weak var backButtn: UIButton!
    @IBOutlet weak var weekdays: UIButton!
    @IBOutlet weak var weekly: UIButton!
    
    @IBOutlet weak var hotDealsOff: UILabel!
    @IBOutlet weak var calenderLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!

    @IBOutlet weak var exploreTbl: UITableView!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateview: UIView!
    let dateFormatter = DateFormatter()
    var arrtayMonth = [String]()
    var arrtayWeek = [String]()

    var dateOfirthParameter = String()
    @IBOutlet var DatePickerDateView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    
    @IBOutlet weak var noRecordFound: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        noRecordFound.center = self.view.center
        hotDealsOff.layer.cornerRadius = 5.0
        calenderLabel.layer.cornerRadius = 5.0
        searchLabel.layer.cornerRadius = 5.0
        
        
        arrtayMonth = ["Jan","Feb","Mar","Apr","may","June","Jul","Aug","Sep","Oct","Nov","Dec"]
        arrtayWeek = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        let datePick = UIDatePicker()
        datePicker.minimumDate = datePick.date

                        let attachment:NSTextAttachment = NSTextAttachment()
                        attachment.image = UIImage(named: "hotDealsWhite")
                        let newAttributedString = NSMutableAttributedString()
                        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
                        let myString:NSMutableAttributedString = NSMutableAttributedString(string: "Off")
                        let myStringNew:NSMutableAttributedString = NSMutableAttributedString(string: "  ")
                        newAttributedString.append(attachmentString)
                        newAttributedString.append(myStringNew)
                        newAttributedString.append(myString)
                        hotDealsOff.attributedText = newAttributedString //YelloHotDeals   // hotDealsWhite
        
            datePickerMethod(datePicker)
        buttonDoneClick(weekly)

        
        let attachmentTwo:NSTextAttachment = NSTextAttachment()
        attachmentTwo.image = UIImage(named: "whiteSearch")
        let newAttributedStringTwo = NSMutableAttributedString()
        let AttributedStringTwo:NSAttributedString = NSAttributedString(attachment: attachmentTwo)
        let myStringTwo:NSMutableAttributedString = NSMutableAttributedString(string: "Search")
        newAttributedStringTwo.append(AttributedStringTwo)
        newAttributedStringTwo.append(myStringNew)
        newAttributedStringTwo.append(myStringTwo)
        searchLabel.attributedText = newAttributedStringTwo  //whiteSearch
        
        
        
        
        listType = "weekdays"
        if segueIdentifier == "manuallyExplore" || segueIdentifier == "showExplore" 
        {
            backButtn.isHidden = false
        }
//        weekdays.backgroundColor = UIColor.lightGray
        weekdays.titleLabel?.textColor = UIColor.white
        
        
     //   weekly.backgroundColor = UIColor.clear
        weekly.titleLabel?.textColor = UIColor.blue
    //   getexploreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getexploreData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weekDays(_ sender: UIButton) {
        dateview.isHidden = true
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.synchronize()
        if sender.tag == 101
        {
            sender.tag = 102
            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image = UIImage(named: "YelloHotDeals")
            let newAttributedString = NSMutableAttributedString()
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let myString:NSMutableAttributedString = NSMutableAttributedString(string: "On")
            let myStringNew:NSMutableAttributedString = NSMutableAttributedString(string: "  ")
            newAttributedString.append(attachmentString)
            newAttributedString.append(myStringNew)
            newAttributedString.append(myString)
            hotDealsOff.attributedText = newAttributedString //YelloHotDeals   // hotDealsWhite
            listType = "weekly"

        }
        else {
            sender.tag = 101

            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image = UIImage(named: "hotDealsWhite")
            let newAttributedString = NSMutableAttributedString()
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let myString:NSMutableAttributedString = NSMutableAttributedString(string: "Off")
            let myStringNew:NSMutableAttributedString = NSMutableAttributedString(string: "  ")
            newAttributedString.append(attachmentString)
            newAttributedString.append(myStringNew)
            newAttributedString.append(myString)
            hotDealsOff.attributedText = newAttributedString //redHotDeals   // hotDealsWhite
            listType = "weekdays"

        }
        exploreArray.removeAllObjects()
      //  weekdays.backgroundColor = UIColor.lightGray
        weekdays.titleLabel?.textColor = UIColor.white
        
       // weekly.backgroundColor = UIColor.clear
        weekly.titleLabel?.textColor = UIColor.blue
        getexploreData()
        
    }
    
    @IBAction func weekly(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.synchronize()
        dateview.isHidden = true
        exploreArray.removeAllObjects()

     //   weekdays.backgroundColor = UIColor.clear
        weekdays.titleLabel?.textColor = UIColor.blue

        
     //   weekly.backgroundColor = UIColor.lightGray
        weekly.titleLabel?.textColor = UIColor.blue
        listType = "weekly"
        getexploreData()
        
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getexploreData() {
        dateview.isHidden = true
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let _: String? = UserDefaults.standard.string(forKey: "user_id")
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
       
        var params = [String : Any]()
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


        if  UserDefaults.standard.object(forKey: "userData") != nil
        {
            listType = ""
            let stracesstoken = UserDefaults.standard.object(forKey: "userData") as!NSDictionary
            
            var dsplayString = String()
            var priceStringHigh = String()
            var priceStringLow = String()
            var distanceStringHigh = String()
            var distanceStringLow = String()
            var timeString = String()
            var facilitListId = String()

            if stracesstoken.object(forKey: "display") != nil
            {
                dsplayString = stracesstoken.object(forKey: "display") as! String
            }
            if stracesstoken.object(forKey: "price") != nil
            {
                var priceSet = (stracesstoken.object(forKey: "price") as! String).components(separatedBy: "-")
                if priceSet.count == 1
                {
                    priceStringLow = priceSet[0]
                }
                else
                {
                    priceStringLow = priceSet[0]
                    priceStringHigh = priceSet[1]
                }
                

            }
            if stracesstoken.object(forKey: "distance") != nil
            {
                var distacnceTag = (stracesstoken.object(forKey: "distance") as! String).components(separatedBy: "-")
                if distacnceTag.count == 1
                {
                    distanceStringLow = distacnceTag[0]

                }
                else{
                distanceStringLow = distacnceTag[0]
                distanceStringHigh = distacnceTag[1]
                }
            }
            if stracesstoken.object(forKey: "time") != nil
            {
                timeString = stracesstoken.object(forKey: "time") as! String
            }
            if stracesstoken.object(forKey: "facilitId") != nil
            {
                facilitListId = stracesstoken.object(forKey: "facilitId") as! String

            }
            params =  ["action":Cager.User.explore_list,"ulat":lat,"ulong":long,"dealstype":"hotdeal","propricelow":priceStringLow,"propricehighe":priceStringHigh,"disthigh":distanceStringHigh,"distlow":distanceStringLow,"timesession":timeString,"faciid": facilitListId]as [String : Any]
//            "faciid":"8",
            
        }
        
        if listType == "weekdays"
        {
               params =  ["action":Cager.User.explore_list,"ulat":lat,"ulong":long,"dealstype":"All","datestring":dateOfirthParameter]as [String : Any]
            
        }
        else if listType == "weekly"
        {
         params =  ["action":Cager.User.explore_list,"ulat":lat,"ulong":long,"dealstype":"hotdeal","datestring":dateOfirthParameter]as [String : Any]
        }
        
//        dateOfirthParameter
        print(params)
        Alamofire.request( urlRequest, method: .post, parameters:params , encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                
                if response.result.isSuccess
                {
                    self.exploreArray.removeAllObjects()
                    let ShortDic = response.result.value as! NSDictionary
                    let item2 = ShortDic.value(forKey: "success") as! NSNumber
                    
                    if item2 == 1
                    {
                        self.noRecordFound.isHidden = true
                        self.exploreTbl.isHidden = false
                        UserDefaults.standard.removeObject(forKey: "userData")
                        UserDefaults.standard.synchronize()
                        print(ShortDic)
                        let dicData = ShortDic.value(forKey: "data") as! NSArray
                        for checkData in dicData
                        {
                            self.exploreArray.addObjects(from: [checkData])
                        }
                        print(self.exploreArray.count)
//                        let latlong = ShortDic.value(forKey: "latlong") as! NSArray!
//                        
//                        for checkData_latlong in latlong!
//                        {
//                            // self.hotDealslatlongArray.addObjects(from: [checkData_latlong])
//                            let lati = String(describing: (checkData_latlong as AnyObject).object(forKey: "latitude") as! NSNumber)
//                            let long = String(describing: (checkData_latlong as AnyObject).object(forKey: "longitude") as! NSNumber)
//                            
//                            self.openMapForPlace(Latitude: lati, Longitutde: long)
//                            
//                        }
                        
                        print(self.exploreArray.count)
                        self.exploreTbl.reloadData()
                        
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                    }
                    else
                    {
                        self.noRecordFound.isHidden = false

                        self.exploreTbl.isHidden = true
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
    
    
    @IBAction func buttoncancelClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        dateview.isHidden = true
        // bottomContraints.constant = -173
    }
    
    @IBAction func buttonDoneClick(_ sender: UIButton)
    {
        weekdays.tag = 101
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "hotDealsWhite")
        let newAttributedString = NSMutableAttributedString()
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: "Off")
        let myStringNew:NSMutableAttributedString = NSMutableAttributedString(string: "  ")
        newAttributedString.append(attachmentString)
        newAttributedString.append(myStringNew)
        newAttributedString.append(myString)
        hotDealsOff.attributedText = newAttributedString //YelloHotDeals   // hotDealsWhite
        
        
        // bottomContraints.constant = -173
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let fullName: String = dateFormatter.string(from: datePicker.date)
        dateOfirthParameter =  dateFormatter.string(from: datePicker.date)

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
        let _: String = fullNameArr[0]
        let attachmentOne:NSTextAttachment = NSTextAttachment()
        attachmentOne.image = UIImage(named: "whiteCalender")
        let newAttributedStringOne = NSMutableAttributedString()
        let AttributedStringOne:NSAttributedString = NSAttributedString(attachment: attachmentOne)
        let DayString:NSMutableAttributedString = NSMutableAttributedString(string: Day)
        let CommaString:NSMutableAttributedString = NSMutableAttributedString(string: ",")
        let monthString:NSMutableAttributedString = NSMutableAttributedString(string: month)
        let dateString:NSMutableAttributedString = NSMutableAttributedString(string: date)

        newAttributedStringOne.append(AttributedStringOne)
        newAttributedStringOne.append(myStringNew)
        newAttributedStringOne.append(DayString)
        newAttributedStringOne.append(CommaString)
        newAttributedStringOne.append(myStringNew)
        newAttributedStringOne.append(monthString)
        newAttributedStringOne.append(myStringNew)
        newAttributedStringOne.append(dateString)

        calenderLabel.attributedText = newAttributedStringOne //whiteCalender
        
        
       // calenderLabel.text = "\(Day) ,\(month) \(date)"
        self.view.endEditing(false)
        dateview.isHidden = false
        
  

        listType = "weekdays"

        getexploreData()
    }
    
    @IBAction func buttonDateClick(_ sender: UIButton)
    {
        //MARK:- new editing
//        self.view.endEditing(true)
//        //  bottomContraints.constant = 10
//        dateview.frame = CGRect(x:0, y:self.view.frame.size.height - 175, width: self.view.frame.size.width, height:175)
//        dateview.isHidden = false
        listType = "weekdays"

        weekdays.tag = 101
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "hotDealsWhite")
        let newAttributedString = NSMutableAttributedString()
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: "Off")
        let myStringNew:NSMutableAttributedString = NSMutableAttributedString(string: "  ")
        newAttributedString.append(attachmentString)
        newAttributedString.append(myStringNew)
        newAttributedString.append(myString)
        hotDealsOff.attributedText = newAttributedString //YelloHotDeals   // hotDealsWhite
        
        
        
        self.title = "select date"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        calenderView.isHidden = false
        view.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive=true
        calenderView.backgroundColor = UIColor.darkGray
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarBtnAction))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))

    }
    
    @IBAction func datePickerMethod(_ sender: UIDatePicker)
    {
        self.view.endEditing(true)
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let somedateString = dateFormatter.string(from: sender.date)
        dateOfirthParameter = somedateString
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
            dateOfirthParameter = date

            dateFormatter.dateFormat = "YYYY-MM-dd"
            
            
            
            let fullNameArr = date.components(separatedBy: "-")
            var Day = String()
            let dateSelect: String = fullNameArr[2]
            var month: String = fullNameArr[1]
            let months:Int = (month as NSString).integerValue
            month = arrtayMonth[months]
            
            
            let weekDats = dateFormatter.date(from: date)
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: weekDats!)
            Day = arrtayWeek[weekDay]
            print(weekDay)
            print(month)
            let year: String = fullNameArr[0]
            
            calenderLabel.text = "\(Day), \(month) \(dateSelect), \(year)"
            self.view.endEditing(true)
            dateview.isHidden = true
            calenderView.isHidden = true
            
            getexploreData()
            
            
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

