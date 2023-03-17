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
    
    func getNumberNameDay() -> String {
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH"
        
        return "\(weekdays[calendar - 1]) \(formatter.string(from: self))"
    }
    
    func getMouthDay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "MMMM d"
        
        return "\(formatter.string(from: self))"
    }
        
}
