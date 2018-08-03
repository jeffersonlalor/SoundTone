//
//  Extensions.swift
//  Is Loh
//
//  Created by Jefferson de Oliveira Lalor on 17/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let disableGray = UIColor().colorFromHex("2D2E2E")
    static let letterDisableGray = UIColor().colorFromHex("444A52")
    static let buttonGreen = UIColor().colorFromHex("24D89C")
    
    func colorFromHex(_ hex: String ) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
        
    }
    
}
