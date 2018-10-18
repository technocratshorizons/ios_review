//
//  SideMenuViewController.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Kingfisher
class SideMenuViewController: UIViewController  {

    //MARK:- Outlets And Variable Declaration
    @IBOutlet weak var imgProfile: ZWImageView!
    @IBOutlet weak var profileImage: UIImageView!

    
    @IBOutlet weak var lblUsername: UILabel!
    
    
    let arrayProfile = ["Home", "Search", "Scan Code", "Invite Friends", "Transfer to Bank", "Purchases", "Settings"] as NSArray
    let arrayImgProfile = ["ic_home.png", "ic_search.png", "ic_scan.png", "ic_invite_user.png", "ic_transfer_bank.png", "ic_purchases.png", "ic_setting.png"] as NSArray
    
    //MARk:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profileTapped(_:)))
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserDefaults.standard.object(forKey: "picture") != nil
        {
            print(UserDefaults.standard.string(forKey: "picture")!)
            //  UserDefaults.standard.set(dicData?.value(forKey: "picture"), forKey: "picture")
         //   let url =  URL(string:(UserDefaults.standard.string(forKey: "picture"))!)
           // profileImage?.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)
            
        }
        
        if UserDefaults.standard.string(forKey: "user_id") != nil
        {
            print(UserDefaults.standard.string(forKey: "fullName")!)
            let userNameA = UserDefaults.standard.string(forKey: "fullName")!
            lblUsername.text = userNameA
            
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
        
    }
    @objc func profileTapped(_ sender:AnyObject){
       self.performSegue(withIdentifier: "editProfileSegue", sender: nil)
    }
    @IBAction func exploresControllerAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showExplore", sender: nil)
    }
    @IBAction func hotDealsControllerAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showHotDEalsPae", sender: nil)
    }
    @IBAction func logoutTheApp(_ sender: UIButton) {
        if let bundle = Bundle.main.bundleIdentifier
        {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
        UserDefaults.standard.removeObject(forKey: "user_id")
        
        UserDefaults.standard.synchronize()
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = storyboard.instantiateViewController(withIdentifier: "startupPaggingControllerViewController") as! startupPaggingControllerViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
        
    //    let centerVC = mainStoryBoard.instantiateViewController(withIdentifier: "startupPaggingControllerViewController") as! startupPaggingControllerViewController
        
        // setting the login status to true
        appDel.window!.rootViewController = navigationController
        appDel.window!.makeKeyAndVisible()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showExplorre" {
            if let nextVC = segue.destination as? explorListViewController {
                nextVC.segueIdentifier = segue.identifier!
            }
        }
        else if segue.identifier == "showHotDEalsPae" {
            if let nextVC = segue.destination as? mapScreenVC {
                nextVC.segueIdentifier = segue.identifier!
            }
        }
        
    }
}
