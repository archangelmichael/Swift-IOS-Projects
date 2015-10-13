//
//  Camera.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/12/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit
import MapKit

class Camera: NSObject, MKAnnotation {
    let coordinate : CLLocationCoordinate2D
    let title : String?
    let subtitle : String?
    
    let speedLimit : Int?
    let hasSpeedLimit : Bool
    
    let road : String?
    let town : String?
    
    let comment : String?
    
    init(latitude:Double,
        longitude:Double,
        speedLimit:Int?,
        road:String?,
        town:String?,
        comment: String?) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            self.speedLimit = speedLimit
            self.hasSpeedLimit = speedLimit > 0
            self.title = self.hasSpeedLimit ? "Speed Cam" : "Traffic Cam"
            self.subtitle = self.hasSpeedLimit ? "\(self.speedLimit!) km/h" : "no speed detection"
            
            self.road = road
            self.town = town
            
            self.comment = comment
        
            super.init()
    }
    
    func pinColor() -> MKPinAnnotationColor  {
        return self.hasSpeedLimit ? MKPinAnnotationColor.Red : MKPinAnnotationColor.Green
    }
    
    func pinImage() -> UIImage {
        let imageName = self.hasSpeedLimit ? "speed-cam" : "traffic-cam"
        let pinImage =  UIImage(named: imageName)!.scaledToSize(CGSizeMake(30, 30))
        return pinImage
    }
}