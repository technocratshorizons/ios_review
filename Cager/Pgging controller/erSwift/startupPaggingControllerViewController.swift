//
//  startupPaggingControllerViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 04/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Alamofire
import Google
import GoogleSignIn

class startupPaggingControllerViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    let app_delegate = UIApplication.shared.delegate as! AppDelegate
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
    @IBOutlet weak var mainView:UIImageView!

    var dic = [AnyHashable: Any]()

    @IBOutlet weak var viewOne:UIView!
    @IBOutlet weak var labelDotOne:UILabel!
    @IBOutlet weak var labelDotTwo:UILabel!
    @IBOutlet weak var labelDotThree:UILabel!
    @IBOutlet weak var signUpBtn:UIButton!
    @IBOutlet weak var LoginBtn:UIButton!
    @IBOutlet weak var skipBtn:UIButton!
    
    @IBOutlet weak var viewTwo:UIView!
    @IBOutlet weak var labelTwoDotOne:UILabel!
    @IBOutlet weak var labelTwoDotTwo:UILabel!
    @IBOutlet weak var labelTwoDotThree:UILabel!
    @IBOutlet weak var emailBtn:UIButton!
    @IBOutlet weak var facebookBtn:UIButton!
    @IBOutlet weak var skipTwoBtn:UIButton!
    
    @IBOutlet weak var viewThree:UIView!
    @IBOutlet weak var labelThreeDotOne:UILabel!
    @IBOutlet weak var labelThreeDotTwo:UILabel!
    @IBOutlet weak var labelThreeDotThree:UILabel!
    @IBOutlet weak var guestBtn:UIButton!
    @IBOutlet weak var derailLabel:UILabel!
    
    var currentView = ""

    


    override func viewDidLoad() {
        super.viewDidLoad()
        currentView = "First"
        
        viewCreatedOne()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                if currentView == "First"
                    {
                       viewCreatedTwo()
                    }
                else if currentView == "Second"
                {
                    viewCreatedThree()
                }
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                
                
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                if currentView == "Three"
                {
                    viewCreatedTwo()
                }
                else if currentView == "Second"
                {
                    
                    viewCreatedOne()
                }

            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                
                
                
            default:
                break
            }
        }
    }
 func viewCreatedOne()
 {
    currentView = "First"
    viewOne.isHidden = false
    viewTwo.isHidden = true
    viewThree.isHidden = true
    labelDotOne.layer.cornerRadius = 5
    labelDotTwo.layer.cornerRadius = 5
    labelDotThree.layer.cornerRadius = 5
    
    signUpBtn.layer.cornerRadius = 20
    LoginBtn.layer.cornerRadius = 20

    }
    
    func viewCreatedTwo()
    {
        currentView = "Second"
        viewOne.isHidden = true
        viewTwo.isHidden = false
        viewThree.isHidden = true
        labelTwoDotOne.layer.cornerRadius = 5
        labelTwoDotThree.layer.cornerRadius = 5
        labelTwoDotTwo.layer.cornerRadius = 5
        
        facebookBtn.layer.cornerRadius = 20
        emailBtn.layer.cornerRadius = 20
        
    }
    
    func viewCreatedThree()
    {
        currentView = "Three"
        viewOne.isHidden = true
        viewTwo.isHidden = true
        viewThree.isHidden = false
        labelThreeDotOne.layer.cornerRadius = 5
        labelThreeDotThree.layer.cornerRadius = 5
        labelThreeDotTwo.layer.cornerRadius = 5
        
        guestBtn.layer.cornerRadius = 20
        
        
        let text = "By continuing, you agree to our terms and privacy"
        let textOne = "and "
        let textTwo = "privacy"

        let textRange = NSMakeRange(0,49)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        
//        let attributedTextOne = NSMutableAttributedString(string: textOne)
//
//        let textRangeTwo = NSMakeRange(0,7)
//        let attributedTextTwo = NSMutableAttributedString(string: textTwo)
//        attributedTextTwo.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRangeTwo)
//
//
//        attributedText.append(attributedTextOne)
//        attributedText.append(attributedTextTwo)

        derailLabel.attributedText = attributedText
        
        
        
    }
    
    @IBAction func btnloginfacebookclick(_ sender: Any)
    {
        UserDefaults.standard.set("fb", forKey: "socialLogin")
        UserDefaults.standard.synchronize()
        if !common.isConnectedToInternet()
        {
            self.app_delegate.setUIBlockingEnabled(false)
            common.showPositiveMessage(message: "Please check your internet connection.")
            return
        }
        
        
        if FBSDKAccessToken.current() == nil
        {
            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
                if (error == nil)
                {
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    // if user cancel the login
                    if (result?.isCancelled)!{
                        return
                    }
                    
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        print(FBSDKAccessToken.current().tokenString)
                        let userDefaults = UserDefaults.standard
                        userDefaults .set(FBSDKAccessToken.current().tokenString, forKey: "Accesstoken")
                        print(UserDefaults.standard.object(forKey: "Accesstoken") as Any)
                        userDefaults.synchronize()
                        
                    }
                }
            }
        }
    }
    
    func getFBUserData()
    {
        app_delegate.setUIBlockingEnabled(true)
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name,birthday,gender, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil)
                {
                    //everything works print the user data
                    print(result as Any)
                    
                    
                    self.loginWithSocial(dicJson: result as! NSDictionary)
                    
                    
                    
                    print(result as Any)
                }
            })
        }
    }
    
    
    
    func loginWithSocial(dicJson: NSDictionary)
    {
        
        print(dicJson)
        if !common.isConnectedToInternet()
        {
            self.app_delegate.setUIBlockingEnabled(false)
            common.showPositiveMessage(message: "Please check your internet connection.")
            return
        }
        
        let userdata = dicJson as NSDictionary!
        
        
        
        
        let fbuser_id: String? = userdata?.object(forKey: "id") as? String
        let firstname: String? = userdata?.object(forKey: "first_name") as? String
        let lastname: String? = userdata?.object(forKey: "last_name") as? String
        let email: String? = userdata?.object(forKey: "email") as? String
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        let UDID = UIDevice.current.identifierForVendor?.uuidString
        
        
        
        let params =  ["userid":fbuser_id,"email":email,"firstname":firstname,"lastname":lastname,"social_type":"facebook","action":Cager.User.social_login,"type":"Coach"]as [String : Any]
        
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
                        
                        
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        UserDefaults.standard.synchronize()
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
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
                    
                }
        }
    }
    
    @IBAction func btnGoogleplusClick(_ sender: Any)
    {
        performSegue(withIdentifier: "showThecontrollerEmail", sender: self)
        
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()
//        GIDSignIn.sharedInstance().delegate = self
    }
    
    func Signout()
    {
        GIDSignIn.sharedInstance().signOut()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if error == nil
        {
            let userId: String = user.userID
            let idToken: String = user.authentication.idToken
            let fullName: String = user.profile.name
            let givenName: String = user.profile.givenName
            let familyName: String = user.profile.familyName
            let email: String = user.profile.email
            let images = user.profile.imageURL(withDimension: 120)
            
            print("\(userId)")
            print("\(idToken)")
            print("\(fullName)")
            print("\(givenName)")
            print("\(email)")
            print("\(String(describing: images))")
            print("\(familyName)")
            
            dic = [String: Any]()
            dic["userid"] = userId
            dic["email"] = email
            dic["fullname"] = fullName
            dic["email"] = email
            dic["first_name"] = givenName
            dic["last_name"] = familyName
            
            self.loginWithgoogleSocial(googledic: dic as NSDictionary)
        }
        else
        {
            print((error.localizedDescription))
        }
    }
    
    
    func loginWithgoogleSocial(googledic: NSDictionary)
    {
        
        print(googledic)
        if !common.isConnectedToInternet()
        {
            common.showPositiveMessage(message: "Please Check internet connectivity")
            return
        }
        
        let userdata = googledic as NSDictionary!
        
        let googleuser_id: String? = userdata?.object(forKey: "userid") as? String
        let fullname: String? = userdata?.object(forKey: "fullname") as? String
        let birthdob: String? = userdata?.object(forKey: "birthday") as? String
        let email: String? = userdata?.object(forKey: "email") as? String
        let gender: String? = userdata?.object(forKey: "gender") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        
        
        let params =  ["userid":googleuser_id,"email":email,"firstname":fullname,"lastname":"","social_type":"google","action":Cager.User.social_login,"type":"Coach"]as [String : Any]
        
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
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
                        
                        
                        
                        UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        UserDefaults.standard.synchronize()
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
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
                    common.showPositiveMessage(message: "Server Is Busy Try Later")
                }
        }
    }
    
    @IBAction func btnguestUserACtion(_ sender: Any)
    {
      //  UserDefaults.standard.set("1", forKey: "user_id")
      //  UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set("Yes", forKey: "loginStatus")
        UserDefaults.standard.synchronize()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC")
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    @IBAction func btnActionSkip(_ sender: Any)
    {
       viewCreatedThree()
    }
    
    

}
