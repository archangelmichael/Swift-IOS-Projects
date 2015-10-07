//
//  RootViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

enum ActionType : Int {
    case Alert = 0
    case ActionsCount
    static let allActions = [Alert]
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
    
    @IBAction func showAlert() {
        
    }
    
    @IBAction func showNothing() {
        
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let action = ActionType.allActions[indexPath.row];
        switch action {
            case .Alert: self.showAlert()
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
