//
//  Square.swift
//  ClassesAndStructures
//
//  Created by Radi on 4/17/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation
class Square: Shape {
    var sideLength: Double
    
    init(side: Double, name: String) {
        self.sideLength = side
        super.init(name: name)
        numberOfSides = 4
    }
    
    override func description() -> String {
        return "A square with sides of \(self.sideLength)"
    }
    
    func calcArea() -> Double {
        return self.sideLength * self.sideLength
    }
}