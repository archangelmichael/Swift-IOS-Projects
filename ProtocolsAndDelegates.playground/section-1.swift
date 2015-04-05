// Playground - noun: a place where people can play

import UIKit
import Foundation

@objc protocol Speaker {
    func speak()
    optional func tellJoke()
}

protocol DateSimulatorDelegate {
    func dateDidStart(simulator: DateSimulator, a: Speaker, b:Speaker)
    func dateDidEnd(simulator: DateSimulator, a: Speaker, b:Speaker)
}

class Man : Speaker {
    func speak() {
        println("Hi. I am Adam ")
    }
    
    func tellJoke() {
        println("I am the last man on Earth ")
    }
    
    func act() {
        println("I like you anyway ")
    }
}

class Woman : Speaker {
    func speak() {
        println("Hi. I am Eve ")
    }
    
    func tellJoke() {
        println("I have crabs ")
    }
}

class DateSimulator {
    let adam: Man
    let eve: Woman
    var delegate: DateSimulatorDelegate?
    
    init(adam: Man, eve: Woman) {
        self.adam = adam
        self.eve = eve
    }
    
    func simulate() {
        self.delegate?.dateDidStart(self, a: adam, b: eve)
        println("Meeting... ")
        adam.speak()
        eve.speak()
        println("Later this evening... ")
        adam.tellJoke()
        eve.tellJoke()
        adam.act()
        self.delegate?.dateDidEnd(self, a: adam, b: eve)
    }
}

class LogginDateSimulator: DateSimulatorDelegate {
    func dateDidEnd(simulator: DateSimulator, a: Speaker, b:Speaker) {
        println("Date Ended")
    }
    
    func dateDidStart(simulator: DateSimulator, a: Speaker, b:Speaker) {
        println("Date Started")
    }
}



var speaker: Speaker
speaker = Man()
speaker.speak()
speaker.tellJoke!()
(speaker as Man).act()

speaker = Woman()
speaker.speak()
speaker.tellJoke!()

let simulation = DateSimulator(adam: Man(), eve: Woman())
simulation.delegate = LogginDateSimulator()
simulation.simulate()