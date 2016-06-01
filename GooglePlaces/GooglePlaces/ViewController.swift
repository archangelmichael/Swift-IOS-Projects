//
//  ViewController.swift
//  GooglePlaces
//
//  Created by Radi on 5/31/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

import iPhone_AR_Toolkit

class ViewController: UIViewController {
    
    @IBOutlet weak var mvMap: MKMapView!
    
    @IBOutlet weak var vInfo: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var userLocation : CLLocation?
    var updateLocation : Bool = true
    
    let placesAPIServerKey : String = "AIzaSyBDIxVrAidC0ppxUsBOe9h-4zVWr5udj14"
    let minSpan : MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
    var locations : [PlaceAnnotation] = []
    
    var placesClient: GMSPlacesClient?
    var placePicker: GMSPlacePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mvMap.delegate = self
        self.placesClient = GMSPlacesClient()
        self.setLoading(false)
        self.setLocationInfo(false, name: nil, address: nil)
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Get place for current location
    @IBAction func getCurrentPlace(sender: UIButton) {
        self.updateLocation = true
        
        if self.userLocation == nil {
            return;
        }
        
        self.setLoading(true);
        self.setLocationInfo(false, name: nil, address: nil)
        
        placesClient!.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                self.setLoading(false)
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    let address = place.formattedAddress!.componentsSeparatedByString(", ")
                        .joinWithSeparator("\n")
                    self.setLocationInfo(true, name: place.name, address: address)
                }
            }
            
            self.setLoading(false)
        })
    }
    
    @IBAction func getNearbyPlaces(sender: UIButton) {
        self.updateLocation = true
        
        self.clearMap()
        if self.userLocation == nil {
            return;
        }
        
        let center = self.userLocation!.coordinate
        let radius = 1000
        // let searchParams = "&type=restaurant&name=cruise"
        let searchURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(center.latitude),\(center.longitude)&radius=\(radius)&key=\(self.placesAPIServerKey)"

        if let url : NSURL? = NSURL(string: searchURL) {
            self.setLoading(true)
            self.setLocationInfo(false, name: nil, address: nil)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                if error != nil {
                    print("Failed getting nearby places")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.setLoading(false)
                    })
                }
                else {
                    var json: NSDictionary!
                    self.locations = []
                    do {
                        json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                        if let results = json["results"] as? [NSDictionary] {
                            for place in results {
                                guard let name = place.valueForKey("name") as? String,
                                    //let ID = place.valueForKey("id") as? String,
                                    let vicinity = place.valueForKey("vicinity") as? String,
                                    //let icon = place.valueForKey("icon") as? String,
                                    let placeID = place.valueForKey("place_id") as? String,
                                    let geometry = place.valueForKey("geometry") as? NSDictionary,
                                    let location = geometry.valueForKey("location") as? NSDictionary,
                                    let lat = location.valueForKey("lat") as? Double,
                                    let lon = location.valueForKey("lng") as? Double else {
                                        continue
                                }
                                
                                let annotation = PlaceAnnotation(title: name,
                                                                 locationName: vicinity,
                                                                 discipline: placeID,
                                                                 coordinate: CLLocationCoordinate2DMake(lat, lon))
                                self.locations.append(annotation)
                            }
                        }
                    }
                    catch {
                        print("Failed parsing data")
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.mvMap.addAnnotations(self.locations)
                        self.setLoading(false)
                    })
                }
            }
            
            task.resume()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? CameraARViewController {
            destinationVC.userLocation = self.mvMap.userLocation
            destinationVC.locations = self.locations
            destinationVC.delegate = self
        }
    }
}

extension ViewController : CameraARViewControllerDelegate {
    func cameraARViewControllerDidFinish(controller: CameraARViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// Map annotation methods
extension ViewController : MKMapViewDelegate{
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is PlaceAnnotation) {
            return nil
        }
        
        let reuseId = "place"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = self.resizeImage(UIImage(named:"rose_50.png")!)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let size = CGSizeMake(20, 20)// CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}

// Helper methods
extension ViewController {
    func clearMap() {
        let annotationsToRemove = self.mvMap.annotations.filter { $0 !== self.mvMap.userLocation }
        self.mvMap.removeAnnotations(annotationsToRemove)
    }
    
    func setLocationInfo(visible: Bool, name: String?, address: String?) {
        if visible {
            self.lblName.text = name!
            self.lblAddress.text = address!
        }
        else {
            self.lblName.text = "No current place"
            self.lblAddress.text = ""
        }
        
        self.vInfo.hidden = !visible
    }
    
    func setLoading(loading: Bool) {
        if loading {
            self.aiLoading.startAnimating()
        }
        else {
            self.aiLoading.stopAnimating()
        }
        
        self.view.userInteractionEnabled = !loading
    }
}

// User location delegate methods
extension ViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        
        if self.updateLocation {
            self.updateLocation = false
            self.mvMap.setRegion(
                MKCoordinateRegionMake(self.userLocation!.coordinate, self.minSpan),
                animated: false)
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            self.mvMap.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
        }
        else {
            self.mvMap.showsUserLocation = false
            self.locationManager.stopUpdatingLocation()
        }
    }
}

