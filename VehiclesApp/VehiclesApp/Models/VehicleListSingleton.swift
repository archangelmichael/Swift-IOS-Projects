//
//  VehicleListSingleton.swift
//  VehiclesApp
//
//  Created by ARCHANGEL on 4/7/15.
//  Copyright (c) 2015 ARCHANGEL. All rights reserved.
//

import Foundation

class VehicleList {
    let vehicles:[Vehicle] = []
    
    class var sharedInstance: VehicleList {
        struct Singleton {
            static let instance = VehicleList()
        }
        return Singleton.instance
    }
    
    init() {
        // Create a car.
        var mustang = Car(brandName: "Ford", modelName: "Mustang", modelYear: 1968, powerSource: "gas engine",
            isConvertible: true, isHatchback: false, hasSunroof: false, numberOfDoors: 2)
        
        // Add it to the array
        vehicles.append(mustang)
        
        // Create another car.
        var outback = Car(brandName: "Subaru", modelName: "Outback", modelYear: 1999, powerSource: "gas engine",
            isConvertible: false, isHatchback: true, hasSunroof: false, numberOfDoors: 5)
        
        // Add it to the array.
        vehicles.append(outback)
        
        // Create another car
        var prius = Car(brandName: "Toyota", modelName: "Prius", modelYear: 2002, powerSource: "hybrid engine",
            isConvertible: false, isHatchback: true, hasSunroof: true, numberOfDoors: 4)
        
        // Add it to the array.
        vehicles.append(prius)
        
        // Create a motorcycle
        var harley = Motorcycle(brandName: "Harley-Davidson", modelName: "Softail", modelYear: 1979,
            engineNoise: "Vrrrrrrrroooooooooom!")
        
        // Add it to the array.
        vehicles.append(harley)
        
        // Create another motorcycle
        var kawasaki = Motorcycle(brandName: "Kawasaki", modelName: "Ninja", modelYear: 2005,
            engineNoise: "Neeeeeeeeeeeeeeeeow!")
        
        // Add it to the array
        self.vehicles.append(kawasaki)
        
        // Create a truck
        var silverado = Truck(brandName: "Chevrolet", modelName: "Silverado", modelYear: 2011,
            powerSource: "gas engine", numberOfWheels: 4, cargoCapacityInCubicFeet: 53)
        
        // Add it to the array
        vehicles.append(silverado)
        
        // Create another truck
        var eighteenWheeler = Truck(brandName: "Peterbilt", modelName: "579", modelYear: 2013,
            powerSource: "diesel engine", numberOfWheels: 18, cargoCapacityInCubicFeet: 408)
        
        // Add it to the array
        vehicles.append(eighteenWheeler)
        
        // Sort the array by the model year
        vehicles.sort { $0.modelYear < $1.modelYear }
    }
}