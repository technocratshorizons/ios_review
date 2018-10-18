//
//  aboutUsViewController.swift
//  Cager
//
//  Created by SAGAR MODI on 01/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire

class aboutUsViewController: UIViewController {
    
    @IBOutlet weak var aboutLabel: UILabel!
    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        getAboutUsData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getAboutUsData() {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let params =  ["user_id":userId!,"action":Cager.User.about_us]as [String : Any]
        print(params)
        Alamofire.request( urlRequest, method: .post, parameters:params , encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                
                if response.result.isSuccess
                {
                    let ShortDic = response.result.value as! NSDictionary
                    let item2 = ShortDic.value(forKey: "success") as! NSNumber
                    
                    if item2 == 1
                    {
                        print(ShortDic)
                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                        self.aboutLabel.attributedText = "\(dicData?.value(forKey: "body_html") as! String)".convertHtml()
                       
                        
                        self.app_delegate.setUIBlockingEnabled(false)
                        
                    }
                    else
                        
                    {
                        self.app_delegate.setUIBlockingEnabled(false)
                        common.showPositiveMessage(message: ShortDic.value(forKey: "message") as! String)
                    }
                }
                else
                {
                    self.app_delegate.setUIBlockingEnabled(false)
                    common.showPositiveMessage(message: "server not respond yet please try after some time!!!")
                    
                }
        }
    }

}
extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
           // return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
            
        }catch{
            return NSAttributedString()
        }
    }
}
