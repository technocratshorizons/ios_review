import UIKit
import LocalAuthentication
import Alamofire
import SwiftyJSON
import SystemConfiguration
import RMessage
class Cager {
    
 //   static var deviceToken:String?
    
    struct Color {
        static let gray         = "#B8C2C7"
        static let blue         = "#007AFF"
        static let green        = "#7ED321"
        static let red          = "#FB350B"
        static let orange       = "#F3841C"
        static let yellow       = "#F9D641"
        static let cream        = "#F8F8F4"
        static let darkGray     = "#515151"
    }
    

    struct Api {
   
       // static let developpementBase = "http://dretail.laxmayatesting.online/webapi/webservices.php"
//        static let developpementBase = "http://laxmayatechnologies.com/webapi/webservices.php"
//        static var base = Cager.Api.developpementBase
//        static let termsCondtion = "http://Cagerdesortie.com/legals.html"
        
        static let developpementBase = ""
        static var base = Cager.Api.developpementBase
        static let termsCondtion = ""

    }
    struct User {
        static var social_login = "social_login"
        static var register = "register"
        static var login = "login"
        static var verify_email = "verify_email"
        static var generate_code = "generate_code"
        static var get_profile = "get_profile"
        static var edit_profile = "edit_profile"
        static var hot_deals = "hot_deals"

        static var explore_list = "explore_list"
        static var deals_near_me = "deals_near_me"
        static var about_us = "about_us"
        static var faq = "faq"
        static var save_for_later = "save_for_later"
        static var create_order = "create_order"
        static var reserve_order = "reserve_order"
        static var get_facilist = "get_facilist"

        static var support = "support"


        static var explore_detail_list = "explore_detail_list"


        
        static var updateLocation = "\(Cager.Api.base)update_user_lat_lng"
        static var forgot_password = "\(Cager.Api.base)forgot_password"
        static var edit_user_language = "\(Cager.Api.base)edit_user_language"
        static var devicetokenupdate = "\(Cager.Api.base)devicetokenupdate"
        static var general_setting = "\(Cager.Api.base)general_setting"

        static var favorite_list = "\(Cager.Api.base)favorite_list"
        static var favorite_request = "\(Cager.Api.base)favorite_request"
        static var search_favorite = "\(Cager.Api.base)search_favorite"
        
        static var get_interests = "\(Cager.Api.base)get_interests"
        static var change_password = "\(Cager.Api.base)change_password"
        static var edit_interest = "\(Cager.Api.base)edit_interest"
        static var my_agenda = "\(Cager.Api.base)my_agenda"
        static var chat_list = "\(Cager.Api.base)chat_list"
        static var init_chat = "\(Cager.Api.base)init_chat"
        static var ads_find = "\(Cager.Api.base)ads_find"
        static var adminmessage = "\(Cager.Api.base)adminmessage"
        static var badge_status = "\(Cager.Api.base)badge_status"
        static var delete_badge = "\(Cager.Api.base)delete_badge"
        static var delete_chat = "\(Cager.Api.base)delete_chat"
        static var get_timestamp_delete_chat = "\(Cager.Api.base)get_timestamp_delete_chat"
        static var chat_count = "\(Cager.Api.base)chat_count"
        static var online_status = "\(Cager.Api.base)online_status"

    }
    
    struct Activity {
        
        static var get_activities = "\(Cager.Api.base)get_activities"
        static var join_activity = "\(Cager.Api.base)join_activity"
        static var update_join_activity = "\(Cager.Api.base)update_join_activity"
        static var activity_joiner_list = "\(Cager.Api.base)activity_joiner_list"
        static var activity_joiner_filtered_list = "\(Cager.Api.base)activity_joiner_filtered_list"
        static var unsubscribe_join_activity = "\(Cager.Api.base)unsubscribe_join_activity"
    }
    
    struct Event {
       
        static var user_detail = "\(Cager.Api.base)user_detail"
        static var coming_event_filter = "\(Cager.Api.base)coming_event_filter"
        static var coming_event = "\(Cager.Api.base)coming_event"
        static var my_event = "\(Cager.Api.base)my_event"
        static var create_event = "\(Cager.Api.base)create_event"
        static var event_detail = "\(Cager.Api.base)event_detail"
        static var comment_event = "\(Cager.Api.base)comment_event"
        static var join_event = "\(Cager.Api.base)join_event"
        static var unsubscribe_join_event = "\(Cager.Api.base)unsubscribe_join_event"
        static var report_event = "\(Cager.Api.base)report_event"
        static var edit_event = "\(Cager.Api.base)edit_event"
        static var remove_event = "\(Cager.Api.base)remove_event"
        static var join_event_noti = "\(Cager.Api.base)join_event_noti"
        static var comment_event_noti = "\(Cager.Api.base)comment_event_noti"
        static var chat_notification = "\(Cager.Api.base)chat_notification"
        static var report_user = "\(Cager.Api.base)report_user"
        static var update_msg_read_status = "\(Cager.Api.base)update_msg_read_status"

    }
    
