//
//  AppSettingsMosel.swift
//  FuelPrice
//
//  Created by iMac on 11/11/22.
//

import Foundation

public class AppSettingsModel {
    
    public var ApiKey: [String]?
    public var IsApiCall: Bool?

    public class func modelsFromDictionaryArray(array: NSArray) -> [AppSettingsModel] {
        var models: [AppSettingsModel] = []
        for item in array {
            models.append(AppSettingsModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

        ApiKey = dictionary["ApiKey"] as? [String]
        IsApiCall = dictionary["IsApiCall"] as? Bool
        
    }

    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.ApiKey, forKey: "ApiKey")
        dictionary.setValue(self.IsApiCall, forKey: "IsApiCall")

        return dictionary
    }

}
