//
//  common.swift
//  Copines
//
//  Created by developer on 30/11/17.
//  Copyright © 2017 SearchTechNow. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class common: NSObject {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
class func showPositiveMessage(message:String)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1.0)
        label.textColor = UIColor.white
        
        label.sizeToFit()
        label.numberOfLines = 4
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        label.frame = CGRect(x: appDelegate.window!.frame.size.width, y: appDelegate.window!.frame.size.height-50, width: appDelegate.window!.frame.size.width, height: 50)
        
        label.alpha = 1
        
        appDelegate.window!.addSubview(label)
        
        var basketTopFrame: CGRect = label.frame;
        basketTopFrame.origin.x = 0;
        
        UIView.animate(withDuration
            :1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                label.frame = basketTopFrame
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration:2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
        
    }
    
    
    
 class func resizeImage(image: UIImage) -> UIImage
 {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 512.0
        let maxWidth: Float = 512.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth
        {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight)) // CGFloat, Double, Int
        print(rect)
        //  let rect = CGRectMake(0.0, 0.0, CGFloat(actualWidth), CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
        print(imageData?.count)
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    
    
    
    
    class func showNegativeMessage(message:String)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor.red
        label.textColor = UIColor.white
        
        label.sizeToFit()
        label.numberOfLines = 4
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        label.frame = CGRect(x: appDelegate.window!.frame.size.width, y: appDelegate.window!.frame.size.height-50, width: appDelegate.window!.frame.size.width, height: 50)
        
        label.alpha = 1
        
        appDelegate.window!.addSubview(label)
        
        var basketTopFrame: CGRect = label.frame;
        basketTopFrame.origin.x = 0;
        
        UIView.animate(withDuration
            :1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                label.frame = basketTopFrame
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration:2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
        
        
    }
    
    
    
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self,quality.rawValue)
    }
    
    
}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    
    public func imageFromServerURL(urlString: String) {

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
               
            })
            
        }).resume()
    }
    
    
    
    
}


extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension String {
    
//    var emojilessStringWithSubstitution: String {
//        let emojiPatterns = [UnicodeScalar(0x1F601)...UnicodeScalar(0x1F64F),
//                             UnicodeScalar(0x2702)...UnicodeScalar(0x27B0)]
//        return self.unicodeScalars
//            .filter { ucScalar in !(emojiPatterns.contains{ $0 ~= ucScalar }) }
//            .reduce("") { $0 + String($1) }
//    }
}

extension UITableView {
  
    var capturedImage : UIImage {
        UIGraphicsBeginImageContext(contentSize);
        scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at:     UITableViewScrollPosition.top, animated: false)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let row = numberOfRows(inSection: 0)
        let numberofRowthatShowinscreen = 2
        let scrollCount = row / numberofRowthatShowinscreen
        
        for i in 0 ..< scrollCount  {
            scrollToRow(at: NSIndexPath(row: (i+1)*numberofRowthatShowinscreen, section: 0) as     IndexPath, at: UITableViewScrollPosition.top, animated: false)
            layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return image;
    }
}

//    var imageView = UIImageView(image:UIImage(named: "homeBg-1"))
//    imageView.backgroundColor = UIColor.red
//    // self.tableExit.backgroundView = imageView
//
//    UIGraphicsBeginImageContextWithOptions(self.tableExit.contentSize, false, UIScreen.main.scale)
//
//    for section in 0..<self.tableExit.numberOfSections {
//    for row in 0..<self.tableExit.numberOfRows(inSection: section) {
//    let indexPath = IndexPath(row: row, section: section)
//    guard let cell = self.tableExit.cellForRow(at: indexPath) else { continue }
//    cell.contentView.drawHierarchy(in: cell.frame, afterScreenUpdates: false)
//    }
//    }
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    imageView.image = image
//    UIGraphicsEndImageContext()

