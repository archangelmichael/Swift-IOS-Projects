//
//  Connection.swift
//  Graphs
//
//  Created by Radi on 5/16/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Connection: NSObject {
    var from : Node
    var to : Node
    var color : UIColor
    var size : Double
    
    init(from:Node, to:Node, color:String, size:Double) {
        self.from = from
        self.to = to
        self.color = UIColor(hex: color.stringByReplacingOccurrencesOfString("#", withString: "0x"))
        self.size = size
    }
}
