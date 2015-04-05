//
//  ViewController.swift
//  TipCalculator
//
//  Created by ARCHANGEL on 4/4/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalInput: UITextField!
    @IBOutlet weak var taxPercentageLabel: UILabel!
    @IBOutlet weak var taxPercentageSlider: UISlider!
    @IBOutlet weak var resultTextView: UITextView!
    
    let tipCalculator = TipCalculatorModel(total: 33.5, taxPercentage: 0.06)
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalculator.taxPercentage = Double(taxPercentageSlider.value) / 100
        refreshUI()
    }
    @IBAction func viewTapped(sender: AnyObject) {
        // dismiss keyboard if view is tapped
        totalInput.resignFirstResponder()
    }
    @IBAction func calculateTapped(sender: AnyObject) {
        tipCalculator.total = Double((totalInput.text as NSString).doubleValue)
        let possibleTips = tipCalculator.returnPossibleTips()
        var results = ""
        var keys = Array(possibleTips.keys)
        sort(&keys)
        for tipPercentage in keys {
            var tipValue = possibleTips[tipPercentage]!
            var formattedTipValue = String(format: "%0.2f", tipValue)
            results += "\(tipPercentage)%: \(formattedTipValue) \n"
        }
        
        resultTextView.text = results
    }
    
    func refreshUI() {
        totalInput.text = String(format: "%0.2f", tipCalculator.total)
        taxPercentageSlider.value = Float(tipCalculator.taxPercentage) * 100
        taxPercentageLabel.text = "Tax Percentage (\(Int(taxPercentageSlider.value))%):"
        resultTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

