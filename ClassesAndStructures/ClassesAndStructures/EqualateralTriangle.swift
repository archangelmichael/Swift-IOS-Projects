//
//  EqualateralTriangle.swift
//  ClassesAndStructures
//
//  Created by Radi on 4/17/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation
class EqualateralTriangle: Shape {
    var sideLength: Double = 0.0
    
    init(side: Double, name: String) {
        self.sideLength = side
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get{
            return 3 * self.sideLength
        }
        set{
            self.sideLength = newValue / 3
        }
    }
    
    func calcArea() -> Double {
        return self.sideLength * self.sideLength * sqrt(3) / 4
    }
    
    override func description() -> String {
        return "A Equalateral triabgle with sides of \(self.sideLength)"
    }
}