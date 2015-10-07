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
    
    @IBAction func showSimpleAlert() {
        let alertController = UIAlertController(title: "Simple Alert Message", message: "No choice!", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showComplexAlert() {
        let alertController = UIAlertController(title: "Complex Alert Message", message: "Select option", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        let closeAction = UIAlertAction(title: "CLOSE", style: .Destructive, handler: nil)
        alertController.addAction(closeAction)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showSimpleActionSheet() {
        let alertController = UIAlertController(title: "Simple Action Sheet", message: "No choice!", preferredStyle: .ActionSheet)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showComplexActionSheet() {
        let alertController = UIAlertController(title: "Complex Action Sheet", message: "Select option", preferredStyle: .ActionSheet)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        let closeAction = UIAlertAction(title: "CLOSE", style: .Destructive, handler: nil)
        alertController.addAction(closeAction)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showNothing() {
        
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let action = ActionType.allActions[indexPath.row];
        switch action {
            case .SimpleAlert: self.showSimpleAlert()
            case .ComplexAlert: self.showComplexAlert()
            case .SimpleActionSheet: self.showSimpleActionSheet()
            case .ComplexActionSheet: self.showComplexActionSheet()
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
