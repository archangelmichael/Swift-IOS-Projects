//
//  Motorcycle.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/7/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

class Motorcycle : Vehicle {
    let engineNoise: String
    
    init(brandName: String, modelName: String, modelYear: Int, engineNoise: String) {
        self.engineNoise = engineNoise
        super.init(brandName: brandName, modelName: modelName, modelYear: modelYear,
            powerSource: "gas engine", numberOfWheels: 2)
    }
    
    override var vehicleDetails:String {
        let basicDetails = super.vehicleDetails
        
        //Initialize mutable string
        var motorcycleDetailsBuilder = "\n\nMotorcycle-Specific Details:\n\n"
        
        //Add info about motorcycle-specific features.
        motorcycleDetailsBuilder += "Engine Noise: \(engineNoise)"
        
        let motorcycleDetails = basicDetails + motorcycleDetailsBuilder
        
        return motorcycleDetails
    }
    
    private func start() -> String {
        return String( format: "Start power source %@.", self.powerSource)
    }
    
    override func goForward() -> String {
        return String(format: "%@ Open throttle.", self.changeGear("Forward"))
    }
    
    override func goBackwards() -> String {
        return String(format: "%@ Walk %@ backwards using feet.", changeGear("Neutral"), modelName)
    }
    
    override func stopMoving() -> String {
        return "Squeeze brakes"
    }
    
    override func makeNoise() -> String {
        return self.engineNoise
    }
}