//
//  TouchIDSignInViewController.swift
//  Cager
//
//  Created by macmin on 17/03/18.
//  Copyright © 2018 macmin. All rights reserved.
//

import UIKit
import  LocalAuthentication


class TouchIDSignInViewController: UIViewController {

    @IBOutlet weak var btnSign: UIButton!
    @IBOutlet weak var bottomImgFingerPrint: NSLayoutConstraint!
    @IBOutlet weak var topImgFingerPrint: NSLayoutConstraint!
    @IBOutlet weak var btnNoThanks: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            authenticateUser()
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func initialSetup() {
        
        btnSign.layer.cornerRadius = 25
        btnNoThanks.layer.cornerRadius = 25
        btnNoThanks.layer.borderColor = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 175.0/255.0, alpha: 1).cgColor
        btnNoThanks.layer.borderWidth = 1
        if DeviceType.IS_IPHONE_6_7_8{
            
            topImgFingerPrint.constant = 20
            bottomImgFingerPrint.constant = 20
            
        } else if DeviceType.IS_IPHONE_6P_7P_8P{
            
            topImgFingerPrint.constant = 60
            bottomImgFingerPrint.constant = 40
        } else if DeviceType.IS_IPHONE_X {
            
            topImgFingerPrint.constant = 30
            bottomImgFingerPrint.constant = 30
        }
        
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
     @IBAction func btnActionNoThnx(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
