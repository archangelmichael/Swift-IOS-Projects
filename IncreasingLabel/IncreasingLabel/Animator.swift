//
//  Animator.swift
//  IncreasingLabel
//
//  Created by Radi on 8/11/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Animator: NSObject {
    private static var counters : Array<Double> = []
    private static var labels : Array<UILabel> = []
    private static var values : Array<Double> = []
    
    private static var animationTimer : NSTimer?
    private static var end : Bool = false
    
    static func animateIncreasingLabels(labels: Array<UILabel>, values: Array<Double>) {
        if(self.animationTimer == nil) {
            self.labels = labels
            self.values = values
            self.counters = [Double](count: self.labels.count, repeatedValue: 0.0)
            self.end = false
            
            for label in self.labels {
                label.text = ""
            }
            
            self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(0.01,
                                                                         target: self,
                                                                         selector: #selector(animateLabels),
                                                                         userInfo: nil,
                                                                         repeats: true)
        }
    }
    
    static func animateLabels() {
        if self.labels.count == 0 {
            self.animationTimer?.invalidate()
            self.animationTimer = nil
        }
        
        
        for index in 0...self.labels.count - 1 {
            var counter = self.counters[index]
            let value = self.values[index]
            let label = self.labels[index]
            
            counter += value / 50
            self.counters[index] = counter
            label.text = "\(Int(round(counter)))"
            
            if counter > value {
                self.end = true
            }
        }
        
        if self.end {
                self.animationTimer?.invalidate()
                self.animationTimer = nil
                
                for index in 0...self.labels.count - 1 {
                    self.labels[index].text = "\(values[index])"
                }
        }
        
        
    }
}

extension UILabel {
    func changeTextAnimated(text: String, completion: ((Bool)->Void)?) {
        UIView.transitionWithView(self,
                                  duration: 1.0,
                                  options: [.CurveEaseInOut, .TransitionCrossDissolve],
                                  animations:
            {
                self.text = text
            },
                                  completion: completion)
    }
    
    func changeTextAnimated2(text: String) {
        let animation: CATransition = CATransition()
        animation.duration = 1.0
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.addAnimation(animation, forKey: "changeTextTransition")
        self.text = text
    }
    
    func changeTextPushVertically(count: Int) {
        let animation = CATransition()
        animation.removedOnCompletion = true
        animation.duration = 0.2
        animation.type = kCATransitionPush
        animation.subtype = count > Int(self.text!) ? kCATransitionFromTop : kCATransitionFromBottom
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.layer.addAnimation(animation, forKey:"changeTextTransition")
        self.text = "\(count)"
    }
}
