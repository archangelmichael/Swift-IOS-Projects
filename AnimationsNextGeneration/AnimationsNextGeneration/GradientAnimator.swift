//
//  gradientAnimator.swift
//  SlotMachine
//
//  Created by Sandy L on 2016-03-17.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class GradientAnimator: UIView {
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            
            //gradient colors
            UIColor.yellowColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.orangeColor().CGColor,
           
        ]
        gradientLayer.colors = colors
        
        let locations = [
            
            //gradient locations
            0.25,
            0.5,
            0.75
        ]
        
        
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    //creates the text mask
    let textAttributes : [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        return [
            NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 30.0)!,
            NSParagraphStyleAttributeName:style
        ]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.drawInRect(bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //mask
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            
            gradientLayer.mask = maskLayer
           
        }
    }
    
    
    
    override func layoutSubviews() {
        
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 2*bounds.size.width,
            height: bounds.size.height)
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.25, 0.50]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 5.0
        gradientAnimation.repeatCount = Float.infinity
        
        //add sublayer and add animation
        layer.addSublayer(gradientLayer)
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
        
      
    }
    
}

