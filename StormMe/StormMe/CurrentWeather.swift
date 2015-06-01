//
//  CurrentWeather.swift
//  StormMe
//
//  Created by Radi on 6/1/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeatherDictionary: NSDictionary = weatherDictionary["currently"] as! NSDictionary
        temperature = currentWeatherDictionary["temperature"] as! Int
        humidity = currentWeatherDictionary["humidity"] as! Double
        precipProbability = currentWeatherDictionary["precipProbability"] as! Double
        summary = currentWeatherDictionary["summary"] as! String
        let iconString = currentWeatherDictionary["icon"] as! String
        icon = weatherIconFromString(iconString)
        let currentTimeIntInterval: Int = currentWeatherDictionary["time"] as! Int
        currentTime = dateStringFromUNIXTime(currentTimeIntInterval)
    }
    
    func dateStringFromUNIXTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
            case "clear-day": imageName = "clear-day"
            case "clear-night": imageName = "clear-night"
            case "rain": imageName = "rain"
            case "snow": imageName = "snow"
            case "sleet": imageName = "sleet"
            case "wind": imageName = "wind"
            case "fog":imageName = "fog"
            case "cloudy": imageName = "cloudy"
            case "partly-cloudy-day": imageName = "partly-cloudy-day"
            case "partly-cloudy-night": imageName = "partly-cloudy-night"
            default:imageName = "clear-day"
        }
        
        var iconImage = UIImage(named: imageName)
        return iconImage!
    }
}