//
//  ViewController.swift
//  StormMe
//
//  Created by Radi on 6/1/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let apiKey = "a6654c8a6dd0b6d4b5032b30fb27a688"
    let locationManager = CLLocationManager()
    var latitude: Double = 42.8
    var longitude: Double = 24.4
    var locationSummary: String = "Somewhere, On Earth"
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        let authstate = CLLocationManager.authorizationStatus()
        if(authstate == CLAuthorizationStatus.NotDetermined){
            println("Not Authorised")
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
            self.showAlertView("Location Warning", message: "StromMe needs your location to give you weather info.")
        }
        
        locationManager.startUpdatingLocation()
        loadingIndicator.hidden = true
        onRefresh()
    }

    @IBAction func onRefresh() {
        refreshButton.hidden = true
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() -> Void {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "\(latitude),\(longitude)", relativeToURL: baseURL)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask : NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            if  error == nil {
                // var urlContents = NSString(contentsOfURL: location, encoding: NSUTF8StringEncoding, error: nil)
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil)  as! NSDictionary
                // println(weatherDictionary)
                let currentWeather = CurrentWeather(weatherDictionary: weatherDictionary)
                println(currentWeather.currentTime!)
                
                // Get on main thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.iconView.image = currentWeather.icon!
                    
                    self.locationLabel.text = self.locationSummary
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
            }
            else {
                self.showAlertView("ERROR", message: "Nework Error")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
            }
        })
        
        downloadTask.resume()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var location:CLLocation = locations[locations.count - 1] as! CLLocation
        // println("\(location.description)")
        if(location.horizontalAccuracy > 0){
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                let city: String = (pm.locality != nil) ? pm.locality : "Somewhere"
                let country: String = (pm.country != nil) ? pm.country : "On Earth"
                self.locationSummary = "\(city), \(country)"
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Couldn't get your location")
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // Show user location on map only if authorized mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    func showAlertView(title: String, message: String) -> Void {
        let networkIssueController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel, handler: nil)
        networkIssueController.addAction(okButton)
        networkIssueController.addAction(cancelButton)
        self.presentViewController(networkIssueController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

