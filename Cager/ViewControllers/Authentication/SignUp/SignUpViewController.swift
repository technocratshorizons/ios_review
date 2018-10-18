//
//  SignUpViewController.swift
//  Cager
//
//  Created by macmin on 17/03/18.
//  Copyright © 2018 macmin. All rights reserved.
//

import UIKit

import Alamofire
class SignUpViewController: UIViewController {
    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var topFirstName: NSLayoutConstraint!
    @IBOutlet weak var heightFirstName: NSLayoutConstraint!
    @IBOutlet weak var bottomConfirmPassword: NSLayoutConstraint!
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var imgCoach: UIImageView!
    @IBOutlet weak var lblCoach: UILabel!
    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var userType = String()
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateview: UIView!
    let dateFormatter = DateFormatter()
    var arrtayMonth = [String]()
    
    var dateOfirthParameter = String()
    @IBOutlet var DatePickerDateView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    
    var basicDataDic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrtayMonth = ["Jan","Feb","Mar","Apr","may","June","Jul","Aug","Sep","Oct","Nov","Dec"]

     
        
        emailText.attributedPlaceholder = NSAttributedString(string: "Email Address",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        firstName.attributedPlaceholder = NSAttributedString(string: "First Name",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Phone",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "Birthday",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

            initialSetup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnActionSelectAccountType(_ sender: UIButton) {
    
        if sender.tag == 0 {
            imgPlayer.image = UIImage(named:"playserIcon.png")
           lblPlayer.textColor = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 175.0/255.0, alpha: 1)
            imgCoach.image = UIImage(named:"coachWhite.png")
            lblCoach.textColor =  UIColor.white
            userType = "Player"
            
        } else if sender.tag == 1 {
            imgCoach.image = UIImage(named:"coachBlue.png")
            lblCoach.textColor =  UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 175.0/255.0, alpha: 1)
            imgPlayer.image = UIImage(named:"playerWhite.png")
            lblPlayer.textColor = UIColor.white
            userType = "Coach"
        } else  {
            
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "FacilityViewController")
          //  self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
    fileprivate func initialSetup() {
        
        imgPlayer.image = UIImage(named:"playserIcon.png")
        lblPlayer.textColor = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 175.0/255.0, alpha: 1)
        userType = "Player"
        btnNext.layer.cornerRadius = 25
        if DeviceType.IS_IPHONE_6_7_8 {
            
            topFirstName.constant = 50
            bottomConfirmPassword.constant = 15
            heightFirstName.constant = 40
            
        } else if DeviceType.IS_IPHONE_6P_7P_8P{
            
            topFirstName.constant = 30
            bottomConfirmPassword.constant = 40
            heightFirstName.constant = 40
    
        } else if DeviceType.IS_IPHONE_X {
            topFirstName.constant = 35
            bottomConfirmPassword.constant = 45
            heightFirstName.constant = 40
        }
      
    }
    
    @IBAction func btnActionSignUp(_ sender: Any) {
        
        
        if !common.isConnectedToInternet()
        {
            self.app_delegate.setUIBlockingEnabled(false)
            common.showPositiveMessage(message: "Please check your internet connection.")
            return
        }
        
        if emailText.text?.count == 0 || passwordText.text?.count == 0 || confirmPassword.text?.count == 0
        {
            common.showPositiveMessage(message:"Please fill all field")
            return
        }
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: emailText.text)
        
        if !result
        {
            common.showPositiveMessage(message: "Please fill valid email")
            return
        }
        

        app_delegate.setUIBlockingEnabled(true)
        let user = UserDefaults.standard
        let pre = Locale.preferredLanguages[0]
        let arr = pre.components(separatedBy: "-")
        let deviceLanguage = arr.first
        
        //   let deviceToken:String = UserDefaults.standard.object(forKey: Copines.Key.deviceToken) as! String
        let password: String? = passwordText.text
        let email: String? = emailText.text
        let Dob: String? = confirmPassword.text
        let firstNa: String? = emailText.text
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        let UDID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print(UDID)
        
        
        print(emailText.text ?? String())
        print(basicDataDic.object(forKey: "password") ?? String())
        print(Cager.User.register)
        
        

        print(UserDefaults.standard.string(forKey: "firstName") ?? String())
        print(UserDefaults.standard.string(forKey: "lastName") ?? String())
        print(userType)
        print(basicDataDic.object(forKey: "confirmPasss") ?? String())
        print(Dob ?? String())
        print(password ?? String())

        
        
        
        
        
        let params =  ["email":emailText.text ?? String(),"password":basicDataDic.object(forKey: "password") as! String? ?? String(),"action":Cager.User.register,"firstname":UserDefaults.standard.string(forKey: "firstName") ?? String(), "lastname":UserDefaults.standard.string(forKey: "lastName") ?? String(),"type":userType,"password_confirmation":basicDataDic.object(forKey: "confirmPasss") as! String? ?? String(),"dob":Dob ?? String(),"phone":password ?? String()]as [String : Any]
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
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
      
                        UserDefaults.standard.set("Yes", forKey: "loginStatus")

                        UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        UserDefaults.standard.synchronize()
                        self.app_delegate.setUIBlockingEnabled(false)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        self.navigationController?.pushViewController(vc!, animated: true)

                     //   self.performSegue(withIdentifier: "showTheOtpPage", sender: email)
                        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showTheOtpPage" {
            if let nextVC = segue.destination as? AuthenticationCodeViewController {
                nextVC.EmailForVerification = sender as! NSString
                
            }
        }
        
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSignIn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func buttoncancelClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        dateview.isHidden = true
        // bottomContraints.constant = -173
    }
    
    @IBAction func buttonDoneClick(_ sender: UIButton)
    {
        
        // bottomContraints.constant = -173
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let fullName: String = dateFormatter.string(from: datePicker.date)
        let fullNameArr = fullName.components(separatedBy: "-")
        var Day = String()
        let date: String = fullNameArr[2]
        var month: String = fullNameArr[1]
        let months:Int = (month as NSString).integerValue
        month = arrtayMonth[months - 1]
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: datePicker.date)
        
        print(weekDay)
        print(month)
        let year: String = fullNameArr[0]

        
        
         confirmPassword.text = "\(date), \(month) \(year)"
        self.view.endEditing(true)
        dateview.isHidden = true
        
        
        
        
        // getexploreData()
    }
    
    @IBAction func buttonDateClick(_ sender: UIButton)
    {
        
        //MARK:- new editing
        self.view.endEditing(true)
        //  bottomContraints.constant = 10
        dateview.frame = CGRect(x:0, y:self.view.frame.size.height - 175, width: self.view.frame.size.width, height:175)
        dateview.isHidden = false
        
    }
    
    @IBAction func datePickerMethod(_ sender: UIDatePicker)
    {
        self.view.endEditing(true)
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let somedateString = dateFormatter.string(from: sender.date)
        dateOfirthParameter = somedateString
        //lbldate.text = somedateString
        print(somedateString)
    }
}
