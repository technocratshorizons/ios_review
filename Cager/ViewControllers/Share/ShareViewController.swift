//
//  ShareViewController.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onClickBtnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
