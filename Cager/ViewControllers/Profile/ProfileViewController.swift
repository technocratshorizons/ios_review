//
//  ProfileViewController.swift
//  Cager
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARk:-  Outlets And Variable Declaration
    @IBOutlet weak var switchFacebook: UISwitch!
    @IBOutlet weak var switchTwitter: UISwitch!
    @IBOutlet weak var switchGoogle: UISwitch!
    var imagePicker =  UIImagePickerController()

    @IBOutlet weak var labelemailAddress: UILabel!
    @IBOutlet weak var textuserName: UILabel!

   // @IBOutlet weak var textuserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    var imageChanged = String()

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var editBtn: UIButton!

    @IBOutlet weak var imageBtn: UIButton!


    let app_delegate = UIApplication.shared.delegate as! AppDelegate

    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBtn.isUserInteractionEnabled = false
        imageChanged = ""

        imagePicker.delegate = self

        getProfileData()
    }
   
    
    @IBAction func btnEditCLick(_ sender: Any)
    {
        if editBtn.tag == 101
        {
            editBtn.tag = 102
            imageBtn.isUserInteractionEnabled = true
            editBtn.setImage(UIImage(named: "Story_Check_Icon.png"), for: .normal)
        }
        else
        {
            editBtn.tag = 101
            imageBtn.isUserInteractionEnabled = false
            editBtn.setImage(UIImage(named: "ic_editprofile.png"), for: .normal)
            btnSaveclick()

        }
        
    }
     func getProfileData() {
      //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String

        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let params =  ["user_id":userId!,"action":Cager.User.get_profile]as [String : Any]
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
                    //    UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        
                        if dicData?.value(forKey: "picture") as! String != ""{
                            
                        }
                        
                        if dicData?.value(forKey: "cover_picture") as! String != ""{
                            
                        }
                        if dicData?.value(forKey: "social_type") as! String != ""{
                         self.switchFacebook.setOn(false, animated: true)
                            self.switchTwitter.setOn(false, animated: true)
                            self.switchGoogle.setOn(false, animated: true)
                        }
                        
                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
                        UserDefaults.standard.set(dicData?.value(forKey: "picture"), forKey: "picture")

                        UserDefaults.standard.synchronize()
                        
                        let url =  URL(string:dicData?.object(forKey: "picture") as! String)
                        
                        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named:"activity_default_"), options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: nil)
                        

                        self.textuserName.text =  dicData?.value(forKey: "first_name") as! String
                        self.labelemailAddress.text =  dicData?.value(forKey: "email") as! String

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
    
    @IBAction func updateUserProfileData(_ sender : Any) {
        //  self.navigationController?.popViewController(animated: true)
        
        self.app_delegate.setUIBlockingEnabled(true)
        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String
        
        let urlRequest = String(format: "%@",Cager.Api.developpementBase)
        print(urlRequest)
        print(userId!)
        let params =  ["user_id":userId!,"action":Cager.User.edit_profile]as [String : Any]
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
                        //    UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                        
                        if dicData?.value(forKey: "picture") as! String != ""{
                            
                        }
                        
                        if dicData?.value(forKey: "cover_picture") as! String != ""{
                            
                        }
                        if dicData?.value(forKey: "social_type") as! String != ""{
                            self.switchFacebook.setOn(false, animated: true)
                            self.switchTwitter.setOn(false, animated: true)
                            self.switchGoogle.setOn(false, animated: true)
                        }
                        
                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
                        UserDefaults.standard.synchronize()
                        
                        self.textuserName.text =  dicData?.value(forKey: "first_name") as! String
                        self.labelemailAddress.text =  dicData?.value(forKey: "email") as! String
                        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabControllerSegue"
        {
        }
    }
    
    @IBAction func btnpofileclick(_ sender: Any)
    {
                self.view.endEditing(true)
        
                //MARK:- here are editing hight
              //  editeventscroll.contentSize = CGSize(width: self.view.frame.width, height: btnCancel.frame.maxY+50)
        
                let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
        
                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallary()
                }))
        
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
                self.present(alert, animated: true, completion: nil)

    }
    
    
    func openCamera()
    {
       
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            common.showPositiveMessage(message: "You don't have camera")
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
      
        imageChanged = "Yes"
        
        profileImage.image = common.resizeImage(image: info[UIImagePickerControllerEditedImage] as! UIImage)
        dismiss(animated: true, completion: nil)
    }

    func btnSaveclick()
    {
        if !common.isConnectedToInternet()
        {
            self.app_delegate.setUIBlockingEnabled(false)
            common.showPositiveMessage(message: "You don't have camera")
            return
        }
        self.app_delegate.setUIBlockingEnabled(true)

        let userId: String? = UserDefaults.standard.string(forKey: "user_id") as? String

        var userData = [String: String]();

        userData["user_id"] = userId
        userData["action"] = Cager.User.edit_profile
        userData["first_name"] = textuserName.text
       
        Alamofire.upload(multipartFormData: { multipartFormData in

            let NewImageData = UIImagePNGRepresentation(self.profileImage.image!)! as Data

            if self.imageChanged == "Yes"
            {
                if NewImageData != nil
                {
                    multipartFormData.append(NewImageData, withName: "picture", fileName: "adaad.jpg", mimeType: "image/jpg")
                }
            }

            for (key, value) in userData
            {
                multipartFormData.append(((value).data(using: .utf8))!, withName: key)
            }}, to: Cager.Api.developpementBase, method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        upload.responseJSON
                            { response in

                                if response.result.isSuccess
                                {
                                    let ShortDic = response.result.value as! NSDictionary
                                    let item2 = ShortDic.value(forKey: "success") as! NSNumber

                                    if item2 == 1
                                    {
                                        let dicData = ShortDic.value(forKey: "data") as! NSDictionary!
                                        
                                        //    UserDefaults.standard.set(dicData?.value(forKey: "id"), forKey: "user_id")
                                        
                                        if dicData?.value(forKey: "picture") as! String != ""{
                                            
                                        }
                                        
                                        if dicData?.value(forKey: "cover_picture") as! String != ""{
                                            
                                        }
                                        if dicData?.value(forKey: "social_type") as! String != ""{
                                            self.switchFacebook.setOn(false, animated: true)
                                            self.switchTwitter.setOn(false, animated: true)
                                            self.switchGoogle.setOn(false, animated: true)
                                        }
                                        
                                        UserDefaults.standard.set(dicData?.value(forKey: "first_name"), forKey: "fullName")
                                        UserDefaults.standard.synchronize()
                                        
                                        self.textuserName.text =  dicData?.value(forKey: "first_name") as! String
                                        self.labelemailAddress.text =  dicData?.value(forKey: "email") as! String
                                        
                                        self.app_delegate.setUIBlockingEnabled(false)
                                        self.navigationController?.popViewController(animated: true)
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
                                    //   common.showPositiveMessage(message: "Response error")

                                }

                        }
                    case .failure( _):

                        self.app_delegate.setUIBlockingEnabled(false)

                        break

                    }

        }
        )
        
          // performSegue(withIdentifier: "Editevent", sender: self)
    }
}
