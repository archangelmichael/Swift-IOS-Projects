//
//  CustomNavigationAnimationController.swift
//  PropertyMonster
//
//  Created by Radi on 7/29/16.
//  Copyright © 2016 oryx. All rights reserved.
//

import UIKit

class CustomNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var reverse : Bool = false
    var options : AnimationData? = nil
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.isKindOfClass(ViewController) &&
            !reverse &&
            AnimationsManager.sharedManager.animationData != nil {
            self.options = AnimationsManager.sharedManager.animationData!
            // Show by revealing from center of the screen
            self.circleTransitionWithFill(transitionContext)
        }
        else {
            // Reduce screen size and remove it(disappear in the middle of the other screen
            self.reduceSizeAndDisappear(transitionContext)
        }
        
        // Perform rotate 2 screens animation
        // self.slideAndRotate(transitionContext)
    }
    
    func circleTransitionWithFill(transitionContext: UIViewControllerContextTransitioning) -> Void {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView()
        
        var startView : UIView
        let fromVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let splashView = UIView(frame: options.frame)
        splashView.backgroundColor = options.color
        splashView.layer.cornerRadius = splashView.frame.size.width/2
        splashView.layer.borderWidth = 2.0
        splashView.layer.borderColor = UIColor.whiteColor().CGColor
        splashView.clipsToBounds = true
        splashView.transform = CGAffineTransformMakeScale(0.001, 0.001)
        let parentView = options.parentView
        parentView.addSubview(splashView)
        parentView.bringSubviewToFront(splashView)
        
        UIView.animateWithDuration(0.75,
                                   animations:
            {
                splashView.transform = CGAffineTransformIdentity
            },
                                   completion:
            {
                complete in
                AnimationsManager.sharedManager.animationData = nil
                self.performSelector(selector)
                splashView.removeFromSuperview()
        })
        
        
        
        
        
        
        
        
        
        
        
        startView = UIView(frame:  CGRectMake(toVC.view.frame.size.width/2, toVC.view.frame.size.height/2, 0, 0))
        containerView!.addSubview(toVC.view)
        
        let circleMaskPathInitial = UIBezierPath(ovalInRect: startView.frame)
        let radius = toVC.view.bounds.height > toVC.view.bounds.width ? 2 * toVC.view.bounds.height : 2 * toVC.view.bounds.width
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(startView.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toVC.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
        func animateAdPopup(selector: Selector) -> Void {
            
        }
    
    func circleTransition(transitionContext: UIViewControllerContextTransitioning) -> Void {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView()
        
        let direction: CGFloat = reverse ? -1 : 1
        if direction == 1 { // Show new VC
            var startView : UIView
            // let fromVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            startView = UIView(frame:  CGRectMake(toVC.view.frame.size.width/2, toVC.view.frame.size.height/2, 0, 0))
            containerView!.addSubview(toVC.view)
            
            let circleMaskPathInitial = UIBezierPath(ovalInRect: startView.frame)
            let radius = toVC.view.bounds.height > toVC.view.bounds.width ? 2 * toVC.view.bounds.height : 2 * toVC.view.bounds.width
            let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(startView.frame, -radius, -radius))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPathFinal.CGPath
            toVC.view.layer.mask = maskLayer
            
            let maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        }
        else { // Go back from VC
            var startView : UIView
            let fromVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC : UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            startView = UIView(frame: CGRectMake(fromVC.view.frame.size.width/2, fromVC.view.frame.size.height/2, 0, 0))
            containerView!.addSubview(toVC.view)
            containerView!.sendSubviewToBack(toVC.view)
            
            let radius = fromVC.view.bounds.height > fromVC.view.bounds.width ? 2 * fromVC.view.bounds.height : 2 * fromVC.view.bounds.width
            let circleMaskPathInitial = UIBezierPath(ovalInRect: CGRectInset(startView.frame, -radius, -radius))
            let circleMaskPathFinal = UIBezierPath(ovalInRect: startView.frame)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPathFinal.CGPath
            fromVC.view.layer.mask = maskLayer
            
            let maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        let direction: CGFloat = reverse ? -1 : 1
        if direction == 1 { // Show new VC
            self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        }
        else { // Go back to VC
            self.transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        }
    }
    
    func reduceSizeAndDisappear(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        let direction: CGFloat = reverse ? -1 : 1
        if direction == 1 {
            let startFrame = CGRectInset(fromViewController.view.frame,
                                         fromViewController.view.frame.size.width / 2,
                                         fromViewController.view.frame.size.height / 2)
            let endFrame = fromViewController.view.frame
            
            
            toViewController.view.frame = endFrame
            toViewController.view.alpha = 1.0
            
            let snapshotView = toViewController.view.snapshotViewAfterScreenUpdates(true)
            snapshotView.frame = startFrame
            containerView!.addSubview(snapshotView)
            containerView!.bringSubviewToFront(snapshotView)
            
            UIView.animateWithDuration(transitionDuration(transitionContext),
                                       animations: {
                                        snapshotView.frame = endFrame
                                        fromViewController.view.alpha = 0.5
                },
                                       completion: {
                                        finished in
                                        containerView!.addSubview(toViewController.view)
                                        containerView!.sendSubviewToBack(toViewController.view)
                                        snapshotView.removeFromSuperview()
                                        fromViewController.view.removeFromSuperview()
                                        transitionContext.completeTransition(true)
            })
        }
        else {
            let endFrame = CGRectInset(fromViewController.view.frame,
                                         fromViewController.view.frame.size.width / 2,
                                         fromViewController.view.frame.size.height / 2)
            let startFrame = transitionContext.finalFrameForViewController(toViewController)
            
            
            toViewController.view.frame = startFrame
            toViewController.view.alpha = 0.5
            containerView!.addSubview(toViewController.view)
            containerView!.sendSubviewToBack(toViewController.view)
            
            let snapshotView = fromViewController.view.snapshotViewAfterScreenUpdates(false)
            snapshotView.frame = fromViewController.view.frame
            containerView!.addSubview(snapshotView)
            
            fromViewController.view.removeFromSuperview()
            
            UIView.animateWithDuration(transitionDuration(transitionContext),
                                       animations: {
                                        snapshotView.frame = endFrame
                                        toViewController.view.alpha = 1.0
                },
                                       completion: {
                                        finished in
                                        snapshotView.removeFromSuperview()
                                        transitionContext.completeTransition(true)
            })

        }
    }
    
    func slideAndRotate(transitionContext: UIViewControllerContextTransitioning) -> Void {
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView = toViewController.view
        let fromView = fromViewController.view
        let direction: CGFloat = reverse ? -1 : 1
        let const: CGFloat = -0.005
        
        toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5)
        fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5)
        
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        containerView.transform = CGAffineTransformMakeTranslation(direction * containerView.frame.size.width / 2.0, 0)
        toView.layer.transform = viewToTransform
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            containerView.transform = CGAffineTransformMakeTranslation(-direction * containerView.frame.size.width / 2.0, 0)
            fromView.layer.transform = viewFromTransform
            toView.layer.transform = CATransform3DIdentity
            }, completion: {
                finished in
                containerView.transform = CGAffineTransformIdentity
                fromView.layer.transform = CATransform3DIdentity
                toView.layer.transform = CATransform3DIdentity
                fromView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                toView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                
                if (transitionContext.transitionWasCancelled()) {
                    toView.removeFromSuperview()
                } else {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
