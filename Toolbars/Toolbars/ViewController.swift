//
//  ViewController.swift
//  Toolbars
//
//  Created by Radi on 2/3/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bar: UIToolbar!
    var currentLayer : CALayer?
    var layers : [CALayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layers = []
        layers!.append(getSublayerWithImage("logo.png"))
        layers!.append(getSublayerWithImage("speed-cam.png"))
        layers!.append(getSublayerWithImage("traffic-cam.png"))
        currentLayer = layers![0]
        bar.layer.addSublayer(currentLayer!)
    }
    
    
    @IBAction func onPlus(sender: AnyObject) {
        currentLayer!.removeFromSuperlayer()
        currentLayer = layers![1]
        bar.layer.addSublayer(currentLayer!)
    }
    
    @IBAction func onEqual(sender: AnyObject) {
        currentLayer!.removeFromSuperlayer()
        currentLayer = layers![2]
        bar.layer.addSublayer(currentLayer!)
    }
    
    @IBAction func onPlus2(sender: AnyObject) {
        currentLayer!.removeFromSuperlayer()
        currentLayer = layers![0]
        bar.layer.addSublayer(currentLayer!)
    }
    
    func getSublayerWithImage(name:String) -> CALayer {
        if let logo = UIImage(named: name) {
            let imageLayer = CALayer()
            imageLayer.frame = CGRectMake(10, 5, 100, bar.frame.size.height-10)
            imageLayer.cornerRadius = 10.0
            
            imageLayer.contents = logo.CGImage;
            imageLayer.borderColor = UIColor.clearColor().CGColor;
            imageLayer.borderWidth = 2.0;
            imageLayer.masksToBounds = true;
            return imageLayer
        }
        else {
            return CALayer()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

