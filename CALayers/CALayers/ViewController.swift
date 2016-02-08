//
//  ViewController.swift
//  CALayers
//
//  Created by Radi on 1/28/16.
//  Copyright © 2016 oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.layer.backgroundColor = UIColor.orangeColor().CGColor
        self.mainView.layer.cornerRadius = 20.0;
        self.mainView.layer.frame = CGRectInset(self.mainView.layer.frame, 20, 20);
        
        let sublayer = CALayer()
        sublayer.backgroundColor = UIColor.blueColor().CGColor
        sublayer.shadowOffset = CGSizeMake(0, 3)
        sublayer.shadowRadius = 5.0
        sublayer.shadowColor = UIColor.blackColor().CGColor
        sublayer.shadowOpacity = 0.8
        sublayer.frame = CGRectMake(30, 30, 128, 192)
        sublayer.borderColor = UIColor.blackColor().CGColor;
        sublayer.borderWidth = 2.0;
        sublayer.cornerRadius = 10.0;
        self.mainView.layer.addSublayer(sublayer)
        
        let imageLayer = CALayer()
        imageLayer.frame = sublayer.bounds;
        imageLayer.cornerRadius = 10.0;

        imageLayer.contents = UIImage(named: "BattleMapSplashScreen.jpg")!.CGImage;
        imageLayer.borderColor = UIColor.blackColor().CGColor;
        imageLayer.borderWidth = 2.0;
        imageLayer.masksToBounds = true;
        sublayer.addSublayer(imageLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

