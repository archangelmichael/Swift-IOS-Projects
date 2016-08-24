//
//  Bowtie+CoreDataProperties.swift
//  Proj2-BowTie
//
//  Created by Radi on 8/24/16.
//  Copyright © 2016 archangel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bowtie {

    @NSManaged var name: String?
    @NSManaged var searchKey: String?
    @NSManaged var isFavorite: NSNumber?
    @NSManaged var rating: NSNumber?
    @NSManaged var lastWorn: NSDate?
    @NSManaged var timesWorn: NSNumber?
    @NSManaged var photoData: NSData?
    @NSManaged var tintColor: NSObject?

}
