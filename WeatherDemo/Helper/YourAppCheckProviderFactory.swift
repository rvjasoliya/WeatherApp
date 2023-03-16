//
//  YourAppCheckProviderFactory.swift
//  Expire
//
//  Created by iMac on 20/01/23.
//

import Foundation
import UIKit
import FirebaseAppCheck
import Firebase

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        if #available(iOS 14.0, *) {
            return AppAttestProvider(app: app)
        } else {
            return DeviceCheckProvider(app: app)
        }
    }
    
}
