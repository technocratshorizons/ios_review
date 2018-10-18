//
//  ViewController.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:-  Outlets And variable Declaration
    @IBOutlet weak var tblInvite: UITableView!
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCell()
    }
    func loadCell() {
        
        let cell = UINib(nibName: "InviteTableViewCell", bundle: nil)
        tblInvite.register(cell, forCellReuseIdentifier: "InviteTableViewCell")
        
    }
    //MARK:-  UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblInvite.dequeueReusableCell(withIdentifier: "InviteTableViewCell", for: indexPath) as! InviteTableViewCell
        return cell        
    }
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

