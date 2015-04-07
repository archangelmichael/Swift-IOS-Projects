//
//  ViewController.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/6/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var vehicleTableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VehicleList.sharedInstance.vehicles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = vehicleTableView.dequeueReusableCellWithIdentifier("vehicleCell", forIndexPath: indexPath) as UITableViewCell
        
        let currentRow = indexPath.row
        let currentVehicle = VehicleList.sharedInstance.vehicles[currentRow] as Vehicle
        
        // Change cell selection background color
        var selectBackgroundColor = UIView()
        selectBackgroundColor.backgroundColor = UIColor.greenColor()
        cell.selectedBackgroundView = selectBackgroundColor
    
        // Change text color
        cell.textLabel?.textColor = UIColor.blueColor()
        
        
        cell.textLabel?.text = currentVehicle.vehiclePreview
        cell.detailTextLabel?.text = "\(currentVehicle.makeNoise())"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "viewDetailsSegue" {
            if let indexPath = self.vehicleTableView.indexPathForSelectedRow() {
                let vehicle = VehicleList.sharedInstance.vehicles[indexPath.row]
                (segue.destinationViewController as VehicleDetailsViewController).currentVehicle = vehicle
            }
        }
        
//        var dvc: VehicleDetailsViewController = segue.destinationViewController as VehicleDetailsViewController
//        var selectedRow = self.vehicleTableView.indexPathForSelectedRow()?.row
//        var selectedVehicle = vehicles[selectedRow!];
//        dvc.currentVehicle = selectedVehicle
        
    }
}

