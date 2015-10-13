//
//  UIImageExtension.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/13/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithColor2(color: UIColor) -> UIImage {
        let rect : CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
    func scaledImageWithImage(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func scaledToSize(size : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func scaledToHeight(height : CGFloat) -> UIImage {
        let ratio : CGFloat = self.size.width / self.size.height
        let width : CGFloat = ratio / height
        return self.scaledToSize(CGSizeMake(width, height))
    }
    
    func setForNavBar(navBar: UINavigationBar) -> Void {
        UIGraphicsBeginImageContext(navBar.frame.size);
        self.drawInRect(navBar.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        navBar.barTintColor = UIColor(patternImage: image);
    }
}
