//
//  reservationViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 01/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire

class reservationViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if whichReserveList == "draft"
        {
            return DraftArray.count

        }
        else if whichReserveList == "Order"
        {
            return orderArray.count

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore1Cell") as! explore1Cell
        
        let  titleEvent = (cell.viewWithTag(1) as! UILabel)
        let  mobileNumber = (cell.viewWithTag(5) as! UILabel)
        let  addressLabel = (cell.viewWithTag(6) as! UILabel)
        let  openCloseTime = (cell.viewWithTag(8) as! UILabel)
        var DicData = NSDictionary()
        
        if whichReserveList == "draft"
        {
            DicData = DraftArray.object(at: indexPath.row) as! NSDictionary
        }
        else if whichReserveList == "Order"
        {
            DicData = orderArray.object(at: indexPath.row) as! NSDictionary
        }

        
        
        titleEvent.text = DicData.object(forKey: "vendor") as? String
        mobileNumber.text = DicData.object(forKey: "product_name") as? String
        addressLabel.text = "$ \(DicData.object(forKey: "total_price")!) Per Hour"

       // openCloseTime.text = "Open \(DicData.object(forKey: "open_time") as! String)-\(DicData.object(forKey: "close_time") as! String)"
        print(DicData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var DicData = NSDictionary()
        
        if whichReserveList == "draft"
        {
            DicData = DraftArray.object(at: indexPath.row) as! NSDictionary
        }
        else if whichReserveList == "Order"
        {
            DicData = orderArray.object(at: indexPath.row) as! NSDictionary
        }
        performSegue(withIdentifier: "showTheReseredEvent", sender: DicData)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showTheReseredEvent" {
            if let nextVC = segue.destination as? exploreNew1VC {
                nextVC.detailsDicDataDetail = (sender as! NSDictionary)
            }
        }
        
    }
    
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    var DraftArray = NSMutableArray()
    var orderArray = NSMutableArray()
    var whichReserveList = String()
    @IBOutlet weak var reservationListtble: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        whichReserveList = "Order"
        getReservationList()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func myOrders(_ sender: Any) {
        whichReserveList = "Order"
        reservationListtble.reloadData()
    }
    @IBAction func saveForLater(_ sender: Any) {
        whichReserveList = "draft"
        reservationListtble.reloadData()
    }
    func getReservationList() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let params =  ["user_id":userId!,"action":Cager.User.reserve_order]as [String : Any]
        print(params)
        Alamofire.request( urlRequest, method: .post, parameters:params , encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.orderArray.removeAllObjects()
                self.DraftArray.removeAllObjects()

                if response.result.isSuccess
                {
                    let ShortDic = response.result.value as! NSDictionary
                    let item2 = ShortDic.value(forKey: "success") as! NSNumber
                    
                    if item2 == 1
                    {
                        print(ShortDic)
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        let drafte = dicData?.value(forKey: "drafts") as! NSArray!
                        let orders = dicData?.value(forKey: "orders") as! NSArray!

                        for checkData in drafte!
                        {
                            self.DraftArray.addObjects(from: [checkData])
                        }
                        
                        for orderAr in orders!
                        {
                            self.orderArray.addObjects(from: [orderAr])
                        }
                        self.reservationListtble.reloadData()
                        
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
    
}


