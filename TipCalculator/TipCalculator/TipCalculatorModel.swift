//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by ARCHANGEL on 4/4/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

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
    
    
    
    func calcTipWithTipPercentage(tipPercentage: Double) -> (tipAmount:Double, total: Double) {
        let tipAmount = subtotal * tipPercentage
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func returnPossibleTips() -> [Int : (tipAmount:Double, total: Double)] {
        let possibleTips: [Double] = [0.15, 0.18, 0.2]
        var returnValue = Dictionary<Int, (tipAmount:Double, total: Double)>()
        for tip in possibleTips {
            let intPercentage = Int(tip * 100)
            returnValue[intPercentage] = calcTipWithTipPercentage(tip)
        }
        
        return returnValue
    }
}
