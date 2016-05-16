//
//  Node.swift
//  Graphs
//
//  Created by Radi on 5/16/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Node: NSObject {
    var id : String
    var x : Double
    var y : Double
    var z : Double
    var color : UIColor
    var label : String
    var size : Double
    var connections : [Connection] = []
    
    init(id: String,
         x: String,
         y: String,
         z: String,
         color: String,
         size: Double,
         label: String){
        self.id = id
        self.x = Double(x)!
        self.y = Double(y)!
        self.z = Double(z)!
        self.color = UIColor(hex: color.stringByReplacingOccurrencesOfString("#", withString: "0x"))
        self.size = size
        self.label = label
    }
}
