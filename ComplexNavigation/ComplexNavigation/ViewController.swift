//
//  ViewController.swift
//  ComplexNavigation
//
//  Created by Radi on 2/5/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "START"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func go1(sender: AnyObject) {
        (self.navigationController as! NavViewController).showFirstVC()
    }

    @IBAction func go2(sender: AnyObject) {
        (self.navigationController as! NavViewController).showSecondVC()
    }
    
    @IBAction func go3(sender: AnyObject) {
        (self.navigationController as! NavViewController).showThirdVC()
    }
    
}

