//
//  AnimationsManager.swift
//  PropertyMonster
//
//  Created by Radi on 8/1/16.
//  Copyright © 2016 oryx. All rights reserved.
//

import UIKit

class AnimationData: NSObject {
    var frame: CGRect
    var parentView: UIView
    var color: UIColor
    
    init(frame: CGRect, parent: UIView, color: UIColor) {
        self.frame = frame
        self.parentView = parent
        self.color = color
        super.init()
    }
}

class AnimationsManager: NSObject {
    var animationData : AnimationData?
    
    class var sharedManager: AnimationsManager {
        struct Static {
            static let instance = AnimationsManager()
        }
        
        return Static.instance
    }
    
    override init() {
        super.init()
        self.animationData = nil
    }
}