    struct Profil {
        static var user_detail = "\(Cager.Api.base)user_detail"
        static var coming_event_filter = "\(Cager.Api.base)coming_event_filter"
        static var edit_profile = "\(Cager.Api.base)edit_profile"
        static var remove_account = "\(Cager.Api.base)remove_account"
        static var unblock_request = "\(Cager.Api.base)unblock_request"
        static var edit_about_me = "\(Cager.Api.base)edit_about_me"
        static var block_request = "\(Cager.Api.base)block_request"
        static var favorite_request = "\(Cager.Api.base)favorite_request"
        static var search_favorite = "\(Cager.Api.base)search_favorite"
        static var favorite_list = "\(Cager.Api.base)favorite_list"
        static var max_joiner_list = "\(Cager.Api.base)max_joiner_list"

        
    }
    
   
    struct Key {
        static var deviceToken = "deviceToken"
        static var user = "USER_DATA"
        static var facebookRegister = "FACEBOOK_REGISTER"
        static var eventType = "EVENT"
        static var badgeType = "BADGE"
    
        
    }
    
    struct PushNotification {
        static let categoryEvent = "A_EVENT"
        static let showEvent = "SHOW_EVENT"
      

    }
    
    struct DataDefaults {
        static let userProfile = "profiles/default_profile.png"
        static let userCover = "covers/default_cover.png"
        static let statCount = "—"
    }
    
    struct FilterEvent {
        static let types = ["Sortie", "Service", "Sport", "Évènement", "Lieux", "Rencontre", "Achat - Vente", "Job", "Immobilier", "Animaux", "Promotions", "Autres"]
   }
    
    class func updateApi() {
       
    }
    
