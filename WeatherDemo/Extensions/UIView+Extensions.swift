//
//  UIView+Extensions.swift
//  FuelPrice
//
//  Created by iMac on 10/11/22.
//

import Foundation
import UIKit

extension UIView {
    
    public func addShadowToViewWithBottomRoundedCorners(shadow_color: UIColor, offset: CGSize, shadow_radius: CGFloat, shadow_opacity: Float, corner_radius: CGFloat, isOnlyBottomShadow: Bool) {
        self.layer.shadowColor = shadow_color.cgColor
        self.layer.shadowOpacity = shadow_opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadow_radius
        self.layer.cornerRadius = corner_radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        if isOnlyBottomShadow {
            self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                              y: bounds.maxY - layer.shadowRadius,
                                                              width: bounds.width,
                                                              height: layer.shadowRadius)).cgPath
        }
        
    }
    
    public func addShadowToViewWithTopRoundedCorners(shadow_color: UIColor, offset: CGSize, shadow_radius: CGFloat, shadow_opacity: Float, corner_radius: CGFloat, isOnlyBottomShadow: Bool) {
        self.layer.shadowColor = shadow_color.cgColor
        self.layer.shadowOpacity = shadow_opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadow_radius
        self.layer.cornerRadius = corner_radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if isOnlyBottomShadow {
            self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                              y: bounds.maxY - layer.shadowRadius,
                                                              width: bounds.width,
                                                              height: layer.shadowRadius)).cgPath
        }
        
    }
    
    public func addShadowToView(shadow_color: UIColor, offset: CGSize, shadow_radius: CGFloat, shadow_opacity: Float, corner_radius: CGFloat, isOnlyBottomShadow: Bool) {
        self.layer.shadowColor = shadow_color.cgColor
        self.layer.shadowOpacity = shadow_opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadow_radius
        self.layer.cornerRadius = corner_radius
        if isOnlyBottomShadow {
            self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                              y: bounds.maxY - layer.shadowRadius,
                                                              width: bounds.width,
                                                              height: layer.shadowRadius)).cgPath
        }
    }

    // Top left, Top right radius
    func topRoundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // Bottom left, Bottom right radius
    func bottomRoundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    // Set Gradient Layer
    func setUpGradientLayer(colors: [CGColor]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
            let gradientLayer = linear(to: .right, colors: colors, locations: [0.0, 1.0])
            gradientLayer.frame = self.bounds
            gradientLayer.name = "Header Gradient Layer"
            gradientLayer.zPosition = -1
            self.layer.addSublayer(gradientLayer)
        }
        self.clipsToBounds = true
    }
    
}
