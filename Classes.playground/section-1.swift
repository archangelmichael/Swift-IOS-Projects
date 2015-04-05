// Playground - noun: a place where people can play

import UIKit

class TipCalculator {
    let total: Double
    let taxPercentage: Double
    let subtotal: Double
    
    init(total: Double, taxPercentage: Double) {
        self.total = total
        self.taxPercentage = taxPercentage
        self.subtotal = total / (taxPercentage+1)
    }
    
    func calcTipWithTipPercentage(taxPercentage: Double) -> Double {
        return subtotal * taxPercentage
    }
    
    func returnPossibleTips() -> [Int : Double] {
        let possibleTips: [Double] = [0.15, 0.18, 0.2]
        var returnValue = [Int: Double]()
        for tip in possibleTips {
            let intPercentage = Int(tip * 100)
            returnValue[intPercentage] = calcTipWithTipPercentage(tip)
        }
        
        return returnValue
    }
    
    func printPossibleTips() {
        println("15%: \(self.calcTipWithTipPercentage(0.15))")
        println("18%: \(self.calcTipWithTipPercentage(0.18))")
        println("20%: \(self.calcTipWithTipPercentage(0.2))")
    }
}

class TipCalculatorModel {
    var total: Double
    var taxPercentage: Double
    var subtotal: Double {
        get {
            return total / (taxPercentage+1)
        }
    }
    
    init(total: Double, taxPercentage: Double) {
        self.total = total
        self.taxPercentage = taxPercentage
    }
    
    
    
    func calcTipWithTipPercentage(tipPercentage: Double) -> (tipAmount:Double, totalAmount: Double) {
        let tipAmount = subtotal * tipPercentage
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func returnPossibleTips() -> [Int : (tipAmount:Double, totalAmount: Double)] {
        let possibleTips: [Double] = [0.15, 0.18, 0.2]
        var returnValue = Dictionary<Int, (tipAmount:Double, totalAmount: Double)>()
        for tip in possibleTips {
            let intPercentage = Int(tip * 100)
            returnValue[intPercentage] = calcTipWithTipPercentage(tip)
        }
        
        return returnValue
    }
}

class TestDataSource : NSObject, UITableViewDataSource {
    let tipCalculator : TipCalculatorModel = TipCalculatorModel(total: 50, taxPercentage: 0.04)
    var possibleTips = Dictionary<Int, (tipAmount: Double, totalAmount: Double)>()
    var sortedKeys: [Int] = []
    
    override init() {
        self.possibleTips = tipCalculator.returnPossibleTips()
        self.sortedKeys = sorted(Array(possibleTips.keys))
        super.init()
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
}

let tipCalculator = TipCalculator(total: 55.2, taxPercentage: 0.05)
tipCalculator.returnPossibleTips()

let testDataSource = TestDataSource()
let tableView = UITableView(frame: CGRectMake(0, 0, 300, 300), style: UITableViewStyle.Plain)
tableView.dataSource = testDataSource
tableView.reloadData()


