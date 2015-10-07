//
//  ExampleTransitioningDelegate.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class ExampleTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentationController = ExamplePresentationController(presentedViewController:presented, presentingViewController:presenting)
        
        return presentationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ExampleAnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = ExampleAnimatedTransitioning()
        animationController.isPresentation = false
        return animationController
    }
}
