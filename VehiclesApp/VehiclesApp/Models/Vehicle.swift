//
//  Vehicle.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/6/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

class Vehicle {
    let brandName: String
    let modelName: String
    let modelYear: Int
    let powerSource: String
    let numberOfWheels: Int
    
    init(brandName:String, modelName:String, modelYear:Int, powerSource:String, numberOfWheels:Int) {
        self.brandName = brandName
        self.modelName = modelName
        self.modelYear = modelYear
        self.powerSource = powerSource
        self.numberOfWheels = numberOfWheels
    }
    
    var vehiclePreview: String {
        return String(format: "%@ %@ %i", self.brandName, self.modelName, self.modelYear)
    }
    
    var vehicleDetails:String {
        var details = "Basic vehicle details:\n\n"
        details += "Brand name: \(brandName)\n"
        details += "Model name: \(modelName)\n"
        details += "Model year: \(modelYear)\n"
        details += "Power source: \(powerSource)\n"
        details += "# of wheels: \(numberOfWheels)\n"
        return details
    }
    
    func goForward() -> String {
        return "null"
    }
    
    func goBackwards() -> String {
        return "null"
    }
    
    func stopMoving() -> String {
        return "null"
    }
    
    func turn(degrees: Int) -> String {
        var normalizedDegrees = degrees
        let degreesInCircle = 360
        
        if normalizedDegrees > degreesInCircle || normalizedDegrees < -degreesInCircle {
            normalizedDegrees = normalizedDegrees % degreesInCircle
        }
        
        return String(format: "Turn %d degrees. ", normalizedDegrees)
    }
    
    func changeGear(newGearName: String) -> String {
        return String(format: "Put %@ into %@ gear.", self.modelName, newGearName)
    }
    
    func makeNoise() -> String {
        return "null"
    }
}

// Adapter Pattern with PROTOCOL EXTENSION
extension Vehicle : Printable {
    var description:String {
        return vehiclePreview + "\n" + vehicleDetails
    }
}