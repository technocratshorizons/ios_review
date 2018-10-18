//
//  tabBarVC.swift
//  Cager
//
//  Created by mac on 19/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class tabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.items![2].image = UIImage(named: "your image name")
        // items![0] index of your tab bar item.items![0] means tabbar first item
        
        self.tabBarController?.tabBar.items![2].selectedImage = UIImage(named: "your image name")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
