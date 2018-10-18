//
//  bookingViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 27/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire

class bookingViewController: UIViewController {
    @IBOutlet weak var bookNow: UIButton!
    @IBOutlet weak var saveForLater: UIButton!
    @IBOutlet weak var timingBtn: UIButton!
    @IBOutlet weak var hotDealsImage: UIImageView!

    @IBOutlet weak var vendroeLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var addresssLabel: UILabel!
    @IBOutlet weak var addresssLabelTwo: UILabel!

    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    var DicDAtaForBooking = NSDictionary()
    var productDictionary = NSDictionary()
    
    var segueIdentifier = String()


    var productNAmeString = String()
    var timeLabel = String()
    
    var seconds = 120 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    var arrtayMonth = [String]()
    var arrtayWeek = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        arrtayMonth = ["january","february","march","april","may","june","july","august","september","octobre","november","december"]
        arrtayWeek = ["Sunday","Monday","Tuesday","Wednesday","Thrusday","Friday","Satarday"]

        if segueIdentifier == "dealsDetail" || segueIdentifier == "showBookingWithFacilityDirect"
        {
            //hotDealsImage.isHidden = false
            print(DicDAtaForBooking)
            
            let varientArrray = DicDAtaForBooking.object(forKey: "variants") as! NSArray
            var dicData = NSDictionary()
            for checkData in varientArrray
            {
                dicData = checkData as! NSDictionary
            }
            productLabel.text = DicDAtaForBooking.object(forKey: "facility_name") as? String
            vendroeLabel.text = dicData.object(forKey: "product_name") as? String
            addresssLabelTwo.text = DicDAtaForBooking.object(forKey: "address") as? String


           // vendroeLabel.text = DicDAtaForBooking.object(forKey: "title") as? String
            if DicDAtaForBooking.object(forKey: "date") != nil{
                DateLabel.text = DicDAtaForBooking.object(forKey: "date") as? String
            }
            
//            if DicDAtaForBooking.object(forKey: "hot_deals") as! Bool == true
//            {
//                let textShow = " Hote Deals $\(String(describing: DicDAtaForBooking.object(forKey: "price")!)) Per Hour"
//
//
//                let attachment:NSTextAttachment = NSTextAttachment()
//                attachment.image = UIImage(named: "fire")
//                let newAttributedString = NSMutableAttributedString()
//
//
//                let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
//                let myString:NSMutableAttributedString = NSMutableAttributedString(string: textShow)
//
//                newAttributedString.append(attachmentString)
//                newAttributedString.append(myString)
//
//                priceLAbel.attributedText = newAttributedString
//            }
//            else
//            {
                priceLAbel.text = "$\(String(describing: dicData.object(forKey: "price")!))"
 //           }
            
            addresssLabel.text = DicDAtaForBooking.object(forKey: "address") as? String
            
            if DicDAtaForBooking.object(forKey: "openclose") != nil
            {
                
                print(DicDAtaForBooking.object(forKey: "option2") ?? String())
                
                 timingBtn.setTitle("\(DicDAtaForBooking.object(forKey: "option2") ?? String())", for: .normal)
            }
          

        }
        else if segueIdentifier == "varientBookingDetail"
        {
            print(DicDAtaForBooking)
            //vendroeLabel.text = DicDAtaForBooking.object(forKey: "product_name") as? String
            productLabel.text = productNAmeString
            let dateStringMake =  ((DicDAtaForBooking.object(forKey: "date") ?? String()) as AnyObject).components(separatedBy: "-")
             
            if dateStringMake.count<0{
                 let monthInt = Int(dateStringMake[1])
                  let month = arrtayMonth[monthInt! - 1]
                
                DateLabel.text = "\(month) \(dateStringMake[2]) , \(dateStringMake[0])"

            }else{
//                monthInt=0
//                month=0
                
                DateLabel.text = ""

            }
            
//            let monthInt = Int(dateStringMake[1])
//            let month = arrtayMonth[monthInt! - 1]
       //     let dayInt = Int(dateStringMake[2])
//let day = arrtayWeek[dayInt! - 1]

            

                priceLAbel.text = "$\(DicDAtaForBooking.object(forKey: "price")!)"

            
            addresssLabel.text = DicDAtaForBooking.object(forKey: "address") as? String
            timingBtn.setTitle(timeLabel, for: .normal)
            addresssLabelTwo.text = DicDAtaForBooking.object(forKey: "address") as? String

        }
        else
        {
            vendroeLabel.text = DicDAtaForBooking.object(forKey: "vendor") as? String
            productLabel.text = productNAmeString
            DateLabel.text = productDictionary.object(forKey: "date") as? String
            if DicDAtaForBooking.object(forKey: "hot_deals") as! Bool == true
            {
                priceLAbel.text = " Hote Deals $\(String(describing: productDictionary.object(forKey: "prices")!)) Per Hour"
            }
            else
            {
                priceLAbel.text = "$\(String(describing: productDictionary.object(forKey: "pricea")!)) Per Hour"
            }
            
            addresssLabel.text = DicDAtaForBooking.object(forKey: "address") as? String
            timingBtn.setTitle(timeLabel, for: .normal)
        }
     

        
      
        
        timingBtn.layer.cornerRadius = 10
        timingBtn.layer.borderColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor

        
        
