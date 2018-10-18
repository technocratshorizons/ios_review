//
//  FacilityViewController.swift
//  Cager
//
//  Created by macmin on 17/03/18.
//  Copyright © 2018 macmin. All rights reserved.
//

import UIKit

class FacilityViewController: UIViewController {

    @IBOutlet weak var txtChooseSports: UITextField!
    @IBOutlet weak var heightBusiness: NSLayoutConstraint!
    @IBOutlet weak var topBusinessName: NSLayoutConstraint!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var bottomPassword: NSLayoutConstraint!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
            initialSetup()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initialSetup() {
        
       
        btnNext.layer.cornerRadius = 25
        if DeviceType.IS_IPHONE_6_7_8 {
            
            topBusinessName.constant = 50
            bottomPassword.constant = 15
            heightBusiness.constant = 40
            
        } else if DeviceType.IS_IPHONE_6P_7P_8P{
            
            topBusinessName.constant = 30
            bottomPassword.constant = 40
            heightBusiness.constant = 40
            
        } else if DeviceType.IS_IPHONE_X {
            topBusinessName.constant = 35
            bottomPassword.constant = 45
            heightBusiness.constant = 40
        }
        
    }
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSignIn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
