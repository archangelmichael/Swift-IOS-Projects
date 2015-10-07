//
//  PopoversViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class PopoversViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var mainStoryboardName : String = "Main"
    var presentAsPopover : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = UIDevice.currentDevice().name
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Pad: mainStoryboardName = "Main~iPad"
                break
            default: mainStoryboardName = "Main"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onShowPopover(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: mainStoryboardName, bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PopoverVCId")
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.barButtonItem = sender as? UIBarButtonItem
        popover.delegate = self
        presentViewController(vc, animated: true, completion:nil)
    }
    
    // Called only on iPhones
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        presentAsPopover = !presentAsPopover
        if presentAsPopover {
            return UIModalPresentationStyle.None
        }
        else {
            return UIModalPresentationStyle.FullScreen
        }
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
