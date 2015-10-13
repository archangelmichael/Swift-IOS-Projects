//
//  UIColorExtension.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/13/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func colorFromHexString(hex: String) -> UIColor {
        var colorString = ""
        if hex.hasPrefix("#") {
            let index = hex.startIndex.advancedBy(1)
            colorString = hex.substringFromIndex(index)
        }
        else {
            colorString = hex
        }
        
        if (colorString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let greenIndex = hex.startIndex.advancedBy(2)
        let blueIndex = hex.startIndex.advancedBy(4)
        let rString = colorString.substringToIndex(greenIndex)
        let gString = colorString.substringFromIndex(greenIndex).substringToIndex(blueIndex)
        let bString = colorString.substringFromIndex(blueIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func colorFromHexString(hex: String, alpha:CGFloat) -> UIColor {
        let hexInt: CUnsignedInt = self.intFromHexString(hex)
        return UIColor(
            red: (CGFloat(((hexInt & 0xFF0000) >> 16)))/255,
            green: (CGFloat(((hexInt & 0xFF00) >> 8)))/255,
            blue: (CGFloat(((hexInt & 0xFF00) >> 0xFF)))/255,
            alpha: alpha)
    }
    
    class func intFromHexString(hex: String) -> CUnsignedInt {
        var hexInt: CUnsignedInt = 0;
        let scanner = NSScanner(string: hex)
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        scanner.scanHexInt(&hexInt)
        return hexInt
    }
}
