//
//  FirstViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var cstrCenterY: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblSubheader: UILabel!
    @IBOutlet weak var cstrSubheaderTop: NSLayoutConstraint!
    
    @IBOutlet weak var lblHidden: UILabel!
    
    var displacement : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displacement = self.view.bounds.height
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.cstrCenterY.constant = displacement
        self.cstrSubheaderTop.constant = 2 * displacement
        self.lblHidden.alpha = 0
    }

    override func viewDidAppear(animated: Bool) {
        
        self.cstrCenterY.constant = 0
        self.cstrSubheaderTop.constant = 8
        UIView.animateWithDuration(1.0,
                                   animations: {
                                    self.view.layoutIfNeeded()
            },
                                   completion: { (finished) in
                                    self.cstrSubheaderTop.constant = 8
                                    UIView.animateWithDuration(1.0, animations: {
                                        self.view.layoutIfNeeded()
                                    })
        })
        
        UIView.animateWithDuration(1.5,
                                   delay: 0.5,
                                   options: [],
                                   animations: {
                                    self.view.backgroundColor = UIColor.yellowColor()
            },
                                   completion: { (finished) in
                                    UIView.animateWithDuration(1.5,
                                        animations: {
                                            self.view.backgroundColor = UIColor.blackColor()
                                    })
                                    
                                    UIView.animateWithDuration(1.0,
                                        delay: 1.0,
                                        options: [],
                                        animations: {
                                            self.lblHidden.alpha = 1.0
                                        },
                                        completion: nil)
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

