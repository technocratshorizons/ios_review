

import UIKit
import QuartzCore

@IBDesignable class HeaderView: UIView {
    
    private var viewHeight = 64.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.addHeight()
    }

    fileprivate func addHeight() {

        self.translatesAutoresizingMaskIntoConstraints  = false
        if DeviceType.IS_IPHONE_X {
            viewHeight = 88.0
        }
        
        self.removeHeight()
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: CGFloat(viewHeight))
        heightConstraint.identifier = "headerViewHeightConstrain"
        self.addConstraint(heightConstraint)
    }
    
    
    fileprivate func removeHeight() {
        
        for constrain in self.constraints {
            if constrain.identifier  == "headerViewHeightConstrain" {
               self.removeConstraint(constrain)
            }
        }
    }
    
    
}


