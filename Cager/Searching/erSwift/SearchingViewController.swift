//
//  SearchingViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 07/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire

class SearchingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var titleLAbel:UILabel!
    
    @IBOutlet weak var displayOneBtn:UIButton!
    @IBOutlet weak var DisplayTwoBtn:UIButton!

    @IBOutlet weak var priceOneBtn:UIButton!
    @IBOutlet weak var priceTwoBtn:UIButton!
    @IBOutlet weak var priceThreeBtn:UIButton!
    
    @IBOutlet weak var DistacneOneBtn:UIButton!
    @IBOutlet weak var DistacneTwoBtn:UIButton!
    @IBOutlet weak var DistacneThreeBtn:UIButton!
    @IBOutlet weak var DistanceFourBtn:UIButton!

    @IBOutlet weak var timeOneBtn:UIButton!
    @IBOutlet weak var timeTwoBtn:UIButton!
    @IBOutlet weak var timeThreeBtn:UIButton!
    @IBOutlet weak var searchBtn:UIButton!
    @IBOutlet weak var facilityTable:UITableView!

    var facilityArray = NSMutableArray()
    var displayString:String!
    var priceString:String!
    var distanceString:String!
    var timeString:String!
    var facilityId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        facilityArray.removeAllObjects()
        titleLAbel.layer.cornerRadius = 5
        
        displayOneBtn.layer.cornerRadius = 15
        DisplayTwoBtn.layer.cornerRadius = 15
        
        priceOneBtn.layer.cornerRadius = 15
        priceTwoBtn.layer.cornerRadius = 15
        priceThreeBtn.layer.cornerRadius = 15
        
        DistacneOneBtn.layer.cornerRadius = 15
        DistacneTwoBtn.layer.cornerRadius = 15
        DistacneThreeBtn.layer.cornerRadius = 15
        DistanceFourBtn.layer.cornerRadius = 15


        timeOneBtn.layer.cornerRadius = 15
        timeTwoBtn.layer.cornerRadius = 15
        timeThreeBtn.layer.cornerRadius = 15
        searchBtn.layer.cornerRadius = 25

        displayOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        DisplayTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        priceOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        priceTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        priceThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        DistacneOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        DistacneTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        DistacneThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        DistanceFourBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        timeOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        timeTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        timeThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

            getFacilityList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func displayBtn(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            displayOneBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            DisplayTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        }
        else {
            DisplayTwoBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            displayOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        }
        displayString = sender.titleLabel?.text
    }

    
    @IBAction func priceBtn(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            priceOneBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            priceTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            priceThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        else if sender.tag == 2 {
            priceTwoBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            priceOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            priceThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        else{
            priceThreeBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            priceOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            priceTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        }
        priceString = sender.titleLabel?.text

    }
    
    @IBAction func distanceBtn(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            DistacneOneBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            DistacneTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistacneThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistanceFourBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        else if sender.tag == 2 {
            DistacneTwoBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            DistacneOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistacneThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistanceFourBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        else if sender.tag == 3 {
            DistacneThreeBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            DistacneTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistacneOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistanceFourBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        else
        {
            DistanceFourBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            DistacneTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistacneThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            DistacneOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)

        }
        distanceString = sender.titleLabel?.text

    }
    
    @IBAction func timeBtn(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            timeOneBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            timeTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            timeThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            
        }
        else if sender.tag == 2 {
            timeTwoBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            timeOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            timeThreeBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            
        }
        else{
            timeThreeBtn.backgroundColor = UIColor.init(red: 0/255.0, green: 90/255.0, blue: 178/255.0, alpha: 1.0)
            timeOneBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
            timeTwoBtn.backgroundColor = UIColor.init(red: 53/255.0, green: 53/255.0, blue: 53/255.0, alpha: 1.0)
        }
        timeString = sender.titleLabel?.text

    }
    
    @IBAction func backBtn(_ sender: UIButton)
    {
        
       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchNow(_ sender: UIButton)
    {
        let userData = NSMutableDictionary()
        
        if displayString != ""
        {
            userData.setValue(displayString, forKey: "display")
            UserDefaults.standard.setValue(userData, forKey: "userData")
            
        }
        
        if priceString != ""
        {
            userData.setValue(priceString, forKey: "price")
            UserDefaults.standard.setValue(userData, forKey: "userData")
            
        }
        
        if distanceString != ""
        {
            userData.setValue(distanceString, forKey: "distance")
            UserDefaults.standard.setValue(userData, forKey: "userData")
            
        }
        
        if timeString != ""
        {
            userData.setValue(timeString, forKey: "time")
            UserDefaults.standard.setValue(userData, forKey: "userData")
            
        }
        if facilityId != ""
        {
            userData.setValue(facilityId!, forKey: "facilitId")
            UserDefaults.standard.setValue(userData, forKey: "userData")

        }
        UserDefaults.standard.synchronize()
        navigationController?.popViewController(animated: true)
    }

    func getFacilityList() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        let params =  ["action":Cager.User.get_facilist]as [String : Any]
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
                        let dicData = ShortDic.value(forKey: "data") as! NSArray!
                      
                        for checkData in dicData!
                        {
                            self.facilityArray.addObjects(from: [checkData])
                        }
                       //  self.facilityTable.isHidden = false
                        self.facilityTable.reloadData()
                        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(facilityArray.count + 1)
        return (facilityArray.count )        //    return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "facilityCell") as! UITableViewCell
        
 
            print(indexPath.row)
            let dicData = facilityArray.object(at: indexPath.row) as! NSDictionary
            print(indexPath.row+1)
            cell.textLabel?.text = dicData.object(forKey: "title") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            let dicData  = facilityArray.object(at: indexPath.row) as! NSDictionary
            titleLAbel.text = dicData.object(forKey: "title") as! String
        
        if indexPath.row == 0
        {
            facilityId = "45381451820"

        }
        else if indexPath.row == 1
        {
            facilityId = "45381517356"

        }
        else if indexPath.row == 2
        {
            facilityId = "45381484588"

        }
        
       // facilityId = String(describing: dicData.object(forKey: "id"))
        print(facilityId!)
            facilityTable.isHidden = true
        
    }
    
    @IBAction func openTable(_ sender: Any)
    {
        facilityTable.isHidden = false
    }
    
}
