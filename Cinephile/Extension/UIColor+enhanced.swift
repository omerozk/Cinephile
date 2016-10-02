//
//  UIColor+enhanced.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(rgb:Int) {
        let r = CGFloat(rgb >> 16) / 255
        let g = CGFloat((rgb & 0x00ff00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    convenience init(rgb:Int, alpha: CGFloat) {
        let r = CGFloat(rgb >> 16) / 255
        let g = CGFloat((rgb & 0x00ff00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex:String) {
        var rgb:CUnsignedInt = 0
        Scanner(string: hex).scanHexInt32(&rgb)
        self.init(rgb: Int(rgb))
    }
    
    class func appRedColor() -> UIColor {
        return UIColor(rgb: 0xED1C24)
    }
}
