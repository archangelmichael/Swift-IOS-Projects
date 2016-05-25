//
//  FifthViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/25/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import QuartzCore

class FifthViewController: UIViewController {

    var mask: CALayer?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "twitter_logo")!.CGImage
        self.mask!.contentsGravity = kCAGravityResizeAspect
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //add logo as mask to view
        imageView.layer.mask = mask
        
        //twitter brand colors
        self.view.backgroundColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1)
        animate()
    }
    
    func animate() {
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        
        //start animation
        let initialBounds = NSValue(CGRect:mask!.bounds)
        
        //bounce/zooming effect
        let middleBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        
        //add NSValues and keytimes
        keyFrameAnimation.values = [initialBounds, middleBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        
        //animation timing functions
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
                                             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        //add animation
        self.mask?.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        //removes mask when animation completes
        self.imageView.layer.mask = nil
    }
}
