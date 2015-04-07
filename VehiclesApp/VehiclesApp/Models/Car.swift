//
//  Car.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/6/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

class Car : Vehicle {
    let isConvertable: Bool
    let isHatchback: Bool
    let hasSunroof: Bool
    let numberOfDoors: Int
    
    init(brandName: String, modelName: String, modelYear: Int, powerSource: String,
        isConvertible: Bool, isHatchback: Bool, hasSunroof: Bool, numberOfDoors: Int) {
        self.isConvertable = isConvertible
        self.isHatchback = isHatchback
        self.hasSunroof = hasSunroof
        self.numberOfDoors = numberOfDoors
            
        super.init(brandName: brandName, modelName: modelName, modelYear: modelYear,
                powerSource: powerSource, numberOfWheels: 4)
    }
    
    override var vehicleDetails:String {
        // Get basic details from superclass
        let basicDetails = super.vehicleDetails
        
        // Initialize mutable string
        var carDetailsBuilder = "\n\nCar-Specific Details:\n\n"
        
        // String helpers for booleans
        let yes = "Yes\n"
        let no = "No\n"
        
        // Add info about car-specific features.
        carDetailsBuilder += "Has sunroof: "
        carDetailsBuilder += hasSunroof ? yes : no
        
        carDetailsBuilder += "Is Hatchback: "
        carDetailsBuilder += isHatchback ? yes : no
        
        carDetailsBuilder += "Is Convertible: "
        carDetailsBuilder += isConvertable ? yes : no
        
        carDetailsBuilder += "Number of doors: \(numberOfDoors)"
        
        // Create the final string by combining basic and car-specific details.
        let carDetails = basicDetails + carDetailsBuilder
        
        return carDetails
    }
    
    private func start() -> String {
        return String( format: "Start power source %@.", self.powerSource)
    }
    
    override func goForward() -> String {
        return String(format: "%@ %@ Then depress gas pedal.", self.start(), self.changeGear("Forward"))
    }
    
    override func goBackwards() -> String {
        return String(format: "%@ %@ Check your rear view mirror. Then depress gas pedal.", self.start(), self.changeGear("Reverse"))
    }
    
    override func stopMoving() -> String {
        return String(format: "Depress break pedal. %@", self.changeGear("Park"))
    }
    
    override func makeNoise() -> String {
        return "Hit The horn! BEEEEEP"
    }
}