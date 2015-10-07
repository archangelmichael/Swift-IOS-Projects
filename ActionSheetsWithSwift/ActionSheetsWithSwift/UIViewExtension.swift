//
//  UIViewExtension.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func animateAsPopup() {
        UIView.animateWithDuration(
            1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.alpha = 1.0
            },
            completion: { _ in
                UIView.animateWithDuration(
                    1.0,
                    delay: 3.0,
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {
                        self.alpha = 0.0
                    },
                    completion: nil)
            })
    }
    
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animateWithDuration(
            1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.alpha = 1.0
            },
            completion: nil)
    }
    
    func fadeOut() {
        UIView.animateWithDuration(
            1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.alpha = 0.0
            },
            completion: nil)
    }
}