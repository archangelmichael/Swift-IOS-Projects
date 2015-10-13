//
//  ViewController.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/12/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, CLLocationManagerDelegate{

    var cameras : [Camera] = []
    @IBOutlet weak var mapView: MKMapView!
    // MARK: - Map Search Variables
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    // MARK: - Map Settings
    @IBOutlet weak var barButtonSettings: UIBarButtonItem!
    var contentController:UITableViewController!
    var tableMapOptions:UITableView!
    var mapType:UISegmentedControl!
    var showPointsOfInterest:UISwitch!
    
    // MARK: - Pin Details
    var mapItemData:MKMapItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        self.mapView.delegate = self
        self.getCameras()
        self.mapView.addAnnotations(cameras)
        
        // Set map initial zoom level and region
        self.setMapInitialLocation()
        
        self.setMapSettings()
        
        // Uncomment if you want to center map on user location
        // checkLocationAuthorizationStatus()
    }
    
    // MARK: - Setting Map Locations Methods
    let regionRadius: CLLocationDistance = 10000 // 10kms
    func setMapInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: 42.698038, longitude: 23.321965) // Sofia, Bulgaria
        self.centerMapOnLocation(initialLocation)
    }
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            location,
            regionRadius * 2.0,
            regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Search methods
    @IBAction func onSearch(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        // Hide search bar
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        
        // Clear map previous annotation
//        if self.mapView.annotations.count != 0{
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            // Show alert if location is not found
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            self.mapItemData = localSearchResponse?.mapItems.last
            
            // Place pin and center on found location
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(
                latitude: localSearchResponse!.boundingRegion.center.latitude,
                longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            
            // Show search location pin on map
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    
    // MARK: - Go to pin details
    func mapView(mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl){
            self.performSegueWithIdentifier("PinDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?){
            var pinDetailsVC = DetailsViewController()
            pinDetailsVC = segue.destinationViewController as! DetailsViewController
            pinDetailsVC.mapItemData = self.mapItemData
    }
    
    // MARK: - Settings methods
    func setMapSettings() {
        tableMapOptions = UITableView()
        tableMapOptions.separatorStyle = UITableViewCellSeparatorStyle.None
        tableMapOptions.dataSource = self
        contentController = UITableViewController()
        contentController.tableView = tableMapOptions
    }
    
    @IBAction func onSettings(sender: AnyObject) {
        // Set popover
        contentController.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popPC:UIPopoverPresentationController = contentController.popoverPresentationController!
        popPC.barButtonItem = self.barButtonSettings
        popPC.permittedArrowDirections = UIPopoverArrowDirection.Any
        popPC.delegate = self
        presentViewController(contentController, animated: true, completion: nil)
    }
    
    // MARK: - Adaptive display for popovers
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .FullScreen
    }
    
    func presentationController(controller: UIPresentationController,
        viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController?{
            let navController:UINavigationController = UINavigationController(rootViewController: controller.presentedViewController)
            controller.presentedViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action:"done")
            return navController
    }
    
    func done (){
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
        if showPointsOfInterest.on{
            mapView.showsPointsOfInterest = true
        }else{
            mapView.showsPointsOfInterest = false
        }
        
        if mapType.selectedSegmentIndex == 0{
            mapView.mapType = MKMapType.Standard
        }else if mapType.selectedSegmentIndex == 1{
            mapView.mapType = MKMapType.Satellite
        }else if mapType.selectedSegmentIndex == 2{
            mapView.mapType = MKMapType.Hybrid
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController){
        done()
    }
    
    // MARK: - Table view delegate and data source methods
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cellIdentifier")
            if cell == nil{
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cellIdentifier")
                if indexPath.row == 0{
                    mapType = UISegmentedControl(items: ["Standard","Satellite","Hybrid"])
                    mapType.center = cell.center
                    cell.addSubview(mapType)
                }
                if indexPath.row == 1{
                    showPointsOfInterest = UISwitch()
                    cell.textLabel?.text = "Show Points Of Interest"
                    cell.accessoryView = showPointsOfInterest
                }
            }
            return cell
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return 2
    }
    
    // MARK: - User Location Follow
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.Denied {
            self.setMapInitialLocation()
        }
        else {
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        self.centerMapOnLocation((newLocation?.coordinate)!)
    }

    func getCameras() {
        cameras = [
            Camera(latitude: 42.679678, longitude: 23.344411, speedLimit: nil, road: "Peyo K. Yavorov 2", town: "Sofia", comment: nil),
            Camera(latitude: 42.688934, longitude: 23.339924, speedLimit: 50, road: "Tsarigradsko Shose 13", town: "Sofia", comment: "Orlov Most"),
            Camera(latitude: 42.704804, longitude: 23.328985, speedLimit: 50, road: "Slivnitsa 265", town: "Sofia", comment: nil),
            Camera(latitude: 42.714064, longitude: 23.327928, speedLimit: 50, road: "202-a", town: "Sofia", comment: "Shell"),
            Camera(latitude: 42.707499, longitude: 23.458348, speedLimit: 60, road: "Botevgradsko Shose 9", town: "Sofia", comment: "Jumbo")
        ]
    }
}

