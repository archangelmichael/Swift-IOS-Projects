//
//  DrawsViewController.swift
//  TotoCheck
//
//  Created by Radi on 6/2/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class DrawsViewController : UIViewController, UITextFieldDelegate {
    var drawTitle = ""
    var drawNumbersCount = 0;
    var totalNumbersCount = 0;
    var numberOfDraws = 0;
    var isFirstDrawOK : Bool = true
    var isSecondDrawOK : Bool = true
    var draws = [NSArray]()
    var errorMessage : String = ""
    
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var viewFirstDraw: UIView!
    @IBOutlet weak var viewSecondDraw: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawLabel.text = drawTitle
        self.setGradientToView(viewFirstDraw)
        self.setGradientToView(viewSecondDraw)
        
        self.setTextViewDelegates()
        
        if numberOfDraws < 2 {
            self.viewSecondDraw.hidden = true
        }
        
        if drawNumbersCount < 6 {
            self.hide6thNumberFrom(self.viewFirstDraw)
            self.hide6thNumberFrom(self.viewSecondDraw)
        }
    }
    
    // Go to ticket check page if input is ok
    @IBAction func onGoToCheckTicket(sender: AnyObject) {
        isFirstDrawOK = true
        isSecondDrawOK = true
        draws = []
        self.validateDraw(self.viewFirstDraw)
        if !isFirstDrawOK {
            println(self.errorMessage)
            // TODO: SHOW ALERT
            return
        }
        
        if numberOfDraws == 2 {
            self.validateDraw(self.viewSecondDraw)
            if !isSecondDrawOK {
                println(self.errorMessage)
                // TODO: SHOW ALERT
                return
            }
        }
        
        if isFirstDrawOK && isSecondDrawOK {
            println(draws)
            self.performSegueWithIdentifier(SEGUE_TO_TICKET_CHECK, sender: sender)
        }
    }
    
    // Check if all fields are valid nonrepeating numbers for given view
    func validateDraw(view: UIView) -> Void {
        var drawNumbers = [Int]()
        for index in 1...drawNumbersCount {
            var input = ((view.viewWithTag(index)) as! UITextField).text
            if let number = NSNumberFormatter().numberFromString(input) {
                drawNumbers.append(number.integerValue)
            }
            else {
                self.makeDrawInvalid(view, message:"Invalid number entered")
                return
            }
        }
        
        if !self.areAllNumbersInRange(drawNumbers) {
            self.makeDrawInvalid(view, message:"Numbers not in range")
            return
        }
        
        if !self.areNoRepeats(drawNumbers) {
            self.makeDrawInvalid(view, message:"Repeating numbers")
            return
        }
        
        draws.append(NSArray(array:drawNumbers, copyItems: true))
    }
    
    // Check if all numbers are in range 0 to max number
    func areAllNumbersInRange(array : NSArray) -> Bool {
        var len = array.count
        for index in 0...len-1 {
            if array[index].integerValue < 1 || array[index].integerValue > totalNumbersCount {
                return false
            }
        }
        
        return true
    }

    func areNoRepeats(array : NSArray) -> Bool {
        var filter = Dictionary<String, Bool>()
        var len = array.count
        for index in 0...len-1 {
            var value : String = (array[index] as! NSNumber).stringValue
            let containsKey = filter[value] != nil
            if containsKey {
                return false
            }
            else {
                filter[value] = true
            }
        }
        
        return true
    }
    
    // Set given draw view to invalid state
    func makeDrawInvalid(view : UIView, message: String) -> Void {
        if view == self.viewFirstDraw {
            isFirstDrawOK = false
            errorMessage = "\(message) in first draw"
        }
        else {
            isSecondDrawOK = false
            errorMessage = "\(message) in second draw"
        }
    }
    
    // Return to previous page
    @IBAction func onGoBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // Set self as delegate for all text fields
    func setTextViewDelegates() {
        for index in 1...6 {
            ((self.viewFirstDraw.viewWithTag(index)) as! UITextField).delegate = self
            ((self.viewSecondDraw.viewWithTag(index)) as! UITextField).delegate = self
        }
    }
    
    // Restrict inputs to 2 symbols
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        return newLength <= 2 // Bool
    }
    
    // Hide keyboard on DONE
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // Hide keyboard on tap anywhere else
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    // Hides 6th input field
    func hide6thNumberFrom(view: UIView) -> Void {
        view.viewWithTag(6)?.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? TicketCheckViewController {
            destinationVC.drawTitle = self.drawTitle
            destinationVC.drawnNumbersCount = self.drawNumbersCount
            destinationVC.totalNumbersCount = self.totalNumbersCount
            destinationVC.draws = self.draws
        }
    }
    
    // Set gradients to draw views
    func setGradientToView(view: UIView) -> Void {
        let gradient : CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        let arrayColors = [BOTTOM_COLOR.CGColor, TOP_COLOR.CGColor]
        gradient.colors = arrayColors
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}