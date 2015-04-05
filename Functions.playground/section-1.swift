// Playground - noun: a place where people can play

import UIKit

var str = "Swift Functions"

// Define functions
let height = 12.23
let width = 14.23

func calculateArea (width: Double, height: Double) -> Double {
    return width * height
}

println("Area: \(calculateArea(width, height))")

// Define labels for parameters
func calculateParameter (#width: Double, #height: Double) -> Double {
    return width * height
}

calculateParameter(width: 12.4, height: 23.5)

// Define Different labels for parameters
func calculateHalfArea(midheight height: Double, midwidth width: Double) -> Double {
    return height * width
}

calculateHalfArea(midheight: height/2, midwidth: width/2)

// Tuples
func searchForWord(#word: String) -> (Bool, String) {
    var found = (false, "\(word) is not found")
    var sentance = "this is a very long sentance"
    if sentance.lowercaseString.rangeOfString(word) != nil {
        found = (true, "\(word) has been found")
    }
    
    return found
}

println(searchForWord(word: "long"))

// Access fields independantly
let (isfound, message) = searchForWord(word: "long")
println(isfound)

// Use '_' as default name if you dont need it
let (_, details) = searchForWord(word: "long")
println(details)

// Label tuple's fields
func search(#word: String) -> (found: Bool, message: String) {
    var found = (false, "\(word) is not found")
    var sentance = "this is a very long sentance"
    if sentance.lowercaseString.rangeOfString(word) != nil {
        found = (true, "\(word) has been found")
    }
    
    return found
}

println(search(word: "is").message)

// Optionals
func matchesNumber(appNumber: String) -> String? {
    var appNumbers = ["1", "2", "3"]
    for num in appNumbers {
        if  num == appNumber {
            return num
        }
    }
    
    return nil
}

if let result = matchesNumber("2") {
    println("\(result) is found")
} else {
    println("No match found")
}

// Chaining
func sendNotice(num: Int) {
    println("\(num) found")
}

// Variant 1 with no chaining
if let result = matchesNumber("2") {
    if let num = result.toInt() {
        sendNotice(num)
    }
}

// Variant 2 with chaining
if let result = matchesNumber("2")?.toInt() {
    sendNotice(result)
}

// Exercise isDivisible
func isNumDivisible(#divident: Int, #divider: Int) -> Bool? {
    if divident % divider == 0 {
        return true
    }
    
    return nil
}

if let result = isNumDivisible(divident: 12, divider: 5) {
    println("Divisible")
} else {
    println("Not Divisible")
}