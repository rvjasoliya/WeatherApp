//
//  APIHelper.swift
//  DailyHoroscope
//
//  Created by iMac on 22/09/22.
//

import Foundation
import SwiftyJSON
import Alamofire

final class APIHelper {
    
    // MARK: Weather Api
    static func weatherApi(url: String, callback: ((_ status: Bool ,_ data: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.getResponseAPI(url: url, isPring: false, completionHandler: { (response, error) in
            if error == nil {
                if let someDictionaryFromJSON = response {
                    callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                }
            } else {
                callback?(false,nil,error)
            }
        })
    }
    
    // MARK: Forecast Api
    static func forecastApi(url: String, callback: ((_ status: Bool ,_ data: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.getResponseAPI(url: url, isPring: false, completionHandler: { (response, error) in
            if error == nil {
                if let someDictionaryFromJSON = response {
                    callback?(true,someDictionaryFromJSON as? [String : AnyObject],nil)
                }
            } else {
                callback?(false,nil,error)
            }
        })
    }
    
}
