//
//  APIManager.swift
//  DailyHoroscope
//
//  Created by iMac on 22/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    var manager = Session.default
    var absoluteUrl = ""
    
    func getResponseAPI(url: String, isPring: Bool = false, completionHandler: @escaping (AnyObject?, NSError?)->()) ->() {
        print("get url", url)
        if obj_AppDelegate.window != nil {
            showLoading()
        }
        manager.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseString(completionHandler: { (response) in
            switch response.result {
            case .success( _):
                if (isPring) {
                    print(response.result)
                }
                dissmissLoader()
                do {
                    dissmissLoader()
                    if let dt = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [[String: Any]]{
                        completionHandler(dt as AnyObject?,nil)
                    }
                    if let dt = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String: Any]{
                        completionHandler(dt as AnyObject?,nil)
                    }
                } catch{
                    dissmissLoader()
                    completionHandler(nil,response.error as NSError?)
                    print("Error : ",error)
                }
            case .failure( let error):
                dissmissLoader()
                completionHandler(nil,response.error as NSError?)
                print("Request failed with error: \(error)")
            }
        })
    }
    
}
