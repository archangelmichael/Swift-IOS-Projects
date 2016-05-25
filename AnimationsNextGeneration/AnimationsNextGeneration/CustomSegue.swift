//
//  CustomSegue.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/25/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController
        
        sourceVC.view.addSubview(destinationVC.view)
        destinationVC.view.transform = CGAffineTransformMakeScale(0.0, 0.0)
    
        UIView.animateWithDuration( 0.6,
                                    delay: 0.0,
                                    options: [.CurveEaseInOut],
                                    animations: {
                                        destinationVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            },
                                    completion: { (finished) in
            sourceVC.presentViewController(destinationVC, animated: false, completion: nil)
        })
    
    }
}
