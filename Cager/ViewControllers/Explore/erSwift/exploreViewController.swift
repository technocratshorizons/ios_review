//
//  exploreViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 27/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class exploreViewController: UIViewController {
    
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var dealsNearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   dealsNearBtn.backgroundColor = UIColor.yellow

        exploreButton.layer.cornerRadius = 30
        
        dealsNearBtn.layer.cornerRadius = 30
       // dealsNearBtn.layer.borderWidth = 1.5
      //  dealsNearBtn.layer.borderColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.75).cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     @IBAction func exploreControllerAction(_ sender: UIButton) {
     //   dealsNearBtn.backgroundColor = UIColor.clear

        performSegue(withIdentifier: "manuallyExplore", sender: nil)
    }
    @IBAction func hotDealsControllerAction(_ sender: UIButton) {
     //   dealsNearBtn.backgroundColor = UIColor.yellow
        performSegue(withIdentifier: "manuallyHotdeals", sender: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "manuallyExplore" {
            if let nextVC = segue.destination as? explorListViewController {
                nextVC.segueIdentifier = segue.identifier!
            }
        }
        else
        {
            if let nextVC = segue.destination as? mapScreenVC {
                nextVC.segueIdentifier = segue.identifier!
            }
        }
        
    }
    
}
