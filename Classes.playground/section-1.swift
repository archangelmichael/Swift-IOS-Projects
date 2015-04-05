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

let tipCalculator = TipCalculator(total: 55.2, taxPercentage: 0.05)
tipCalculator.returnPossibleTips()

