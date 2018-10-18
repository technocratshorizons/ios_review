

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import TwitterKit
import Alamofire
import Google
import GoogleSignIn

class SignInViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {

    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSign: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
    var dic = [AnyHashable: Any]()
    var dicTwitter = [AnyHashable: Any]()

    var blurEffectView = UIVisualEffectView()
    
    
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Username",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    fileprivate func initialSetup() {

        btnSign.layer.cornerRadius = 25
        
    }
    
    
    
    @IBAction func btnActionSignUp(_ sender: Any) {
    }
    
    @IBAction func btnActionSignIn(_ sender: Any) {

        
        if !common.isConnectedToInternet()
        {
            self.app_delegate.setUIBlockingEnabled(false)
            common.showPositiveMessage(message: "Please check your internet connection.")
            return
        }

        if txtUsername.text?.count == 0
        {
            common.showPositiveMessage(message:"Please fill all field")
            return
        }
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: txtUsername.text)
        
        if !result
        {
            common.showPositiveMessage(message: "Please fill valid email")
            return
        }
        
        if (txtPassword.text?.count)! <= 4
        {
            common.showPositiveMessage(message: "Minimum Password length must be 5.")
            return
        }
        app_delegate.setUIBlockingEnabled(true)
      
        
     //   let deviceToken:String = UserDefaults.standard.object(forKey: Copines.Key.deviceToken) as! String
        let password: String? = txtPassword.text
        let email: String? = txtUsername.text
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        let UDID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        print(UDID)
        let params =  ["email":email!,"password":password!,"action":Cager.User.login]as [String : Any]
        
        
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
                        if dicData?.value(forKey: "picture") as? String != nil{
                            if dicData?.value(forKey: "picture") as! String != ""
                            {
                                UserDefaults.standard.set(dicData?.value(forKey: "picture"), forKey: "picture")
                            }
                        
                        }
                        
                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
                        UserDefaults.standard.set("Yes", forKey: "loginStatus")

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
                    common.showPositiveMessage(message: "server not respond yet please try after some time!!!")
                    
                }
        }
    }

    @IBAction func btnActionForgetPassword(_ sender: Any) {
        
        popUpView.isHidden = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
         blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.bringSubview(toFront: popUpView)
        
    }
   
    @IBAction func btnActionResetPass(_ sender: Any) {
        
        popUpView.isHidden = true
        blurEffectView.removeFromSuperview()
        
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
            print(UDID)

        

            let params =  ["userid":"fbuser_id","email":email,"firstname":"firstname","lastname":lastname,"social_type":"facebook","action":Cager.User.social_login,"type":"Coach"]as [String : Any]

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

                            UserDefaults.standard.set("Yes", forKey: "loginStatus")

                            let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                            UserDefaults.standard.set(0, forKey: "user_id")
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
    
    @IBAction func btnTwitterClick(_ sender: Any)
    {
        self.app_delegate.setUIBlockingEnabled(true)
        UserDefaults.standard.set("Twitter", forKey: "socialLogin")
        UserDefaults.standard.synchronize()
        
        Twitter.sharedInstance().logIn
            {
                (session, error) -> Void in
                if (session != nil) {
                    
                    print(session!.userID)
                    print(session!.userName)
                    print(session!.authToken)
                    print(session!.authTokenSecret)
                    
                    
                    let userId: String = session!.userID
                    let AuthToken: String = session!.authToken
                    let fullName: String = session!.userName
                    let Authtokensecret: String = session!.authTokenSecret
                    
                    
                    
                    self.dicTwitter = [String: Any]()
                    self.dicTwitter["userid"] = userId
                    self.dicTwitter["AuthToken"] = AuthToken
                    self.dicTwitter["fullname"] = fullName
                    self.dicTwitter["Authtokensecret"] = Authtokensecret
                    
                    
                    let client = TWTRAPIClient.withCurrentUser()
                    
                    client.requestEmail { email, error in
                        if (email != nil)
                        {
                            print("signed in as \(String(describing: email))");
                            
                            self.dicTwitter["email"] = email
                            
                            self.loginWithTwitterSocial(Twitterdic:self.dicTwitter as NSDictionary)
                            
                        }
                        else
                        {
                            print("error: \(String(describing: error?.localizedDescription))");
                        }
                    }
                }
                else
                {
                    print("Not Login")
                }
        }
        
    }
    
    func loginWithTwitterSocial(Twitterdic: NSDictionary)
    {
        
        print(Twitterdic)
        
        if !common.isConnectedToInternet()
        {
            common.showPositiveMessage(message: "Please Check internet connectivity")
            return
        }

        let userdata = Twitterdic as NSDictionary!
        
        

        let Twitteruser_id: String? = userdata?.object(forKey: "userid") as? String
        let fullname: String? = userdata?.object(forKey: "fullname") as? String
        let email: String? = userdata?.object(forKey: "email") as? String

        let urlRequest = String(format: "%@",Cager.Api.developpementBase)


        let params =  ["userid":Twitteruser_id,"email":email,"firstname":fullname,"lastname":"","social_type":"twitter","action":Cager.User.social_login,"type":"Coach"]as [String : Any]
        
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
                        UserDefaults.standard.set("Yes", forKey: "loginStatus")

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
                    common.showPositiveMessage(message: "Server Is Busy Try Later")
                }
        }
    }
    
    
    @IBAction func btnGoogleplusClick(_ sender: Any)
    {
        self.app_delegate.setUIBlockingEnabled(true)

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
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
                        UserDefaults.standard.set("Yes", forKey: "loginStatus")


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
    @IBAction func jstBack(_ sender: Any)
        
    {
        navigationController?.popViewController(animated: true)
    }
}


