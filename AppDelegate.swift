//
//  AppDelegate.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import SwiftGifOrigin
import TwitterKit
import Google
import GoogleSignIn
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
   
    var locationManager = CLLocationManager()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    var blockerView: UIView?
    var activityIndicator: UIActivityIndicatorView?
    var window: UIWindow?
    private let kClientID = "274243021460-ob137m7635mv60k0up5lvdefp1kj64v7.apps.googleusercontent.com"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.setValue(userData, forKey: "userData")
        locManager.requestWhenInUseAuthorization()
        
        
        self.locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        determineMyCurrentLocation()

        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.synchronize()
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        GIDSignIn.sharedInstance().clientID = kClientID
        GIDSignIn.sharedInstance().scopes = ["https://www.googleapis.com/auth/plus.login"]
        
        Twitter.sharedInstance().start(withConsumerKey:"KWhbepH5p9Gh3CYSpUnVLdMyg", consumerSecret:"DVQK9rUD4ZbeUOSnuh8wJpXqqnne5sYBoFIVJ4hQ1irwV8PdZt")
        IQKeyboardManager.sharedManager().enable = true
        
//            PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction : "ATV8ir15j9FzjRo-GqbaPgvvVVcY_YRY6qmhDntOVZ8sIkXoAdnoEVyq6e80gW3kEU9YKb17oQpRhAqC", PayPalEnvironmentSandbox : "YOUR_CLIENT_ID_FOR_SANDBOX"])

        
        if UserDefaults.standard.value(forKey: "loginStatus") != nil
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
            let navigationController = UINavigationController(rootViewController: mainController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        FBSDKAppEvents.activateApp()

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func determineMyCurrentLocation() {
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.locationManager.stopUpdatingLocation()
        let latestLocation = locations.last
        
        let latitude = String(format: "%.4f", latestLocation!.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation!.coordinate.longitude)
        
        UserDefaults.standard.set(latitude, forKey: "applatitude")
        UserDefaults.standard.set(longitude, forKey: "applongitude")
//                UserDefaults.standard.set("0", forKey: "applatitude")
//                UserDefaults.standard.set("0", forKey: "applongitude")
        
        UserDefaults.standard.synchronize()
        
        
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
    }
    
    
    func locationManager(location:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        self.locationManager.stopUpdatingLocation()
        
        let latestLocation = locations.last
        
        let latitude = String(format: "%.4f", latestLocation!.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation!.coordinate.longitude)
        
//        UserDefaults.standard.set(latitude, forKey: "applatitude")
//        UserDefaults.standard.set(longitude, forKey: "applongitude")
        UserDefaults.standard.set("0", forKey: "applatitude")
        UserDefaults.standard.set("0", forKey: "applongitude")
        UserDefaults.standard.synchronize()
        
        
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        
        let latestLocation = locations.last
        
        let latitude = String(format: "%.4f", latestLocation!.coordinate.latitude)
        let longitude = String(format: "%.4f", latestLocation!.coordinate.longitude)
        UserDefaults.standard.set("0", forKey: "applatitude")
        UserDefaults.standard.set("0", forKey: "applongitude")
//        UserDefaults.standard.set(latitude, forKey: "applatitude")
//        UserDefaults.standard.set(longitude, forKey: "applongitude")
        UserDefaults.standard.synchronize()
        
        
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
    
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            manager.startUpdatingLocation()
        }
        else
        {
            manager.requestWhenInUseAuthorization()
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        let defaults: UserDefaults? = UserDefaults.standard
        let namestr = defaults?.object(forKey: "socialLogin") as? String
        
        if (namestr == "Twitter")
        {
            defaults?.removeObject(forKey: "socialLogin")
            defaults?.synchronize()
            return Twitter.sharedInstance().application(app, open: url, options: options)
            
        }
        
        let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        
        if (namestr == "fb")
        {
            defaults?.removeObject(forKey: "socialLogin")
            defaults?.synchronize()
            
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url as URL?, sourceApplication: sourceApplication, annotation: nil)
        }
        else
        {
            return GIDSignIn.sharedInstance().handle(url as URL?, sourceApplication:sourceApplication, annotation: nil)
        }
        
        
    }

    
    func setUIBlockingEnabled(_ enabled: Bool) {
        if enabled {
            
            
            if blockerView == nil {
                blockerView = UIView(frame: (window?.rootViewController?.view.bounds)!)
                // blockerView?.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80)
                // blockerView?.center = (window?.rootViewController?.view.center)!
                blockerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                blockerView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 80))
                activityIndicator?.autoresizingMask = [.flexibleRightMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
                activityIndicator?.center = (blockerView?.center)!
                
                // blockerView?.addSubview(activityIndicator!)
                
                
                
                //   let jeremyGif = UIImage.gif(name: "Eclipse")
                
                // A UIImageView with async loading
                let imageViewdgejnf = UIImageView()
                imageViewdgejnf.loadGif(name: "Eclipse")
                imageViewdgejnf.backgroundColor = UIColor.white
                imageViewdgejnf.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
                imageViewdgejnf.layer.cornerRadius = 20.0
                imageViewdgejnf.center = (blockerView?.center)!
                blockerView?.addSubview(imageViewdgejnf)
                
            }
            activityIndicator?.startAnimating()
            blockerView?.frame = (window?.rootViewController?.view.bounds)!
            //  blockerView?.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80)
            // blockerView?.center = (window?.rootViewController?.view.center)!
            if !(window?.rootViewController?.view.subviews.contains(blockerView!))! {
                window?.rootViewController?.view.addSubview(blockerView!)
            }
        }
        else if (blockerView?.superview != nil) {
            activityIndicator?.stopAnimating()
            blockerView?.removeFromSuperview()
        }
    }



}

