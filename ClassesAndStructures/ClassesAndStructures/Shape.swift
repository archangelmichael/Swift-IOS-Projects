//
//  Shape.swift
//  ClassesAndStructures
//
//  Created by Radi on 4/17/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

class Shape {
    var numberOfSides:Int = 0
    var name:String
    
    init(name: String) {
        self.name = name
    }
    
    func description() -> String {
        return "Shape named \(self.name)"
    }
}