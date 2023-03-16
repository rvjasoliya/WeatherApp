//
//  Global.swift
//  Expire
//
//  Created by iMac on 19/01/23.
//

import Foundation
import UIKit
import SystemConfiguration
import MBProgressHUD

let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
var progressHud = MBProgressHUD()

let appFullName = "WeatherDemo"
let appStoreID = 1111111111
let shareLink = "\(appFullName) \n\n Downlaod : https://itunes.apple.com/app/id\(appStoreID)"
let accountHolder = ""
let appStoreAccountURL = URL(string: "https://itunes.apple.com/us/developer/\(accountHolder)/id\(appStoreID)")!
let appStoreReviewURL = URL(string: "https://itunes.apple.com/app/id\(appStoreID)?mt=8&action=write-review")
let appContactEmail = "ravi.jasoliya333@gmail.com"

func showLoading() {
    DispatchQueue.main.async {
        if progressHud.superview != nil {
            progressHud.hide(animated: false)
        }
        progressHud = MBProgressHUD.showAdded(to: (obj_AppDelegate.window?.rootViewController!.view)!, animated: true)
        if #available(iOS 9.0, *) {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.gray
        } else {
        }
        DispatchQueue.main.async {
            progressHud.show(animated: true)
        }
    }
}

func dissmissLoader() {
    DispatchQueue.main.async {
        progressHud.hide(animated: true)
    }
}


public func linear(to direction: Direction, colors: [CGColor], locations: [NSNumber], filter: CIFilter? = nil) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.startPoint = direction.startPoint
    layer.endPoint = direction.endPoint
    layer.colors = colors
    layer.locations = locations
    if let filter = filter {
        layer.backgroundFilters = [filter]
    }
    return layer
}

func customAlertWithMessage(message: String, okHandler: ((UIAlertAction) -> Void)?, viewController: UIViewController) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: okHandler))
    viewController.present(alert, animated: true, completion: nil)
}

func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword(mypassword : String) -> Bool {
    let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
    let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
    return passwordtesting.evaluate(with: mypassword)
}

// MARK: - CHECK_INTERNET_CONNECTIVITY

func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    return ret
    
}
