//
//  ViewController.swift
//  FactsSimpleApp
//
//  Created by Radi on 4/22/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var factLabel: UILabel!
    
    let factBook = FactBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNewFact(sender: AnyObject) {
        view.backgroundColor = getRandomColor()
        self.factLabel.text = factBook.getRandomFact();
    }
    
    func getRandomColor() -> UIColor {
        let red = Double(arc4random_uniform(255))/255.0
        let green = Double(arc4random_uniform(255))/255.0
        let blue = Double(arc4random_uniform(255))/255.0
        
        NSLog("\(CGFloat(red)) \(CGFloat(green)) \(CGFloat(blue))")
        
        return UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1.0)
    }
}

