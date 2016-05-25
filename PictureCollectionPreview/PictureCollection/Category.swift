//
//  Category.swift
//  PictureCollection
//
//  Created by Sandy L on 2016-03-09.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import Foundation

class Category {

    let name: String
    var photos = [String]()
    
    
    init(name: String, photos: NSArray) {
        self.name = name
        self.photos = photos as! [String]
    }

}