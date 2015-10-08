//
//  FormsViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class FormsViewController: UIViewController, UIActionSheetDelegate, UIPopoverPresentationControllerDelegate, UserFormViewControllerDelegate {

    var userDataPopover : UIPopoverController?
    var userFormVC : UserFormViewController = UserFormViewController(nibName: "UserFormViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSimpleForm(sender: AnyObject) {
        let alertController = UIAlertController(
            title: "Simple Form",
            message: "Fill Form",
            preferredStyle: .Alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .Default,
            handler: {
                (action:UIAlertAction!) -> Void in
                let usernameField = alertController.textFields?.first
                if let username = usernameField?.text {
                    print("\(username)")
                }
            }
        )
        
        okAction.enabled = false
        
        alertController.addAction(okAction)
        
        let closeAction = UIAlertAction(
            title: "CLOSE",
            style: .Destructive,
            handler: nil
        )
        
        alertController.addAction(closeAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Username"
            textField.addTarget(
                self,
                action: "alertTextFieldDidChange:",
                forControlEvents:UIControlEvents.EditingChanged)
        }
        
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alertTextFieldDidChange(sender : UITextField) {
        if let alertController : UIAlertController? = self.presentedViewController as? UIAlertController {
            let textFieldUsername : UITextField? = alertController?.textFields?.first
            let okAction = alertController?.actions.first
            let username : String? = textFieldUsername?.text
            okAction?.enabled = username?.characters.count > 2
        }
    }
    
    @IBAction func onFullForm(sender: AnyObject) {
        userFormVC = UserFormViewController(nibName: "UserFormViewController", bundle: nil)
        userFormVC.delegate = self
        switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                self.userDataPopover = UIPopoverController(contentViewController: userFormVC)
                self.userDataPopover!.popoverContentSize = CGSizeMake(320, 430)
                self.userDataPopover!.presentPopoverFromRect(
                    sender.frame,
                    inView: view,
                    permittedArrowDirections: .Up,
                    animated: true)
            break
            default:
                // TODO: Change for iPhone
                let sourceView = sender as? UIView
                userFormVC.modalPresentationStyle = .Popover;
                userFormVC.popoverPresentationController?.delegate = self;
                userFormVC.popoverPresentationController?.sourceView = sourceView
                self.presentViewController(userFormVC, animated: true, completion: nil)
        }
    }
    
    // MARK: -
    func userDataChangedWithUsername(username: String, age: String, gender: String) {
        print("Name : \(username) \n Age : \(age) \n Gender : \(gender)")
        switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad:
                self.userDataPopover!.dismissPopoverAnimated(true)
                break
            default:
                userFormVC.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
//    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
//        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
//        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
//        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
//        return navigationController
//    }
//    
//    func dismiss() {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
