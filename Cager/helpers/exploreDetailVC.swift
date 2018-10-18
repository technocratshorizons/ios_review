//
//  exploreDetailVC.swift
//  Cager
//
//  Created by mac on 20/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class exploreDetailVC: UIViewController {

    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    @IBOutlet weak var backGroundImage: UIImageView!

    var exploreDetailDic = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(exploreDetailDic)
        
//        let customerData = exploreDetailDic.object(forKey: "customer") as! NSDictionary
//        let line_items = exploreDetailDic.object(forKey: "line_items") as! NSArray
//        let fullfillmentsData = line_items[0]  as! NSDictionary
//        let timeForProduct = fullfillmentsData.object(forKey: "variant_title") as? String
//        let FilterString = timeForProduct?.components(separatedBy: "/")
        
        if exploreDetailDic.object(forKey: "variants") != nil
        {
            let varientArrray = exploreDetailDic.object(forKey: "variants") as! NSArray
            var dicData = NSDictionary()
            for checkData in varientArrray
            {
                dicData = checkData as! NSDictionary
            }
            
            btnTime.setTitle(dicData.object(forKey: "option2") as! String, for: .normal)
            vendorName.text = dicData.object(forKey: "product_name") as? String
            //  pricelbl.text = " Price        $\(exploreDetailDic.object(forKey: "price") as! String)"
            pricelbl.text = " Price        $80"
            discountLbl.text = "Discount   \(dicData.object(forKey: "discount") ?? String())%"
            let url =  URL(string:exploreDetailDic.object(forKey: "image") as! String)
            
            backGroundImage.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)


        }
        else
        {
            btnTime.setTitle(exploreDetailDic.object(forKey: "option2") as! String, for: .normal)
            vendorName.text = exploreDetailDic.object(forKey: "product_name") as? String
            //  pricelbl.text = " Price        $\(exploreDetailDic.object(forKey: "price") as! String)"
            pricelbl.text = " Price        $80"
            discountLbl.text = "Discount   \(String(describing: exploreDetailDic.object(forKey: "discount") as? String))%"


        }
        
        btnTime.layer.cornerRadius = 8.0
        btnInvite.layer.cornerRadius = 8.0
        
        address.text = " \(exploreDetailDic.object(forKey: "address") as! String)"
        
        
        

        
     //   let priceAmoun = Int(exploreDetailDic.object(forKey: "price") as! String)
       // let discountAmount = Int(exploreDetailDic.object(forKey: "discount") as! String)
        
//        let priceValue = exploreDetailDic.object(forKey: "price") as! String
//
//        let a = priceValue.int  // firstText is UITextField
//
//        let b:Int = Int(exploreDetailDic.object(forKey: "discount") as! String)!   // firstText is UITextField
//
//
//        let total = a - b
//        print(total)
        totalLbl.text = "Total          $64"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickBtnBack(_ sender: Any) {
        
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                                self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
