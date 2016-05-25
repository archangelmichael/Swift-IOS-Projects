//
//  FourthViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import AVFoundation

class FourthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var cstrBtnPlayWidth: NSLayoutConstraint!
    
    let fruitArray = ["🍓","🍎","🍏","🍒","🍊","🍉","🍑","🍍","🍌","🍇"]
    var component1 = [Int]()
    var component2 = [Int]()
    var component3 = [Int]()
    
    
    func randomNumber(num: Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< 100 {
            self.component1.append(self.randomNumber(10))
            self.component2.append(self.randomNumber(10))
            self.component3.append(self.randomNumber(10))
        }
        
        self.resultLabel.text = ""
        
        self.pickerView.userInteractionEnabled = false
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    
    //Win Sound
    func win() {
        print("win")
        if let soundURL = NSBundle.mainBundle().URLForResource("winSoundEffect",
                                                               withExtension: "mp3") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
    
    
    @IBAction func didPressPlay(sender: UIButton) {
        //display random emoji
        pickerView.selectRow((randomNumber(10)), inComponent: 0, animated: true)
        pickerView.selectRow((randomNumber(10)), inComponent: 1, animated: true)
        pickerView.selectRow((randomNumber(10)), inComponent: 2, animated: true)
        
        if(component1[pickerView.selectedRowInComponent(0)] == component2[pickerView.selectedRowInComponent(1)] &&
            component2[pickerView.selectedRowInComponent(1)] == component3[pickerView.selectedRowInComponent(2)]) {
            
            //win
            resultLabel.text = "WIN!"
            win()
        }
        else {
            //play again
            resultLabel.text = "Play Again"
        }
        
        let defaultBtnWidth =  self.cstrBtnPlayWidth.constant
        //animate
        self.cstrBtnPlayWidth.constant = defaultBtnWidth + 20
        UIView.animateWithDuration(0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 1,
                                   options: .CurveEaseOut,
                                   animations: {
                                    self.view.layoutIfNeeded()
            },
                                   completion: { finished in
                                    self.cstrBtnPlayWidth.constant = defaultBtnWidth
                                    UIView.animateWithDuration(0.3,
                                        delay: 0.0,
                                        options: .CurveEaseOut,
                                        animations: {
                                            self.view.layoutIfNeeded()
                                        },
                                        completion: nil)
        })
    }
    
    //UIPickerView DataSource
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //number of rows
        return 10
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        //number of components
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusingView view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        switch component {
        case 0:
            pickerLabel.text = fruitArray[component1[row]]
            break
        case 1:
            pickerLabel.text = fruitArray[component2[row]]
            break
        case 2:
            pickerLabel.text = fruitArray[component3[row]]
            break
        default:
            pickerLabel.text = fruitArray[component1[row]]
        }
        
        //display random emoji - switch case
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 30)
        pickerLabel.textAlignment = NSTextAlignment.Center
        
        return pickerLabel
        
    }
}
