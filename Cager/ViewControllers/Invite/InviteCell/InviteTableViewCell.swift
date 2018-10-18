//
//  InviteTableViewCell.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {
    
    //MARK:-  Outlets And Variable Declaration
    
    @IBOutlet weak var lblNameLogo: ZWLabel!
    @IBOutlet weak var lblInvityName: UILabel!
    @IBOutlet weak var lblTotalFriends: UILabel!
    @IBOutlet weak var btnInvite: ZWButton!
    
    //MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
