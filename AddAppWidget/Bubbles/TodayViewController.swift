//
//  TodayViewController.swift
//  Bubbles
//
//  Created by Radi on 8/10/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblCounter: UILabel!
    
    @IBOutlet weak var cstrLblCounter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSeconds()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(userDefaultsDidChange(_:)),
                                                         name: NSUserDefaultsDidChangeNotification,
                                                         object: nil)
        // Do any additional setup after loading the view from its nib.
    }
    
    func userDefaultsDidChange(note: NSNotification) -> Void {
        print("USER DEFAULTS CHANGED")
        self.loadSeconds()
    }
    
    func loadSeconds() -> Void {
        let defaults = NSUserDefaults(suiteName: "group.com.oryx.testapp")
        if let seconds : Int = defaults?.integerForKey("seconds") {
            self.lblCounter.text = String(seconds)
//            self.cstrLblCounter.constant = CGFloat(seconds * 10)
//            self.view.layoutIfNeeded()
            
            self.preferredContentSize = CGSizeMake(self.view.frame.width, 200 + CGFloat(seconds) * 10)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        var margins = defaultMarginInsets
        margins.top = 10.0
        margins.bottom = 10.0
        return margins
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
