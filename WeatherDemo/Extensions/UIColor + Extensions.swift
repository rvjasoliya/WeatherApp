//
//  UIColor + Extensions.swift
//  FuelPrice
//
//  Created by iMac on 15/11/22.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let (red, green, blue, _) = rgba
        return (red, green, blue)
    }
    
    public static var colorPickerBorderColor: UIColor {
        return pickColorForMode(lightModeColor: #colorLiteral(red: 0.7089999914, green: 0.7089999914, blue: 0.7089999914, alpha: 1), darkModeColor: #colorLiteral(red: 0.4203212857, green: 0.4203212857, blue: 0.4203212857, alpha: 1))
    }
    
    public static var colorPickerLabelTextColor: UIColor {
        return pickColorForMode(lightModeColor: #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), darkModeColor: #colorLiteral(red: 0.6395837665, green: 0.6395837665, blue: 0.6395837665, alpha: 1))
    }
    
    public static var colorPickerLightBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.200000003)
    public static var colorPickerThumbViewWideBorderColor: UIColor {
        return pickColorForMode(lightModeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6999999881), darkModeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5995928578))
    }
    
    public static var colorPickerThumbViewWideBorderDarkColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3000000119)
    
    public func hexValue(alwaysIncludeAlpha: Bool = false) -> String {
        let (red, green, blue, alpha) = rgba
        let r = colorComponentToUInt8(red)
        let g = colorComponentToUInt8(green)
        let b = colorComponentToUInt8(blue)
        let a = colorComponentToUInt8(alpha)
        
        if alpha == 1 && !alwaysIncludeAlpha {
            return String(format: "%02lX%02lX%02lX", r, g, b)
        }
        return String(format: "%02lX%02lX%02lX%02lX", r, g, b, a)
    }
    
    func constrastRatio(with color: UIColor) -> CGFloat {
        let (r1, g1, b1) = rgb
        let (r2, g2, b2) = color.rgb
        
        return (abs(r1 - r2) + abs(g1 - g2) + abs(b1 - b2)) / 3
    }
    
}

private func pickColorForMode(lightModeColor: UIColor, darkModeColor: UIColor) -> UIColor {
    if #available(iOS 13, *) {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            UITraitCollection.userInterfaceStyle == .dark ? darkModeColor : lightModeColor
        }
    }
    return lightModeColor
}

@inline(__always)
public func colorComponentToUInt8(_ component: CGFloat) -> UInt8 {
    return UInt8(max(0, min(255, round(255 * component))))
}

public func rgbFrom(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let hPrime = Int(hue * 6)
    let f = hue * 6 - CGFloat(hPrime)
    let p = brightness * (1 - saturation)
    let q = brightness * (1 - f * saturation)
    let t = brightness * (1 - (1 - f) * saturation)
    
    switch hPrime % 6 {
    case 0: return (brightness, t, p)
    case 1: return (q, brightness, p)
    case 2: return (p, brightness, t)
    case 3: return (p, q, brightness)
    case 4: return (t, p, brightness)
    default: return (brightness, p, q)
    }
}
