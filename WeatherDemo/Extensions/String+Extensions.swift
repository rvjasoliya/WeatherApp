//
//  String+Extensions.swift
//  Countdown
//
//  Created by iMac on 06/01/23.
//

import Foundation
import UIKit

extension String {
    
    func toDateWithTime(withFormat format: String = "MMM, dd yyyy hh:mm:ss a") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }

    func timeStampToTime(withFormat format: String = "MMM, dd yyyy hh:mm:ss a") -> String {
        let date = Date(timeIntervalSince1970: (Double(self) ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
}
