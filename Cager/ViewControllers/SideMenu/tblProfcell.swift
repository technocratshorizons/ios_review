//
//  tblProfcell.swift
//  Cager
//
//  Created by mac on 19/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class tblProfcell: UITableViewCell {

    @IBOutlet weak var imgMain: UIImageView!
    
    @IBOutlet weak var lblCatagory: UILabel!
    
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
