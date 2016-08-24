//
//  ViewController.swift
//  Proj1-HitList
//
//  Created by Radi on 8/24/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var people = [NSManagedObject]()
    
    private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let cellReuseID = "ListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The List"
        self.tableView.registerClass(UITableViewCell.self,
                                     forCellReuseIdentifier: self.cellReuseID)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let managedContext = self.appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Person")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            self.people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler:
            { (action:UIAlertAction) -> Void in
                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
                self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default)
        { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler
            { (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
    
    func saveName(name: String) {
        let managedContext = self.appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Person",
                                                       inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        person.setValue(name, forKey: "name")
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellReuseID)
        let person = people[indexPath.row]
        cell!.textLabel!.text = person.valueForKey("name") as? String
        return cell!
    }
}

