//
//  Circle.swift
//  ClassesAndStructures
//
//  Created by Radi on 4/17/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation
class Circle: Shape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
    }
    
    override func description() -> String {
        return "A circle with perimeter of \(self.radius * 2 * 3.14)"
    }
    
    func calcArea() -> Double {
        return 3.14 * self.radius * 2
    }
}