//
//  SecondViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fadeOut()
    }

    
    @IBAction func onNextQuote(sender: AnyObject) {
        self.getQuote()
    }
    
    func getQuote() {
        self.fadeOut()
        
        DataService().getQuoteData { (quote, author) in
            UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { 
                self.fadeIn()
                self.view.backgroundColor = self.randomColor()
                self.lblQuote.text = quote
                self.lblAuthor.text = author
                }, completion: { (finished) in
                    
            })
        }
    }

    
    func fadeIn() {
        self.lblQuote.alpha = 1.0
        self.lblAuthor.alpha = 1.0
    }
    
    func fadeOut() {
        self.lblQuote.text = ""
        self.lblAuthor.text = ""
        self.lblQuote.alpha = 0.0
        self.lblAuthor.alpha = 0.0
    }
    
    func randomColorFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func randomColor() -> UIColor {
        let r = self.randomColorFloat()
        let g = self.randomColorFloat()
        let b = self.randomColorFloat()
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

