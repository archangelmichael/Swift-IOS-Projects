//
//  ViewController.swift
//  AddAppWidget
//
//  Created by Radi on 8/10/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCounter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSTimer.scheduledTimerWithTimeInterval(2.0,
                                               target: self,
                                               selector: #selector(saveTime),
                                               userInfo: nil,
                                               repeats: true)
        NSNotificationCenter.defaultCenter().postNotificationName(NSUserDefaultsDidChangeNotification,
                                                                  object: self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func saveTime() -> Void {
        let defaults = NSUserDefaults(suiteName: "group.com.oryx.testapp")!
        let components = NSCalendar.currentCalendar().components([NSCalendarUnit.Second , NSCalendarUnit.Minute], fromDate: NSDate())
        let minutes = components.minute
        let seconds = components.second
        defaults.setInteger(seconds, forKey: "seconds")
        defaults.synchronize()
        self.lblCounter.text = String(seconds)
        
        NSNotificationCenter.defaultCenter().postNotificationName(NSUserDefaultsDidChangeNotification, object: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

