//
//  Animator.swift
//  PictureCollection
//
//  Created by Sandy L on 2016-03-15.
//  Copyright © 2016 Sandy L. All rights reserved.

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.8
    var presenting  = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let photoView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : photoView.frame
        let finalFrame = presenting ? photoView.frame : originFrame
        
        //if true frame will grow from initial to final frame on x-axis
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        
        //if true frame will grow from initial to final frame on y-axis
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        //scale transform 
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            photoView.transform = scaleTransform
            photoView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            photoView.clipsToBounds = true
        }
        
        //add subview
        containerView.addSubview(toView)
    
        //bring subview to front
        containerView.bringSubviewToFront(photoView)
     
        
        UIView.animateWithDuration(duration, delay:0.0,
            options: [.CurveEaseOut],
            animations: {
                
                photoView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                photoView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
                
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
        
        
    }
    
}

