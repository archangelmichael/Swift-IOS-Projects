//
//  ThirdViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var cstrBtnBot: NSLayoutConstraint!
    @IBOutlet weak var cstrLblTop: NSLayoutConstraint!
    let defaultTopCstr : CGFloat = 40.0
    
    
    let messages = ["Music for everyone",
                    "millions of songs on Spotify. Play your favorites, discover new tracks, and build the perfect collection", "Find readymade playlists to match your mood, put together by music fans and experts",
                    " Hear this week’s latest singles and albums, and check out what’s hot in the Top 50"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cstrLblTop.constant = defaultTopCstr
        
        //make the navigation bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        //make the back button and other bar button items white
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.cstrLblTop.constant = defaultTopCstr
        self.ivBackground.alpha = 0.0
        self.btnContinue.alpha = 0.0
        self.cstrBtnBot.constant = -self.view.bounds.height
        self.lblMessage.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1,
                                   delay: 0.0,
                                   options: [],
                                   animations: {
                                    self.ivBackground.alpha = 1.0
            },
                                   completion:nil)
        
        self.cstrBtnBot.constant = 20
        UIView.animateWithDuration(2.0,
                                   delay: 0.5,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    self.btnContinue.alpha = 1.0
                                    self.view.layoutIfNeeded()
            },
                                   completion:{ _ in
                self.marketingMessages(0)
        })
        
    }
    
    func marketingMessages(index: Int) {
        var newIndex = index
        if newIndex == self.messages.count - 1 {
            newIndex = 0
        }
        
        let message = self.messages[index]
        self.lblMessage.text = message
        self.cstrLblTop.constant = defaultTopCstr * CGFloat(newIndex + 1)
        self.view.layoutIfNeeded()
        
        UIView.animateKeyframesWithDuration(10.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.10, animations: {
                self.lblMessage.alpha = 0.5

            })
            
            self.cstrLblTop.constant = self.defaultTopCstr * CGFloat(newIndex)
            UIView.addKeyframeWithRelativeStartTime(0.10, relativeDuration: 0.05, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.cstrLblTop.constant = self.cstrLblTop.constant - self.defaultTopCstr
            UIView.addKeyframeWithRelativeStartTime(0.90, relativeDuration: 0.05, animations: {
                self.lblMessage.alpha = 0.0
                self.view.layoutIfNeeded()
            })
            
            }, completion: { _ in
                self.marketingMessages(newIndex + 1)
        })
        
    }
}
