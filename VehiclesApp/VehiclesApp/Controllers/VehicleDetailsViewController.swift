//
//  VehicleDetailsViewController.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/7/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import UIKit

class VehicleDetailsViewController: UIViewController {
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var detailsTextView: UITextView!
    var currentVehicle: Vehicle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentVehicle != nil {
            self.detailsLabel.text = currentVehicle?.vehiclePreview
            self.detailsTextView.text = currentVehicle?.vehicleDetails
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goForward(sender: AnyObject) {
        if let vehicle = currentVehicle {
            let controller = UIAlertController.alertControllerWithTitle("Go Forward", message: vehicle.goForward())
            presentViewController(controller, animated: true) {}
        }
    }
    
    @IBAction func goBackward(sender: AnyObject) {
        if let vehicle = currentVehicle {
            let controller = UIAlertController.alertControllerWithTitle("Go Backward", message: vehicle.goBackwards())
            presentViewController(controller, animated: true) {}
        }
    }
    
    @IBAction func stopMoving(sender: AnyObject) {
        if let vehicle = currentVehicle {
            let controller = UIAlertController.alertControllerWithTitle("Stop Moving", message: vehicle.stopMoving())
            presentViewController(controller, animated: true) {}
        }
    }
    
    @IBAction func makeNoise(sender: AnyObject) {
        if let vehicle = currentVehicle {
            let controller = UIAlertController.alertControllerWithTitle("Make Some Noise!", message: vehicle.makeNoise())
            presentViewController(controller, animated: true) {}
        }
    }
    
    @IBAction func turn(sender: AnyObject) {
        if let vehicle = currentVehicle {
            let controller = UIAlertController.alertControllerWithNumberInput(title: "Turn", message: "Enter number of degrees to turn:", buttonTitle: "Go!") {
                integerValue in
                if let value = integerValue {
                    let controller = UIAlertController.alertControllerWithTitle("Turn", message: vehicle.turn(value))
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            }
            presentViewController(controller, animated: true) {}
        }
    }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController?.popToViewController(ViewController(), animated: true)
    }
}
