//
//  LoginViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!

    @IBOutlet weak var cstrPassCenter: NSLayoutConstraint!
    @IBOutlet weak var cstrMailCenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cstrMailCenter.constant = self.view.bounds.width
        self.cstrPassCenter.constant = -self.view.bounds.width
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cstrMailCenter.constant = 0
        self.cstrPassCenter.constant = 0
        UIView.animateWithDuration(2.0,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut],
                                   animations: {
                                    self.view.layoutIfNeeded()
            },
                                   completion: nil)
    }
}
