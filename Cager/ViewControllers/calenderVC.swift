//
//  calenderVC.swift
//  Cager
//
//  Created by mac on 20/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit



class calenderVC: UIViewController {
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSubmit.layer.cornerRadius = 15.0
        // 1. You must instantiate with the class function instantiate()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
