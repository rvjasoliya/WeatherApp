//
//  Apis.swift
//  FuelPrice
//
//  Created by iMac on 02/11/22.
//

import Foundation

class Apis {
    
    static var shared = Apis()
    
    static var base_url = "https://weatherapi-com.p.rapidapi.com/"
    
    var forecastApi = base_url + "forecast.json"
        
}
