//
//  ViewController.swift
//  TipCalculator
//
//  Created by ARCHANGEL on 4/4/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var totalInput: UITextField!
    @IBOutlet weak var taxPercentageLabel: UILabel!
    @IBOutlet weak var taxPercentageSlider: UISlider!
    @IBOutlet weak var resultsTextView: UITableView!
    
    let tipCalculator = TipCalculatorModel(total: 33.5, taxPercentage: 0.06)
    var possibleTips = Dictionary<Int, (tipAmount: Double, totalAmount: Double)>()
    var sortedKeys: [Int] = []
    
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
        possibleTips = tipCalculator.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        resultsTextView.reloadData()
    }
    
    func refreshUI() {
        totalInput.text = String(format: "%0.2f", tipCalculator.total)
        taxPercentageSlider.value = Float(tipCalculator.taxPercentage) * 100
        taxPercentageLabel.text = "Tax Percentage (\(Int(taxPercentageSlider.value))%):"
        resultsTextView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: "tipInfoCell")
        let tipPercentage = sortedKeys[indexPath.row]
        let tipAmount = possibleTips[tipPercentage]!.tipAmount
        let totalAmount = possibleTips[tipPercentage]!.totalAmount
        
        cell.textLabel?.text = "\(tipPercentage)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmount, totalAmount)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.possibleTips = tipCalculator.returnPossibleTips()
        self.sortedKeys = sorted(Array(possibleTips.keys))

        self.refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

