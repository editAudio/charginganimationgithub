//
//  Constants.swift
//  English4Kids
//
//  Created by Dong Nguyen on 4/3/18.
//  Copyright © 2018 Dong Nguyen. All rights reserved.
//

import UIKit

let LIMIT_PRENIUM = 2
let ANIMATION_DEFAULT = "04E6D715-F489-4A02-84A8-3086E9C5FD54"
let UIIMAGE_DEFAULT = UIImage(named: "ic_splash")
let TABBAR_COLOR = UIColor(named: "dodgerBlue1")
let BUTTON_COLOR = UIColor(named: "ButtonColor")
let COLOR_APP = UIColor(named: "ColorApp")
let NAVI_COLOR = UIColor.white
let TINT_COLOR = UIColor.init(hex: "4DBFE4")
let TEXT_COLOR = UIColor.init(hex: "89B3FF")
let WHITE_COLOR = UIColor.white
var IMAGE_RESIZE = CGSize.init(width: 640, height: 640)
let LINK_ANIMATION = "ANIMATION"
let LINK_SOUND = "SOUND"
let LINK_IMAGES = "IMAGES"
let LINK_TERM = "https://sites.google.com/view/charginganimation-show/terms-and-condition"
let LINK_PRICAVY = "https://sites.google.com/view/charginganimation-show/privacy-policy"
let LINK_SUPPORT = "https://sites.google.com/view/charginganimation-show/support"

let PERCENT = 0.1
let GG_API_KEY = "AIzaSyCFJY_lBAFj2-i_D_t-njETKUitQOYvHS8"
let GG_ID = "147145222415-kpotob1tai30m01ekl895v33oo4kqmk8.apps.googleusercontent.com"
let MAX_RESULT = 20
let DATE_API_DEFAULT = "yyyy-MM-dd HH:mm:ss"
let DATE_TIME_FORMAT = "HH:mm MM/dd/yyyy"
let DATE_FORMAT = "yyyy-MM-dd"
let TIME_FORMAT = "HH:mm"
let DATE_TICKET_FORMAT = "MM/dd/yyyy"
let DATE_APP_FORMAT = "dd/MM/yyyy"
let DATETIME_APP_FORMAT = "MM/dd/yyyy HH:mm:ss"
let LINK_ZALO = "https://zalo.me/0866929906"
let LINK_MESSGER = "fb-messenger://user-thread/"
let ID_MESSGER = "DaysheeCosmetics"
let POLICY_WEBSITE = "https://dayshee.com/public/policy/index.html"
let HDSD_WEBSITE = "https://dayshee.com/public/policy/hdsd.html"

//MARK:- STATUS ORDER
let STATUS_ORDER_PENDING = 1;
let STATUS_ORDER_APPROVE = 2;
let STATUS_ORDER_UNPAID = 3;
let STATUS_ORDER_PAID = 4;
let STATUS_ORDER_SHIPPING = 5;
let STATUS_ORDER_DELIVERED = 6;
let STATUS_ORDER_CANCELED = 7;


//MARK:- ENUM
enum UserDefaultKey: String, CaseIterable {
    case kAccessToken = "ACCESS_TOKEN"
    case kUserID = "kUserID"
    case kCurUser = "USER"
    case kAddress = "ADDRESS"
    case kEmail = "didEmailUser"
    case kPassword = "didPasswordUser"
    case kName = "didNameUser"
    case kFacebookId = "didFacebookIdUser"
    case kGoogleId = "didGoogleIdUser"
    case kAvatar = "didAvatarUser"
    case kCompleteGuide = "kCompleteGuide"
    case kCurrentAppVersion = "kCurrentAppVersion"
    case kUserInToken = "kUserInToken"
    case kStates = "kStates"
    case kPassWord = "kPassWord"
    case kMessenger = "kMessenger"


}

let MAX_IMAGE_UPLOAD = 3
func jsonToString(json: [[String: Any]]) -> String?{
       do {
           let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
           let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
           return convertedString

       } catch let myJSONError {
           print(myJSONError)
           return nil
       }

   }


