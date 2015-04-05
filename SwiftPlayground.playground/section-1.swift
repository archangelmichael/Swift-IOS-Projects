
// Playground - noun: a place where people can play

import UIKit

// Variables / Operators / Types
var str = "Hello"
let str2 = "Immutable Hello"
var language = "Swift"
println("\(str) \(language)")

let num = 12
let divided = Double(num)/2.3
var negative = -num

// Arrays / Dictionaries
var arr: [String] = ["str", "str 2"]
arr += ["str3"]
arr += ["str4", "str5"]
var mixedArr = [ 12, "str", 23.23]
var emptyArr = []
var copiedArr = Array(mixedArr)
var copiedArr2 = NSArray(array: mixedArr)
println(mixedArr)
println(mixedArr[2])

var dict = ["key1": "val1", "key2": "val2"]
println(dict["key1"])
println(dict["nokey"])
dict["nokey"] = "set value"
dict

dict.removeValueForKey("key1")
dict

for key in dict.keys {
    print("\(dict[key]) ")
}

println(dict)

// Controll Flow Structures And Operators
for num in 1..<10 {
    print(num)
}

for num in 1...10 {
    print(num)
}

for var i = 1; i<10; i++ {
    print(i)
}

var cards = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]
var index = 0;
do {
    switch cards[index] {
    case 1,11,12,13:
        print("pic")
    case 2...10:
        print("num")
    default:
        print("Joker")
    }
    
    index++
} while index < cards.count

// FIZZ - BUZZ Generator
var numbers = [23, 45, 234, 65, 324, 623, 412, 5, 65, 4, 45, 234, 2412, 34, 5, 43, 768796, 123, 34234, 45, 46, 4645233, 434, 35]
for num in numbers {
    if num%15 == 0 {
        println("FIZZ - BUZZ")
    }else if num%3 == 0 {
        println("FIZZ")
    }else if num%5 == 0 {
        println("BUZZ")
    }else {
        println(num)
    }
}