    class func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        if #available(iOS 9.0, *) {
            switch errorCode {
                
            case LAError.appCancel.rawValue:
                message = "Authentication was cancelled by application"
                
            case LAError.authenticationFailed.rawValue:
                message = "The user failed to provide valid credentials"
                
            case LAError.invalidContext.rawValue:
                message = "The context is invalid"
                
            case LAError.passcodeNotSet.rawValue:
                message = "Passcode is not set on the device"
                
            case LAError.systemCancel.rawValue:
                message = "Authentication was cancelled by the system"
                
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.userCancel.rawValue:
                message = "The user did cancel"
                
            case LAError.userFallback.rawValue:
                message = "The user chose to use the fallback"
                
            default:
                message = "Did not find error code on LAError object"
                
            }
        } else {
            // Fallback on earlier versions
        }
        return message
    }
    
    class func debugResponse(_ response:DataResponse<Any>) {
        print("Success: \(response.result.isSuccess)")
        print("Response String: \(String(describing: response.result.value))")
        
        var statusCode = response.response?.statusCode
        if let error = response.result.error as? AFError {
            statusCode = error._code // statusCode private
            switch error {
            case .invalidURL(let url):
                print("Invalid URL: \(url) - \(error, CFCopyDescription)")
            case .parameterEncodingFailed(let reason):
                print("Parameter encoding failed: \(error, CFCopyDescription)")
                print("Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("Multipart encoding failed: \(error, CFCopyDescription)")
                print("Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("Response validation failed: \(error, CFCopyDescription)")
                print("Failure Reason: \(reason)")
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                    statusCode = code
                }
            case .responseSerializationFailed(let reason):
                print("Response serialization failed: \(error, CFCopyDescription)")
                print("Failure Reason: \(reason)")
                // statusCode = 3840 ???? maybe..
            }
            
            print("Underlying error: \(error.underlyingError!)")
        } else if let error = response.result.error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(String(describing: response.result.error))")
        }
        
        print(statusCode ?? "No status code") // the status code
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func showSuccess(_ title:String) {
        RMessage.showNotification(withTitle: title, subtitle: nil, type: .success, customTypeName: nil, callback: nil)
    }
    
    class func showSuccess(title:String, subTitle:String?, navBarOverlay:Bool = false) {
        if navBarOverlay == false {
            RMessage.showNotification(withTitle: title, subtitle: subTitle, type: .success, customTypeName: nil, callback: nil)
        }
        else {
            RMessage.showNotification(withTitle: title, subtitle: subTitle, iconImage: nil, type: .success, customTypeName: nil, duration: TimeInterval(RMessageDuration.automatic.rawValue), callback: nil, buttonTitle: nil, buttonCallback: nil, at: RMessagePosition.navBarOverlay, canBeDismissedByUser: true)
        }
    }
    
    class func showSuccess(in viewController: UIViewController, title:String, subTitle:String?, navBarOverlay:Bool = false) {
        if navBarOverlay == false {
            RMessage.showNotification(in: viewController, title: title, subtitle: subTitle, type: .success, customTypeName: nil, callback: nil)
        }
        else {
            RMessage.showNotification(in: viewController, title: title, subtitle: subTitle, iconImage: nil, type: .success, customTypeName: nil, duration: TimeInterval(RMessageDuration.automatic.rawValue), callback: nil, buttonTitle: nil, buttonCallback: nil, at: RMessagePosition.navBarOverlay, canBeDismissedByUser: true)
        }
    }
    
    class func showInfo(title:String, subTitle:String?, navBarOverlay:Bool = false) {
        if navBarOverlay == false {
            RMessage.showNotification(withTitle: title, subtitle: subTitle, type: .normal, customTypeName: nil, callback: nil)
        }
        else {
            RMessage.showNotification(withTitle: title, subtitle: subTitle, iconImage: nil, type: .normal, customTypeName: nil, duration: TimeInterval(RMessageDuration.automatic.rawValue), callback: nil, buttonTitle: nil, buttonCallback: nil, at: RMessagePosition.navBarOverlay, canBeDismissedByUser: true)
        }
    }
    
    
    class func showError(_ subTitle:String, error:String? = nil, customTitle:String? = nil) {
        var subTitle = subTitle
        if error != nil {
            subTitle = String(format:subTitle + "(code d’erreur : %@)" , error!)
        }
        RMessage.showNotification(withTitle: customTitle ?? "Erreur" , subtitle: subTitle, type: .error, customTypeName: nil, callback: nil)
    }
    
    class func showError(in viewController:UIViewController, subTitle:String, error:String? = nil, customTitle:String? = nil) {
        var subTitle = subTitle
        if error != nil {
            subTitle = String(format:subTitle + "(code d’erreur : %@)" , error!)
        }
        RMessage.showNotification(in: viewController, title: customTitle ?? "Erreur" , subtitle: subTitle, type: .error, customTypeName: nil, callback: nil)
    }
    
    class func post(_ url:String, _ params : [String:Any]?, _ debug:Bool = false, _ success:@escaping (Bool, JSON) -> Void, _ failure:((Error) -> Void)? = nil) {
        
        if debug == true {
             
        }
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { response in
            
            
            switch response.result {
            case .failure(let error):
                if let data = response.data {
                    let response_string = String(data: data, encoding: String.Encoding.utf8)
                    var parameters_string = ""
                    for (key, value) in params! {
                        parameters_string += "\(key):\(value)\n"
                    }
                     

                }
                if debug == true {
                     
                }
                
                // Success closure is needed, so it's called with false to show simple error label
                success(false, JSON([:]))
                
                // And, if set, failure is set with error object
                failure?(error)
            case .success(let value):
                let json = JSON(value)
                if debug == true {
                  
                }
                if json["error"].boolValue == true {
                    if json["message"] != JSON.null {
                         Cager.showError(json["message"].stringValue)
                    }
                    success(false, json)
                }
                else {
                    success(true,json)
                    
                }
            }
        }
    }
    
    class func get(Url url:String, withSuccess success:@escaping(Bool, JSON)-> Void, andfailure failure:@escaping ((String) -> Void)) {
        
        let urlEncode = URL(string: url)!;
        
        Alamofire.request(urlEncode, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            print(response.result)
            
            switch response.result{
                
            case .success(let successValue):
                
                let receivedJSON = JSON(successValue)
                let sendValue = receivedJSON["Response"]
                success(true, receivedJSON)
                
                print(sendValue)
                
                break
                
            case .failure(let error):
                failure("\(error)")
                break
            }
        }
    }
    
    class func post(_ url : String, _ params : [String:Any]?, _ success:@escaping (Bool, JSON) -> Void) {
         Cager.post(url, params, false, success, nil)
    }
    class func dpost(_ url : String, _ params : [String:Any]?, _ success:@escaping (Bool, JSON) -> Void) {
         Cager.post(url, params, true, success, nil)
    }
}

public struct People {
    var name : String!
    var count : Int!
}

public struct Duration {
    var name : String!
    var duration : Double!
}

public enum FriendState:Int {
    case notFriend = 0
    case waitingForUserReply = 1
    case waitingForFriendReply = 2
    case friend = 3
    case declined = 4
    case unknown = -1
    case me = -2
}
