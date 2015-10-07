//
//  RootViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

enum ActionType : Int {
    case SimpleAlert = 0
    case ComplexAlert
    case SimpleActionSheet
    case ComplexActionSheet
    case ActionsCount
    static let allActions = [SimpleAlert, ComplexAlert, SimpleActionSheet, ComplexActionSheet]
}

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var selectedCell : UITableViewCell!
    @IBOutlet weak var actionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionsTableView.dataSource = self;
        self.actionsTableView.delegate = self;
        self.navigationItem.title = UIDevice.currentDevice().name
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(isSimple: Bool) {
        let actionTitle = isSimple ? "Simple Alert" : "Complex Alert"
        let actionMessage = isSimple ? "No choice available" : "Select action"
        let alertController = UIAlertController(title: actionTitle, message: actionMessage, preferredStyle: .Alert)
        self.addActionsTo(alertController, isSimple: isSimple)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showActionSheet(isSimple: Bool) {
        let actionTitle = isSimple ? "Simple Action Sheet" : "Complex Action Sheet"
        let actionMessage = isSimple ? "No choice available" : "Select action"
        
        let alertController = UIAlertController(title: actionTitle, message: actionMessage, preferredStyle: .ActionSheet)
        let anchorView : UIView = selectedCell != nil ? selectedCell : self.view
        alertController.popoverPresentationController?.sourceView = anchorView
        alertController.popoverPresentationController?.sourceRect = CGRectMake(
            anchorView.bounds.size.width / 2.0,
            anchorView.bounds.size.height,
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
    
    @IBAction func showNothing() {
        
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let action = ActionType.allActions[indexPath.row];
        switch action {
            case .SimpleAlert: self.showAlert(true)
            case .ComplexAlert: self.showAlert(false)
            case .SimpleActionSheet: self.showActionSheet(true)
            case .ComplexActionSheet: self.showActionSheet(false)
            default : self.showNothing()
        }
    }
    
    // MARK: - UITableViewDataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActionType.ActionsCount.rawValue;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let action = ActionType.allActions[indexPath.row];
        let actionName = "\(action)"
        
        let cellId = "CustomCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style:.Default, reuseIdentifier: cellId)
        }
        
        cell!.textLabel?.text = actionName
        return cell
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
