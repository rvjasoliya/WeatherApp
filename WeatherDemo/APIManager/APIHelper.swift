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
    
    // MARK: States List Api
    static func forecastApi(parameters: Parameters, callback: ((_ status: Bool ,_ data: [String : AnyObject]?,_ error: Error?)->Void)?) {
        APIManager.sharedInstance.getResponseAPI(url: Apis.shared.forecastApi, parameters: parameters, isPring: false, completionHandler: { (response, error) in
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
