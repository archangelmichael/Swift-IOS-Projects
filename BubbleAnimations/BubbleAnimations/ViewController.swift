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

    let sideOffset : CGFloat = 20.0 // Range from bubbles to outside views
    let bubbleOffset : CGFloat = 10.0 // Range between 2 neighbouring bubbles
    
    var centerCoordinate : CGPoint = CGPointMake(0, 0) // The coordinates of the center bubble
    var centerRadius : CGFloat = 50.0 // The diameter of the center bubble
    var currentCenterOffset : CGFloat = 100.0 // Distance between center coordinate and bubble center
    
    var numberOfBubbles : Int = 6
    
    let maxBubbleRadius : CGFloat = 50.0
    let minBubbleRadius : CGFloat = 30.0
    var currentBubbleRadius : CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepper.maximumValue = 30
        self.stepper.minimumValue = 2
        self.stepper.continuous = false
        self.stepper.value = Double(self.numberOfBubbles)
        self.resetBubblesCounter()
        
        self.centerRadius = self.btnBubbles.frame.size.width/2
        self.centerCoordinate = CGPointMake(self.btnBubbles.frame.origin.x + self.centerRadius,
                                            self.btnBubbles.frame.origin.y + self.centerRadius)
        
        self.btnBubbles.layer.cornerRadius = self.centerRadius
        self.btnBubbles.clipsToBounds = true
        
        self.clearBubbles()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.centerCoordinate = CGPointMake(self.btnBubbles.frame.origin.x + self.centerRadius,
                                            self.btnBubbles.frame.origin.y + self.centerRadius)
        self.calculateMaxSize()
        self.loadBubbles(self.stepper.value)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(orientationChanged(_:)),
                                                         name: UIDeviceOrientationDidChangeNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIDeviceOrientationDidChangeNotification,
                                                            object: nil)
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
        self.numberOfBubbles = Int(stepper.value)
        self.resetBubblesCounter()
        self.loadBubbles(stepper.value)
    }
    
    func resetBubblesCounter() -> Void {
        self.lblBubbles.text = "\(round(self.stepper.value)) Bubbles"
    }
    
    func calculateMaxSize() {
        let viewSize : CGSize = self.view.bounds.size
        
        let maxTopRadius = self.centerCoordinate.y - self.sideOffset
        let maxLeftRadius = self.centerCoordinate.x - self.sideOffset
        let maxBottomRadius = viewSize.height - self.centerCoordinate.y - self.sideOffset
        let maxRightRadius = viewSize.width - self.centerCoordinate.x - self.sideOffset // Should be equal to maxLeftRadius
        
        let allMaxRadius : Array<CGFloat> = [maxTopRadius, maxLeftRadius, maxBottomRadius, maxRightRadius]
        let minOutsideRadius = allMaxRadius.minElement()! // The radius to fit all bubbles in with side offset
        
        if minOutsideRadius < self.centerRadius + self.minBubbleRadius * 2 {
            // Allowed radius is smaller than the smallest bubble possible
            self.currentBubbleRadius = self.minBubbleRadius
            self.currentCenterOffset = self.centerRadius + self.currentBubbleRadius
        }
        else if minOutsideRadius >= self.centerRadius + self.maxBubbleRadius * 2 {
            // Allowed radius is bigger than the biggest bubble possible
            self.currentBubbleRadius = self.maxBubbleRadius
            self.currentCenterOffset = self.centerRadius + self.currentBubbleRadius
            self.optimizeBubbleSizeForNumberOfBubbles(self.currentBubbleRadius, bubblesCount: self.numberOfBubbles)
        }
        else if minOutsideRadius < self.centerRadius + self.currentBubbleRadius * 2 {
            // Allowed radius is smaller than current radius -> reduce bubbles size
            var currentRadius = self.currentBubbleRadius
            while minOutsideRadius < self.centerRadius + currentRadius * 2 {
                currentRadius = currentRadius - 1.0
            }
            
            self.currentBubbleRadius = currentRadius
            self.currentCenterOffset = self.centerRadius + self.currentBubbleRadius
            self.optimizeBubbleSizeForNumberOfBubbles(currentRadius, bubblesCount: self.numberOfBubbles)
        }
        else {
            // Allowed radius is bigger than current radius -> increase bubbles size
            var currentRadius = self.currentBubbleRadius
            while minOutsideRadius > self.centerRadius + currentRadius * 2 {
                currentRadius = currentRadius + 1.0
            }
            
            self.currentBubbleRadius = currentRadius
            self.currentCenterOffset = self.centerRadius + self.currentBubbleRadius
            self.optimizeBubbleSizeForNumberOfBubbles(currentRadius, bubblesCount: self.numberOfBubbles)
        }
    }
    
    func optimizeBubbleSizeForNumberOfBubbles(radiusAllowed: CGFloat, bubblesCount: Int) -> Void {
        let deviation = 360.0 / Double(bubblesCount) * M_PI / 180
        let cosDeviation : CGFloat = CGFloat(1 - cos(deviation))
        
        var currentRadius = radiusAllowed
        var distanceBetween2Centers = sqrt(2 * self.currentCenterOffset * self.currentCenterOffset * cosDeviation)
        var actualCenterRange = radiusAllowed * 2 + self.bubbleOffset
        while distanceBetween2Centers < actualCenterRange {
            if currentRadius < self.minBubbleRadius {
                currentRadius = self.minBubbleRadius
                break;
            }
            
            currentRadius = currentRadius - 1.0
            distanceBetween2Centers = sqrt(2 * (self.centerRadius + currentRadius) * (self.centerRadius + currentRadius) * cosDeviation)
            actualCenterRange = currentRadius * 2 + self.bubbleOffset
        }
        
        if (currentRadius != radiusAllowed) {
            self.currentBubbleRadius = currentRadius
            self.currentCenterOffset = self.centerRadius + self.currentBubbleRadius
        }
    }
    
    func loadBubbles(count: Double) -> Void {
        self.calculateMaxSize()
        self.clearBubbles()
        self.expand = false
        
        let bubblesCount = Int(count)
        let bubbleCenterFrame = CGRectMake(self.centerCoordinate.x - self.currentBubbleRadius,
                                           self.centerCoordinate.y - self.currentBubbleRadius,
                                           self.currentBubbleRadius * 2,
                                           self.currentBubbleRadius * 2)
            
            
            
        
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
        
        UIView.animateWithDuration(animationDuration,
                                   animations:
            {
                for index : Int in 0...self.bubbles.count - 1 {
                    let bubble = self.bubbles[index]
                    let currentDeviationAngle : CGFloat = CGFloat(index) * deviataionAngle
                    let dx : CGFloat = self.currentCenterOffset * cos(startAngle + currentDeviationAngle * CGFloat(M_PI/180))
                    let dy : CGFloat = self.currentCenterOffset * sin(startAngle + currentDeviationAngle * CGFloat(M_PI/180))
                    
                    bubble.center = CGPointMake(centerPoint.x + dx,
                        centerPoint.y + dy)
                }
                
                self.btnBubbles.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)
            },
                                   completion:
            {
                complete in
                self.btnBubbles.setTitle("X", forState: UIControlState.Normal)
        })
    }
    
    func hideBubbles() -> Void {
        let centerPoint = self.btnBubbles.center
        
        UIView.animateWithDuration(animationDuration,
                                   animations:
            {
                for index : Int in 0...self.bubbles.count - 1 {
                    let bubble = self.bubbles[index]
                    bubble.center = CGPointMake(centerPoint.x,
                        centerPoint.y)
                }
                
                self.btnBubbles.transform = CGAffineTransformIdentity
            },
                                   completion:
            {
                complete in
                self.btnBubbles.setTitle("BUBBLES", forState: UIControlState.Normal)
        })
    }
    
    func getRandomNumber() -> UInt {
        return UInt(arc4random_uniform(120) + 3)
    }
    
    func getRandomGroup() -> String {
        let array = ["LEAVE", "ITSM", "YAMMER", "DocuSign", "Calendar", "Mobile Expenses"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        return array[randomIndex]
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.clearBubbles()
    }
    
    func orientationChanged (notification: NSNotification) {
        self.loadBubbles(self.stepper.value)
    }
}

