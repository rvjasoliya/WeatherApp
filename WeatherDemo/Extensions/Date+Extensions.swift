//
//  Date+Extensions.swift
//  AbhaVerification
//
//  Created by iMac on 27/12/22.
//

import Foundation

extension Date {
    
    func timeStamp() -> String {
        return "\(Int(self.timeIntervalSince1970))"
    }
    
    func dateToTimeString(withFormat format: String = "MMM, dd yyyy hh:mm:ss a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
        
}
