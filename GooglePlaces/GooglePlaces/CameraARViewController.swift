//
//  CameraARViewController.swift
//  GooglePlaces
//
//  Created by Radi on 6/1/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import MapKit
import iPhone_AR_Toolkit

protocol CameraARViewControllerDelegate : AnyObject {
    func cameraARViewControllerDidFinish(controller: CameraARViewController)
}

class CameraARViewController: UIViewController {
    
    var delegate : CameraARViewControllerDelegate? = nil
    var userLocation : MKUserLocation? = nil

    var locations : [PlaceAnnotation]? = nil
    var geolocations : [ARGeoCoordinate]? = nil
    
    var arController : AugmentedRealityController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arController = AugmentedRealityController(view: self.view,
                                                       parentViewController: self,
                                                       withDelgate: self)
        
        
        self.arController?.minimumScaleFactor = 0.5
        self.arController?.scaleViewsBasedOnDistance = true
        self.arController?.rotateViewsBasedOnPerspective = true
        self.arController?.debugMode = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.geoLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClose(sender: AnyObject) {
        self.delegate?.cameraARViewControllerDidFinish(self)
    }
    
    func generateGeolocations() {
        if self.locations == nil {
            return
        }
        
        self.geolocations = Array()
        self.geolocations = []
        
        for annotation : PlaceAnnotation in self.locations! {
            let location : CLLocation = CLLocation(latitude: annotation.coordinate.latitude,
                                                   longitude: annotation.coordinate.longitude)
            
            
            let coordinate = ARGeoCoordinate(location: location, locationTitle: annotation.title!)
            coordinate.calibrateUsingOrigin(self.userLocation?.location)
            
            let marker = MarkerView(coordinate: coordinate,
                                    delegate: self)
            coordinate.displayView = marker
            
            self.arController?.addCoordinate(coordinate)
            self.geolocations!.append(coordinate)
        }
    }
}

extension CameraARViewController : MarkerViewDelegate {
    func didTouchMarkerView(markerView: MarkerView) {
        
    }
}

extension CameraARViewController : ARLocationDelegate {
    func geoLocations() -> NSMutableArray! {
        if(self.geolocations == nil) {
            self.generateGeolocations()
        }
        
        return NSMutableArray(array: self.geolocations!)
    }
    
    func locationClicked(coordinate: ARGeoCoordinate!) {
        
    }
}

extension CameraARViewController : ARMarkerDelegate {
    func didTapMarker(coordinate: ARGeoCoordinate!) {
        
    }
}

extension CameraARViewController : ARDelegate {
    func didUpdateHeading(newHeading: CLHeading!) {
        
    }
    
    func didUpdateLocation(newLocation: CLLocation!) {
        
    }
    
    func didUpdateOrientation(orientation: UIDeviceOrientation) {
        
    }
}

