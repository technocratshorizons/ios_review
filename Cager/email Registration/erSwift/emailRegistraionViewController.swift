//
//  emailRegistraionViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 05/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class emailRegistraionViewController: UIViewController {
    
    @IBOutlet weak var emailAddress:UITextField!
    @IBOutlet weak var firstName:UITextField!
    @IBOutlet weak var lastName:UITextField!
    @IBOutlet weak var newPassword:UITextField!
    @IBOutlet weak var confirmPAssword:UITextField!
    
    @IBOutlet weak var emailAddressLbl:UILabel!
    @IBOutlet weak var firstNameLbl:UILabel!
    @IBOutlet weak var lastNameLbl:UILabel!
    @IBOutlet weak var newPasswordLbl:UILabel!
    @IBOutlet weak var confirmPAsswordLbl:UILabel!
    
    @IBOutlet weak var proceedBtn:UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddress.attributedPlaceholder = NSAttributedString(string: "Email Address",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        firstName.attributedPlaceholder = NSAttributedString(string: "First Name",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        lastName.attributedPlaceholder = NSAttributedString(string: "Last Name",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        newPassword.attributedPlaceholder = NSAttributedString(string: "Create Password",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        confirmPAssword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        proceedBtn.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showTheController(_ sender: Any)
    
    {
        if emailAddress.text != "" && firstName.text != "" && lastName.text != "" && newPassword.text != "" && confirmPAssword.text != ""
        {
            let userData = NSMutableDictionary()

            userData.setValue(emailAddress.text, forKey: "email")
            userData.setValue(firstName.text, forKey: "firstName")
            userData.setValue(lastName.text, forKey: "lastName")
            userData.setValue(newPassword.text, forKey: "password")
            userData.setValue(confirmPAssword.text, forKey: "confirmPasss")

            
            UserDefaults.standard.set(emailAddress.text, forKey: "email") //setObject
            UserDefaults.standard.set(firstName.text, forKey: "firstName") //setObject
            UserDefaults.standard.set(lastName.text, forKey: "lastName") //setObject
            UserDefaults.standard.set(newPassword.text, forKey: "password") //setObject
            UserDefaults.standard.set(confirmPAssword.text, forKey: "confirmPasss") //setObject

            
            
            performSegue(withIdentifier: "showTheRegisterPage", sender: userData)

            
        }
        else
        {
            common.showPositiveMessage(message:"Please fill all field")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showTheRegisterPage" {
            if let nextVC = segue.destination as? SignUpViewController {
                nextVC.basicDataDic = (sender as! NSDictionary)
            }
        }
        
        
    }

    @IBAction func jstBack(_ sender: Any)
        
    {
        navigationController?.popViewController(animated: true)
    }

}
