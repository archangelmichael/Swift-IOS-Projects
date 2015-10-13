//
//  MapVCExtension.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/13/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Camera {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: 0, y: 0)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            
            //view.pinColor = annotation.pinColor()
            view.image = annotation.pinImage()
            return view
        }
        else {
            self.pinAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.InfoLight)
            self.pinAnnotationView.canShowCallout = true
            return self.pinAnnotationView
        }
    }
    
    // Second variant
//    func mapView(mapView: MKMapView,
//        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
//            self.pinAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.InfoLight)
//            self.pinAnnotationView.canShowCallout = true
//            return self.pinAnnotationView
//    }
}