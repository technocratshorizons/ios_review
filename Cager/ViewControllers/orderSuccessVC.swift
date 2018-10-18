//
//  orderSuccessVC.swift
//  Cager
//
//  Created by mac on 20/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class orderSuccessVC: UIViewController {
    @IBOutlet weak var showTheDetail: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var nameOrderPerson: UILabel!

    var detailsDicData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailsDicData)
     //   let customerData = detailsDicData.object(forKey: "customer") as! NSDictionary
       // let fulfillments = detailsDicData.object(forKey: "fulfillments") as! NSArray
     //   let fullfillmentsData = fulfillments[0]  as! NSDictionary
      //  orderNumber.text = "Order #\(String(describing: fullfillmentsData.object(forKey: "order_id")!))"
        
        
        let userNameA = UserDefaults.standard.string(forKey: "fullName")!

        nameOrderPerson.text = "Thank you \(userNameA)"
        
        addressLabel.text = " \(detailsDicData.object(forKey: "address") as! String)"

        
        showTheDetail.layer.cornerRadius = 25
        addressLabel.layer.borderWidth = 1
        addressLabel.layer.borderColor = UIColor.gray.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickBtnBack(_ sender: Any)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    
    @IBAction func viewTheDetailOfbooking(_ sender: Any)
    {
        self.performSegue(withIdentifier: "afterOrderConfirmatinControllr", sender: detailsDicData)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "afterOrderConfirmatinControllr" {
            if let nextVC = segue.destination as? exploreDetailVC {
                nextVC.exploreDetailDic = (sender as! NSDictionary)
            }
        }
        
    }

}