        bookNow.layer.cornerRadius = 24
        bookNow.layer.borderColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor

        saveForLater.layer.cornerRadius = 24
        saveForLater.layer.borderColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1).cgColor
        runTimer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveForLater(_ sender: Any) {
       saveForLat()
    }
    func saveForLat() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let productId = String(describing: productDictionary.object(forKey: "product_id")!)
        let variant_id = String(describing: productDictionary.object(forKey: "id")!)
        let price = productDictionary.object(forKey: "price") as? String
        let vendor = DicDAtaForBooking.object(forKey: "vendor") as? String

        
        let params =  ["customer_id":userId!,"action":Cager.User.save_for_later,"price":price!,"product_name":productNAmeString,"quantity":"1","vendor_name":vendor!,"product_id":productId,"variant_id":variant_id]as [String : Any]
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
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
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
    
    
    @IBAction func orderRightNow(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "user_id") != nil
        {
            self.performSegue(withIdentifier: "orderConfirmatoinControllr", sender: DicDAtaForBooking)

        }
        else
        {
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = storyboard.instantiateViewController(withIdentifier: "startupPaggingControllerViewController") as! startupPaggingControllerViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isHidden = true
            appDel.window!.rootViewController = navigationController
            appDel.window!.makeKeyAndVisible()
        }
        
       // orderNow()
    }
    func orderNow() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest  = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        print(productDictionary)
        var productId   = String()
        var variant_id  = String()
        var price       = String()
        var vendor      = String()

        if segueIdentifier == "dealsDetail"
        {
             productId          = String(describing: DicDAtaForBooking.object(forKey: "product_id")!)
             variant_id         = String(describing: DicDAtaForBooking.object(forKey: "id")!)
             price              = DicDAtaForBooking.object(forKey: "price")     as! String
             vendor             = DicDAtaForBooking.object(forKey: "vendor")    as! String
            productNAmeString   = DicDAtaForBooking.object(forKey: "title")     as! String
        }
        else
        {
            productId   = String(describing: productDictionary.object(forKey: "product_id")!)
            variant_id  = String(describing: productDictionary.object(forKey: "id")!)
            price       = productDictionary.object(forKey: "price")     as! String
            vendor      = DicDAtaForBooking.object(forKey: "vendor")    as! String
        }
        
        

        let params =  ["customer_id":userId!,"action":Cager.User.create_order,"price":price,"product_name":productNAmeString,"quantity":"1","vendor_name":vendor,"product_id":productId,"variant_id":variant_id,"fulfillment_status":"fulfilled", "currency":"USD"]as [String : Any]
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
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        self.performSegue(withIdentifier: "orderConfirmatoinControllr", sender: dicData)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "orderConfirmatoinControllr" {
            if let nextVC = segue.destination as? orderSuccessVC {
                nextVC.detailsDicData = (sender as! NSDictionary)
            }
        }
        
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        if seconds > 60
        {
          let Tryseconds = seconds - 60
            addresssLabel.text = "1:\(Tryseconds) Remaining to save your cage" //This will update the label.
        }
        else{
            if seconds < 10
            {
                addresssLabel.text = "0:0\(seconds) Remaining to save your cage" //This will update the label.
            }
            else{
                addresssLabel.text = "0:\(seconds) Remaining to save your cage" //This will update the label.
            }
            
            if seconds == 0
            {
                timer.invalidate()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
 }
