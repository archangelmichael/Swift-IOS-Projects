//
//  FactBook.swift
//  FactsSimpleApp
//
//  Created by Radi on 4/22/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import Foundation

struct FactBook {
    let factsArray = [
        "Ants strech when they wake up in the morning.",
        "Ostriches can un faster than horses.",
        "Olympic gold medal are actually mostly made of silver",
        "You are born with 300 bones, but by the time you are an adult you will have 206",
        "It takes about 8 minutes for light from the Sun to reach Earth",
        "Some bamboo plants can grow almost a meter in just one day",
        "Some penguins can leap 2-3 meters out of the water",
        "The state of Florida is bigger than England",
        "On average, it takes 66 days to form a new habit",
        "Mammoths still walked the earth when Great Pyramid was being built."
    ]
 
    func getRandomFact() -> String {
        let index : Int = Int(arc4random_uniform(UInt32(factsArray.count)))
        return factsArray[index];
    }
}