//
//  explore2VC.swift
//  Cager
//
//  Created by mac on 19/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class explore2VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore1CellDetail") as! UITableViewCell
        
        let  battingCages   = (cell.viewWithTag(104) as! UILabel)
        let  priceHourly    = (cell.viewWithTag(105) as! UILabel)
    
        
        let  hotDeals       = (cell.viewWithTag(106) as! UILabel)
        let  hotDealsBtn    = (cell.viewWithTag(107) as! UIButton)

        
        let  btnTime1 = (cell.viewWithTag(101) as! UIButton)
        let  btnTime2 = (cell.viewWithTag(102) as! UIButton)
        let  btnTime3 = (cell.viewWithTag(103) as! UIButton)

        
  
        
        if indexPath.row == 0
        {
            let batingTop           = detailsDicData.object(forKey: "cage1") as! NSDictionary
            let batingVariant       = batingTop.object(forKey: "variants") as! NSArray
            let timeOne             = batingVariant.object(at: 0) as! NSDictionary
            let timeTwo             = batingVariant.object(at: 1) as! NSDictionary
            let timeThree           = batingVariant.object(at: 2) as! NSDictionary
            btnTime1.setTitle(timeOne.object(forKey: "timing") as? String, for: .normal)
            btnTime2.setTitle(timeTwo.object(forKey: "timing") as? String, for: .normal)
            btnTime3.setTitle(timeThree.object(forKey: "timing") as? String, for: .normal)
            battingCages.text       = batingTop.object(forKey: "title") as? String
            priceHourly.text        = "$\(String(describing: timeOne.object(forKey: "price")!)) PER HOUR"
            
            
            let attachment:NSTextAttachment     = NSTextAttachment()
            attachment.image                    = UIImage(named: "fire")
            let newAttributedString             = NSMutableAttributedString()
            var price                           = NSMutableAttributedString()
            var timingHourlu                    = NSMutableAttributedString()

            var priceNormal = String()
            var timeLabel   = String()

            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let hour:NSMutableAttributedString      = NSMutableAttributedString(string: " HOT DEAL - $")
            let perHour:NSMutableAttributedString   = NSMutableAttributedString(string: " PER HOUR - ")
            
            
            if timeOne.object(forKey: "hot_deals") as! Bool == true
            {
                
                priceNormal = String(describing: timeOne.object(forKey: "price")!)
                timeLabel   = (timeOne.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString

                
            }
                
            else if timeTwo.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeTwo.object(forKey: "price")!)
                timeLabel   = (timeTwo.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else if timeThree.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeThree.object(forKey: "price")!)
                timeLabel   = (timeThree.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else
            {
                  hotDeals.isHidden = true
            }
        }
        
        if indexPath.row == 1
        {
            let batingTop           = detailsDicData.object(forKey: "cage2") as! NSDictionary
            let batingVariant       = batingTop.object(forKey: "variants") as! NSArray
            let timeOne             = batingVariant.object(at: 0) as! NSDictionary
            let timeTwo             = batingVariant.object(at: 1) as! NSDictionary
            let timeThree           = batingVariant.object(at: 2) as! NSDictionary
            btnTime1.setTitle(timeOne.object(forKey: "timing") as? String, for: .normal)
            btnTime2.setTitle(timeTwo.object(forKey: "timing") as? String, for: .normal)
            btnTime3.setTitle(timeThree.object(forKey: "timing") as? String, for: .normal)
            battingCages.text       = batingTop.object(forKey: "title") as? String
            priceHourly.text        = "$\(String(describing: timeOne.object(forKey: "price")!)) PER HOUR"
            
            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image                = UIImage(named: "fire")
            let newAttributedString         = NSMutableAttributedString()
            var price                       = NSMutableAttributedString()
            var timingHourlu                = NSMutableAttributedString()
            
            var priceNormal = String()
            var timeLabel   = String()
            
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let hour:NSMutableAttributedString      = NSMutableAttributedString(string: " HOT DEAL - $")
            let perHour:NSMutableAttributedString   = NSMutableAttributedString(string: " PER HOUR - ")
            
            
            if timeOne.object(forKey: "hot_deals") as! Bool == true
            {
                
                priceNormal = String(describing: timeOne.object(forKey: "price")!)
                timeLabel   = (timeOne.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
                
            }
                
            else if timeTwo.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeTwo.object(forKey: "price")!)
                timeLabel   = (timeTwo.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else if timeThree.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeThree.object(forKey: "price")!)
                timeLabel   = (timeThree.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else
            {
                hotDeals.isHidden = true
            }
            
        }
        
        
        if indexPath.row == 2 {
            let batingTop           = detailsDicData.object(forKey: "cage3") as! NSDictionary
            let batingVariant       = batingTop.object(forKey: "variants") as! NSArray
            let timeOne             = batingVariant.object(at: 0) as! NSDictionary
            let timeTwo             = batingVariant.object(at: 1) as! NSDictionary
            let timeThree           = batingVariant.object(at: 2) as! NSDictionary
            btnTime1.setTitle(timeOne.object(forKey: "timing") as? String, for: .normal)
            btnTime2.setTitle(timeTwo.object(forKey: "timing") as? String, for: .normal)
            btnTime3.setTitle(timeThree.object(forKey: "timing") as? String, for: .normal)
            battingCages.text       = batingTop.object(forKey: "title") as? String
            priceHourly.text        = "$\(String(describing: timeOne.object(forKey: "price")!)) PER HOUR"
            
            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image                = UIImage(named: "fire")
            let newAttributedString         = NSMutableAttributedString()
            var price                       = NSMutableAttributedString()
            var timingHourlu                = NSMutableAttributedString()
            
            var priceNormal = String()
            var timeLabel   = String()
            
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let hour:NSMutableAttributedString      = NSMutableAttributedString(string: " HOT DEAL - $")
            let perHour:NSMutableAttributedString   = NSMutableAttributedString(string: " PER HOUR - ")
            
            
            if timeOne.object(forKey: "hot_deals") as! Bool == true {
                
                priceNormal = String(describing: timeOne.object(forKey: "price")!)
                timeLabel = (timeOne.object(forKey: "timing") as? String)!
                
                price = NSMutableAttributedString(string: priceNormal)
                timingHourlu = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
                
            }
                
            else if timeTwo.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeTwo.object(forKey: "price")!)
                timeLabel   = (timeTwo.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else if timeThree.object(forKey: "hot_deals") as! Bool == true
            {
                priceNormal = String(describing: timeThree.object(forKey: "price")!)
                timeLabel   = (timeThree.object(forKey: "timing") as? String)!
                
                price           = NSMutableAttributedString(string: priceNormal)
                timingHourlu    = NSMutableAttributedString(string: timeLabel)
                
                newAttributedString.append(attachmentString)
                newAttributedString.append(hour)
                newAttributedString.append(price)
                newAttributedString.append(perHour)
                newAttributedString.append(timingHourlu)
                hotDeals.attributedText = newAttributedString
                
            }
            else
            {
                hotDeals.isHidden = true
            }
        }
        btnTime1.accessibilityIdentifier = String(indexPath.row)
        btnTime2.accessibilityIdentifier = String(indexPath.row)
        btnTime3.accessibilityIdentifier = String(indexPath.row)

        btnTime1.addTarget(self, action: #selector(showDetailOfExploreOne(_:)), for: .touchUpInside)
        btnTime2.addTarget(self, action: #selector(showDetailOfExploreTwo(_:)), for: .touchUpInside)
        btnTime3.addTarget(self, action: #selector(showDetailOfExploreThree(_:)), for: .touchUpInside)

        hotDealsBtn.addTarget(self, action: #selector(showHotDealsList(_:)), for: .touchUpInside)
        
        btnTime1.layer.cornerRadius = 8.0
        btnTime2.layer.cornerRadius = 8.0
        btnTime3.layer.cornerRadius = 8.0

        
        
        btnTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
        btnTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
        btnTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
        
        
        //miles.text = "\(milesData) mi"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

    

//    @IBOutlet weak var btnTime1: UIButton!
//    @IBOutlet weak var btnTime2: UIButton!
//    @IBOutlet weak var btnTime3: UIButton!
//    @IBOutlet weak var btnPitchTime1: UIButton!
//    @IBOutlet weak var btnPitchTime2: UIButton!
//    @IBOutlet weak var btnPitchTime3: UIButton!
    @IBOutlet weak var tableExplore: UITableView!

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
//    @IBOutlet weak var battingCages: UILabel!
//    @IBOutlet weak var priceHourly: UILabel!
//
//    @IBOutlet weak var pitchingCages: UILabel!
//    @IBOutlet weak var pitchingpriceHourly: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var productString = String()

    var detailsDicData = NSDictionary()
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    // Extra
//     var timeOne = NSDictionary()
//    var timeTwo = NSDictionary()
//    var timeThree = NSDictionary()
//
//    var PitchingLanetimeOne = NSDictionary()
//    var PitchingLanetimeTwo = NSDictionary()
//    var PitchingLanetimeThree = NSDictionary()
    
    var sendTime = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailsDicData)
        
        let url =  URL(string:detailsDicData.object(forKey: "image") as! String)
        mainImage.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)

        titleLabel.text = detailsDicData.object(forKey: "vendor") as? String
        descriptionLabel.text = detailsDicData.object(forKey: "description") as? String
        addressLabel.text = detailsDicData.object(forKey: "address") as? String
        
               //Note: batting CAGES
//        let batingTop = detailsDicData.object(forKey: "cage1") as! NSDictionary
//        let batingVariant = batingTop.object(forKey: "variants") as! NSArray
//         timeOne = batingVariant.object(at: 0) as! NSDictionary
//         timeTwo = batingVariant.object(at: 1) as! NSDictionary
//         timeThree = batingVariant.object(at: 2) as! NSDictionary
//        btnTime1.setTitle(timeOne.object(forKey: "timing") as? String, for: .normal)
//        btnTime2.setTitle(timeTwo.object(forKey: "timing") as? String, for: .normal)
//        btnTime3.setTitle(timeThree.object(forKey: "timing") as? String, for: .normal)
//        battingCages.text = batingTop.object(forKey: "title") as? String
//        priceHourly.text = "$\(String(describing: timeOne.object(forKey: "price")!)) PER HOUR"
        
        //Note: Pitching lane
        
//        let PitchingLaneTop = detailsDicData.object(forKey: "cage2") as! NSDictionary
//        let PitchingLaneVariant = PitchingLaneTop.object(forKey: "variants") as! NSArray
//         PitchingLanetimeOne = PitchingLaneVariant.object(at: 0) as! NSDictionary
//         PitchingLanetimeTwo = PitchingLaneVariant.object(at: 1) as! NSDictionary
//         PitchingLanetimeThree = PitchingLaneVariant.object(at: 2) as! NSDictionary
//        btnPitchTime1.setTitle(PitchingLanetimeOne.object(forKey: "timing") as? String, for: .normal)
//        btnPitchTime2.setTitle(PitchingLanetimeTwo.object(forKey: "timing") as? String, for: .normal)
//        btnPitchTime3.setTitle(PitchingLanetimeThree.object(forKey: "timing") as? String, for: .normal)
//        pitchingCages.text = PitchingLaneTop.object(forKey: "title") as? String
//        pitchingpriceHourly.text = "$\(String(describing: PitchingLanetimeOne.object(forKey: "price")!)) PER HOUR"


//        btnTime1.layer.cornerRadius = 8.0
//        btnTime2.layer.cornerRadius = 8.0
//        btnTime3.layer.cornerRadius = 8.0
//
//
//        btnPitchTime1.layer.cornerRadius = 8.0
//        btnPitchTime2.layer.cornerRadius = 8.0
//        btnPitchTime3.layer.cornerRadius = 8.0
//
//
//        btnTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//        btnTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//        btnTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//        btnPitchTime2.backgroundColor = UIColor.init(red:0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//        btnPitchTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//        btnPitchTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showHotDealsList(_ sender: Any) {
        self.performSegue(withIdentifier: "showHotDealsRegardingThisProduct", sender:  nil )

    }
    
    @IBAction func showDetailOfExploreOne(_ sender: Any) {

        let selectedRow = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        print((sender as AnyObject).tag as Any)
        let indPath = IndexPath(row: selectedRow, section: 0)
        if indPath.row == 0 {
            
            let batingTop = detailsDicData.object(forKey: "cage1") as! NSDictionary
            let batingVariant = batingTop.object(forKey: "variants") as! NSArray
            
            productString = batingTop.object(forKey: "title") as! String
           let timeOne = batingVariant.object(at: 0) as! NSDictionary
            sendTime = timeOne.object(forKey: "timing") as! String
            
            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeOne )
            
        } else if indPath.row == 1 {
            let batingTop = detailsDicData.object(forKey: "cage2") as! NSDictionary
            let batingVariant = batingTop.object(forKey: "variants") as! NSArray
            
            productString = batingTop.object(forKey: "title") as! String
           let timeTwo = batingVariant.object(at: 0) as! NSDictionary
            sendTime = timeTwo.object(forKey: "timing") as! String
            
            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeTwo )
            
        } else if indPath.row == 2 {
            let batingTop       = detailsDicData.object(forKey: "cage3")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeThree       = batingVariant.object(at: 0)               as! NSDictionary
            sendTime            = timeThree.object(forKey: "timing")        as! String
            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeThree )
        }
    }
    
    @IBAction func showDetailOfExploreTwo(_ sender: Any) {
        
        let selectedRow = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        let indPath = IndexPath(row: selectedRow, section: 0)
        if indPath.row == 0
        {
            let batingTop       = detailsDicData.object(forKey: "cage1")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeOne         = batingVariant.object(at: 1)               as! NSDictionary
            sendTime            = timeOne.object(forKey: "timing")          as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeOne )

        }
        else if indPath.row == 1
        {
            let batingTop       = detailsDicData.object(forKey: "cage2")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeTwo         = batingVariant.object(at: 1)               as! NSDictionary
            sendTime            = timeTwo.object(forKey: "timing")          as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeTwo )

        }
        else if indPath.row == 2
        {
            let batingTop       = detailsDicData.object(forKey: "cage3")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeThree       = batingVariant.object(at: 1)               as! NSDictionary
            sendTime            = timeThree.object(forKey: "timing")        as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeThree )

        }
        
        
    }
    
    @IBAction func showDetailOfExploreThree(_ sender: Any) {

        


        let selectedRow = Int((sender as AnyObject).accessibilityIdentifier ?? "") ?? 0
        print(selectedRow)
        let indPath = IndexPath(row: selectedRow, section: 0)
        if indPath.row == 0 {
            let batingTop       = detailsDicData.object(forKey: "cage1")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeOne         = batingVariant.object(at: 2)               as! NSDictionary
            sendTime            = timeOne.object(forKey: "timing")          as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeOne )

        }
        else if indPath.row == 1 {
            
            let batingTop           = detailsDicData.object(forKey: "cage2")    as! NSDictionary
            let batingVariant       = batingTop.object(forKey: "variants")      as! NSArray
            productString           = batingTop.object(forKey: "title")         as! String
            let timeTwo             = batingVariant.object(at: 2)               as! NSDictionary
            sendTime                = timeTwo.object(forKey: "timing")          as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeTwo )

        }
        else if indPath.row == 2 {
            
            let batingTop       = detailsDicData.object(forKey: "cage3")    as! NSDictionary
            let batingVariant   = batingTop.object(forKey: "variants")      as! NSArray
            productString       = batingTop.object(forKey: "title")         as! String
            let timeThree       = batingVariant.object(at: 2)               as! NSDictionary
            sendTime            = timeThree.object(forKey: "timing")        as! String

            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeThree )

        }
        
    }
    
    @IBAction func selectBattingCages(_ sender: Any) {
//         productString = battingCages.text!
//        if (sender as AnyObject).tag == 101{
//            btnTime1.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnTime1.titleLabel?.text)!
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeTwo )
//
//        }
//        else if (sender as AnyObject).tag == 102{
//            btnTime2.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnTime2.titleLabel?.text)!
//
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeTwo)
//
//        }
//        else {
//            btnTime3.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnTime3.titleLabel?.text)!
//
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  timeThree)
//
//        }
//

       
    }
    
    @IBAction func pitchingselectTime(_ sender: Any) {
//        productString = pitchingCages.text!
//        if (sender as AnyObject).tag == 104{
//            btnPitchTime1.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnPitchTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnPitchTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnPitchTime1.titleLabel?.text)!
//
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  PitchingLanetimeOne)
//
//
//        }
//        else if (sender as AnyObject).tag == 105{
//            btnPitchTime2.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnPitchTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnPitchTime3.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnPitchTime2.titleLabel?.text)!
//
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  PitchingLanetimeTwo)
//
//
//        }
//        else {
//            btnPitchTime3.backgroundColor = UIColor.init(red: 222/255.0, green: 135/255.0, blue: 70/255.0, alpha: 1)
//            btnPitchTime1.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            btnPitchTime2.backgroundColor = UIColor.init(red: 0/255.0, green: 85/255.0, blue: 151/255.0, alpha: 1)
//            sendTime = (btnPitchTime3.titleLabel?.text)!
//            self.performSegue(withIdentifier: "showTheBookingScreen", sender:  PitchingLanetimeThree)


//        }
        

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTheBookingScreen" {
            if let nextVC = segue.destination as? bookingViewController {

                nextVC.productDictionary    = ((sender as! NSDictionary) as NSDictionary)
                nextVC.DicDAtaForBooking    = detailsDicData
                nextVC.productNAmeString    = productString
                nextVC.timeLabel            = sendTime

            }
        }
        else if segue.identifier == "showHotDealsRegardingThisProduct" {
            if let nextVC = segue.destination as? mapScreenVC {

                nextVC.segueIdentifier = segue.identifier!

            }
        }


    }
}
