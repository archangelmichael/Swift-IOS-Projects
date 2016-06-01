//
//  MapPlace.swift
//  GooglePlaces
//
//  Created by Radi on 5/31/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String? {
        return locationName
    }
    
    init(title: String,
         locationName: String,
         discipline: String,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
}
