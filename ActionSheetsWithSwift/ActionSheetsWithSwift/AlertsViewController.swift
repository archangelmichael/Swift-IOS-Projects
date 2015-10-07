//
//  AlertsViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = UIDevice.currentDevice().name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSimpleAlert(sender: AnyObject) {
        self.showAlert(true)
    }
    
    @IBAction func onComplexAlert(sender: AnyObject) {
        self.showAlert(false)
    }
    
    func showAlert(isSimple: Bool) {
        let actionTitle = isSimple ? "Simple Alert" : "Complex Alert"
        let actionMessage = isSimple ? "No choice available" : "Select action"
        let alertController = UIAlertController(title: actionTitle, message: actionMessage, preferredStyle: .Alert)
        self.addActionsTo(alertController, isSimple: isSimple)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func addActionsTo(alertController: UIAlertController, isSimple: Bool) {
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let actionName = action.title
            let alertMessage = UIAlertController(
                title: "Unavailable \(actionName)",
                message: "Sorry",
                preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: callActionHandler)
        alertController.addAction(okAction)
        if !isSimple {
            let closeAction = UIAlertAction(title: "CLOSE", style: .Destructive, handler: callActionHandler)
            alertController.addAction(closeAction)
            let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel, handler: callActionHandler)
            alertController.addAction(cancelAction)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
