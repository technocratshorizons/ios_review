//
//  AuthenticationCodeViewController.swift
//  Cager
//
//  Created by macmin on 17/03/18.
//  Copyright © 2018 macmin. All rights reserved.
//

import UIKit
import Alamofire

class AuthenticationCodeViewController: UIViewController {
    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var bottomInfo: NSLayoutConstraint!
    @IBOutlet weak var topEnterCode: NSLayoutConstraint!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var EmailForVerification = NSString()

    @IBOutlet weak var txtCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            intialSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnActionBackTouchId(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnverifyThroughGmail(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        
        let email: String? = EmailForVerification as String
        let txtCode: String? = self.txtCode.text
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        let UDID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print(UDID)
        let params =  ["email":email!,"verify_code":txtCode!,"action":Cager.User.verify_email]as [String : Any]
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
                        //                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        //                        UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        //                        UserDefaults.standard.synchronize()
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                        
                        self.performSegue(withIdentifier: "thumbImpression", sender: nil)
                        
                        //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        //                        self.navigationController?.pushViewController(vc!, animated: true)
                        
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
    
    @IBAction func resendTheOtp(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        
        let email: String? = EmailForVerification as String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        let UDID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print(UDID)
        let params =  ["emaill":email!,"action":Cager.User.generate_code]as [String : Any]
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
    
    @IBAction func btnActionSignIn(_ sender: Any) {
   
        
        
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    func intialSetup() {
        
         btnResend.layer.cornerRadius = 25
         btnSignUp.layer.cornerRadius = 25
        btnResend.layer.borderColor = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 175.0/255.0, alpha: 1).cgColor
        btnResend.layer.borderWidth = 1
   
//        if DeviceType.IS_IPHONE_6_7_8 {
//
//            topEnterCode.constant = 50
//            bottomInfo.constant = 15
//
//
//        } else if DeviceType.IS_IPHONE_6P_7P_8P{
//
//            topEnterCode.constant = 30
//            bottomInfo.constant = 40
//
//
//        } else if DeviceType.IS_IPHONE_X {
//            topEnterCode.constant = 35
//            bottomInfo.constant = 45
//
//        }
        
        
        
    }

    
}
