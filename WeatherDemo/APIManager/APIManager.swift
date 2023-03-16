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
    
    func getResponseAPI(url: String, parameters: Parameters = [:], isPring: Bool = false, completionHandler: @escaping (AnyObject?, NSError?)->()) ->() {
        print("get url", url)
        absoluteUrl = url
        if obj_AppDelegate.window != nil {
            showLoading()
        }
        let ApiKey = (appSettings?.ApiKey ?? []).randomElement()
        let headers: HTTPHeaders = [
            
            "X-RapidAPI-Key": (ApiKey ?? "2bc7ac5d8emshe55d4d11acc0897p1c8019jsnf5eef708a08e"),
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        var param: Parameters? = parameters
        if let urlParameters = param {
            if !(urlParameters.isEmpty) {
                absoluteUrl.append("?")
                var array:[String] = []
                let _ = urlParameters.map { (key, value) -> Bool in
                    let str = key + "=" +  String(describing: value)
                    array.append(str)
                    return true
                }
                absoluteUrl.append(array.joined(separator: "&"))
            }
        }
        param = nil
        print(absoluteUrl)
        manager.request(absoluteUrl, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseString(completionHandler: { (response) in
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
