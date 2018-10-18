//
//  FDLabel.swift
//

import Foundation
import UIKit

@IBDesignable
class ZWSwitch : UISwitch {
    
    @IBInspectable var OffThumbTintColor: UIColor? {
        didSet {
            self.thumbTintColor = OffThumbTintColor
            self.layer.cornerRadius = 16
        }
    }
}
