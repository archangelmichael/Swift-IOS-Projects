//
//  ViewController.swift
//  TotoCheck
//
//  Created by Radi on 6/2/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button5from35: UIButton!
    @IBOutlet weak var button6from42: UIButton!
    @IBOutlet weak var button6from49: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set buttons with round corners
        button5from35.layer.cornerRadius = BUTTONS_CORNER_RADIUS
        button5from35.clipsToBounds = true
        button6from42.layer.cornerRadius = BUTTONS_CORNER_RADIUS
        button6from42.clipsToBounds = true
        button6from49.layer.cornerRadius = BUTTONS_CORNER_RADIUS
        button6from49.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? DrawsViewController{
            switch segue.identifier! {
            case SEGUE_5_35 :
                println("GO TO 5/35")
                destinationVC.drawTitle = "5/35"
                destinationVC.drawNumbersCount = 5
                destinationVC.totalNumbersCount = 35
                destinationVC.numberOfDraws = 2
                
            case SEGUE_6_42 :
                println("GO TO 6/42")
                destinationVC.drawTitle = "6/42"
                destinationVC.drawNumbersCount = 6
                destinationVC.totalNumbersCount = 42
                destinationVC.numberOfDraws = 1
                
            case SEGUE_6_49 :
                println("GO TO 6/49")
                destinationVC.drawTitle = "6/49"
                destinationVC.drawNumbersCount = 6
                destinationVC.totalNumbersCount = 49
                destinationVC.numberOfDraws = 1
                
            default:
                println("DO NOTHING")
            }
        }

    }
    
    @IBAction func onDrawButtonClick(sender: AnyObject) {
        let buttonTag = (sender as! UIButton).tag;
        switch buttonTag {
            case BUTTON_5_35_TAG :
                println("GO TO 5/35")
            case BUTTON_6_42_TAG :
                println("GO TO 6/42")
            case BUTTON_6_49_TAG :
                println("GO TO 6/49")
            default:
                println("DO NOTHING")
        }
    }
}

