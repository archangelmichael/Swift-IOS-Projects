//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Radi on 10/14/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav") {
            self.buttonBeep = buttonBeep
        }
        if let secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav") {
            self.secondBeep = secondBeep
        }
        if let backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3") {
            self.backgroundMusic = backgroundMusic
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPlaySound(sender: AnyObject) {
        buttonBeep?.play()
        secondBeep?.play()
        
        backgroundMusic?.volume = 0.3
        backgroundMusic?.play()
    }

    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
    
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("no player available")
        }
        
        return audioPlayer
    }
}

