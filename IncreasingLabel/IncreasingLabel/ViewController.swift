//
//  ViewController.swift
//  IncreasingLabel
//
//  Created by Radi on 8/11/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblIncreasing: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lblTop: UILabel!
    
    var animationTimer : NSTimer?
    
    
    var counter1 = 0.0
    var counter2 = 0.0
    var counter = 0.0
    
    
    let max1 = 123.0
    let max2 = 65545.0
    let maxValue = 12353453.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbl1.text = ""
        self.lbl2.text = ""
        self.lblIncreasing.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.lblTop.text = "0"
        self.lbl1.text = "0"
        self.lbl2.text = "0"
        self.lblIncreasing.text = "0"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var btnIncrease: UIButton!

    @IBOutlet weak var btnDecrease: UIButton!
    
    @IBAction func onIncrease(sender: AnyObject) {
        // self.lblTop.changeTextAnimated("animated  \(rand()%2 == 0)", completion: nil)
        // self.lblTop.changeTextAnimated2("Animated \(rand()%2 == 0)")
        // self.lblTop.changeTextPushVertically(Int(self.lblTop.text!)! + 1)
        
        // Animator.animateIncreasingLabels([self.lbl1, self.lbl2, self.lblIncreasing], values: [maxValue, max1, max2])
    }

    @IBAction func onDecrease(sender: AnyObject) {
        self.performSegueWithIdentifier("showImagesAnimation", sender: self)
    }
    
    func animateLabels() -> Void {
        self.counter1 += max1 / 50
        self.counter2 += max2 / 50
        self.counter += maxValue / 50
        
        self.lbl1.text = "\(self.counter1)"
        self.lbl2.text = "\(self.counter2)"
        self.lblIncreasing.text = "\(self.counter)"
        
        if self.counter >= maxValue {
            self.animationTimer?.invalidate()
            self.animationTimer = nil
            
            self.lbl1.text = "\(self.max1)"
            self.lbl2.text = "\(self.max2)"
            self.lblIncreasing.text = "\(self.maxValue)"
        }
    }
}

