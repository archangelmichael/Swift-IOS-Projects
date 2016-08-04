//
//  ViewController.swift
//  CustomTransitions
//
//  Created by Radi on 8/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateAdTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AnimationsManager.sharedManager.animationData = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateAdTap(tap: UITapGestureRecognizer) -> Void {
        let tapLocaiton = tap.locationInView(self.view)
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        let fullScreenRadius = sqrt(width * width + height * height)
        let frame = CGRectMake(tapLocaiton.x - fullScreenRadius,
                               tapLocaiton.y - fullScreenRadius,
                               fullScreenRadius * 2,
                               fullScreenRadius * 2)
        
        AnimationsManager.sharedManager.animationData = AnimationData(frame: frame,
                                                                      parent: self.view,
                                                                      color: UIColor.yellowColor())
        self.performSegueWithIdentifier("goDetails", sender: self)
    }
}

