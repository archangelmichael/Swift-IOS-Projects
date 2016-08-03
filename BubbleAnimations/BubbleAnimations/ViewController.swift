//
//  ViewController.swift
//  BubbleAnimations
//
//  Created by Radi on 8/3/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnBubbles: UIButton!
    @IBOutlet weak var lblBubbles: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var expand: Bool = false
    var bubbles: Array<Bubble> = []
    
    let animationDuration = 0.7
    let bubbleOffset : CGFloat = 20.0
    
    var numberOfBubbles : Int = 6
    
    let maxBubbleSize : CGFloat = 90.0
    let minBubbleSize : CGFloat = 60.0
    var bubbleSize : CGFloat = 60.0
    
    var radius : CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepper.maximumValue = 30
        self.stepper.minimumValue = 2
        self.stepper.continuous = false
        self.stepper.value = Double(self.numberOfBubbles)
        self.resetBubblesCounter()
        
        self.btnBubbles.layer.cornerRadius = self.btnBubbles.frame.size.width/2
        self.btnBubbles.clipsToBounds = true
        
        self.clearBubbles()
        self.expand = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.calculateMaxSize()
        self.loadBubbles(self.stepper.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onShowBubbles(sender: AnyObject) {
        if self.expand { // Hide bubbles
            self.hideBubbles()
        }
        else { // Show bubbles
            self.showBubbles()
        }
        
        self.expand = !self.expand
    }
    
    @IBAction func onAddRemoveBubble(stepper: UIStepper) {
        self.loadBubbles(stepper.value)
        self.numberOfBubbles = Int(stepper.value)
        self.resetBubblesCounter()
        self.expand = false
    }
    
    func resetBubblesCounter() -> Void {
        self.lblBubbles.text = "\(round(self.stepper.value)) Bubbles"
    }
    
    func calculateMaxSize() {
        let viewSize : CGSize = self.view.frame.size
        let centerSize : CGSize = self.btnBubbles.frame.size
        let centerOrigin : CGPoint = self.btnBubbles.frame.origin
        
        let topRange = centerOrigin.y
        let leftRange = centerOrigin.x
        let bottomRange = viewSize.height - centerOrigin.y - centerSize.height
        let rightRange = viewSize.width - centerOrigin.x - centerSize.width
        let ranges : Array<CGFloat> = [topRange, leftRange, bottomRange, rightRange]
        let minRange = ranges.minElement()!
        
        if minRange >= self.bubbleOffset * 2 + self.maxBubbleSize {
            self.bubbleSize = self.maxBubbleSize
            self.radius = centerSize.width/2 + self.bubbleSize/2 + self.bubbleOffset
        }
        else if minRange < self.bubbleOffset * 2 + self.maxBubbleSize &&
            minRange >= self.bubbleOffset * 2 + self.minBubbleSize {
            self.bubbleSize = minRange - self.bubbleOffset * 2
            self.radius = centerSize.width/2 + self.bubbleSize/2 + self.bubbleOffset
        }
        else {
            self.bubbleSize = self.minBubbleSize
            self.radius = centerSize.width/2 + self.bubbleSize/2 + self.bubbleOffset/2
        }
    }
    
    func loadBubbles(count: Double) -> Void {
        self.clearBubbles()
        
        let bubblesCount = Int(count)
        let bubbleCenterFrame = CGRectMake(self.btnBubbles.frame.origin.x + self.btnBubbles.frame.size.width/2 - self.bubbleSize/2,
                                           self.btnBubbles.frame.origin.y + self.btnBubbles.frame.size.height/2 - self.bubbleSize/2,
                                           self.bubbleSize, self.bubbleSize)
        
        for _ in 0...bubblesCount - 1 {
            let bubble : Bubble = Bubble.instanceFromNib(bubbleCenterFrame,
                                                         title: self.getRandomGroup(),
                                                         count: self.getRandomNumber())
            self.bubbles.append(bubble)
            self.view.addSubview(bubble)
            self.view.sendSubviewToBack(bubble)
        }
    }
    
    func clearBubbles() -> Void {
        for bubble : Bubble in self.bubbles {
            bubble.removeFromSuperview()
        }
        
        self.bubbles.removeAll()
    }
    
    func showBubbles() -> Void {
        let centerPoint = self.btnBubbles.center
        let startAngle : CGFloat = -180.0
        let deviataionAngle : CGFloat = 360.0 / CGFloat(self.numberOfBubbles)
        
        UIView.animateWithDuration(animationDuration) {
            for index : Int in 0...self.bubbles.count - 1 {
                let bubble = self.bubbles[index]
                let currentDeviationAngle : CGFloat = CGFloat(index) * deviataionAngle
                let dx : CGFloat = self.radius * cos(startAngle + currentDeviationAngle * CGFloat(M_PI/180))
                let dy : CGFloat = self.radius * sin(startAngle + currentDeviationAngle * CGFloat(M_PI/180))
                
                bubble.center = CGPointMake(centerPoint.x + dx,
                                            centerPoint.y + dy)
            }
        }
    }
    
    func hideBubbles() -> Void {
        let centerPoint = self.btnBubbles.center
        UIView.animateWithDuration(animationDuration) {
            for index : Int in 0...self.bubbles.count - 1 {
                let bubble = self.bubbles[index]
                bubble.center = CGPointMake(centerPoint.x,
                                            centerPoint.y)
            }
        }
    }
    
    func getRandomNumber() -> UInt {
        return UInt(arc4random_uniform(120) + 3)
    }
    
    func getRandomGroup() -> String {
        let array = ["LEAVE", "ITSM", "YAMMER", "DocuSign", "Calendar", "Mobile Expenses"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        return array[randomIndex]
    }

}

