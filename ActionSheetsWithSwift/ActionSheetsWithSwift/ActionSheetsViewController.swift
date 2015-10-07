//
//  ActionSheetsViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class ActionSheetsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = UIDevice.currentDevice().name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSimpleActionSheet(sender: AnyObject) {
        self.showActionSheet(sender as! UIView, isSimple: true)
    }
    
    @IBAction func onComplexActionSheet(sender: AnyObject) {
        self.showActionSheet(sender as! UIView, isSimple: false)
    }
    
    func showActionSheet(sender:UIView, isSimple: Bool) {
        let actionTitle = isSimple ? "Simple Action Sheet" : "Complex Action Sheet"
        let actionMessage = isSimple ? "No choice available" : "Select action"
        
        let alertController = UIAlertController(title: actionTitle, message: actionMessage, preferredStyle: .ActionSheet)
        alertController.popoverPresentationController?.sourceView = sender
        alertController.popoverPresentationController?.sourceRect = CGRectMake(
            sender.bounds.size.width / 2.0,
            sender.bounds.size.height,
            1.0, 1.0);
        alertController.popoverPresentationController?.permittedArrowDirections = .Up
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
