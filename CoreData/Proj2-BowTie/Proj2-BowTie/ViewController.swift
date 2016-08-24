//
//  ViewController.swift
//  Proj2-BowTie
//
//  Created by Radi on 8/24/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var managedContext: NSManagedObjectContext!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var currentBowtie: Bowtie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.managedContext = self.appDelegate.managedObjectContext
        
        self.insertSampleData()
        let request = NSFetchRequest(entityName:"Bowtie")
        let firstTitle = self.segmentedControl.titleForSegmentAtIndex(0)
        request.predicate = NSPredicate(format:"searchKey == %@", firstTitle!)
        
        do {
            let results = try self.managedContext.executeFetchRequest(request) as! [Bowtie]
            self.currentBowtie = results.first
            self.populate(self.currentBowtie)
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func populate(bowtie: Bowtie) {
        self.imageView.image = UIImage(data:bowtie.photoData!)
        self.nameLabel.text = bowtie.name
        self.ratingLabel.text = "\(bowtie.rating!.doubleValue)/5"
        self.timesWornLabel.text = "\(bowtie.timesWorn!.integerValue)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        self.lastWornLabel.text = "\(dateFormatter.stringFromDate(bowtie.lastWorn!))"
        self.favoriteLabel.hidden = !bowtie.isFavorite!.boolValue
        self.view.tintColor = bowtie.tintColor as! UIColor
    }
    
    @IBAction func segmentedControl(control: UISegmentedControl) {
        let selectedValue =
            control.titleForSegmentAtIndex(control.selectedSegmentIndex)
        let request = NSFetchRequest(entityName:"Bowtie")
        request.predicate =
            NSPredicate(format:"searchKey == %@", selectedValue!)
        do {
            let results = try self.managedContext.executeFetchRequest(request) as! [Bowtie]
            self.currentBowtie = results.first
            self.populate(self.currentBowtie)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func wear(sender: AnyObject) {
        let times = self.currentBowtie.timesWorn!.integerValue
        self.currentBowtie.timesWorn = NSNumber(integer: (times + 1))
        self.currentBowtie.lastWorn = NSDate()
        do {
            try self.managedContext.save()
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        self.populate(self.currentBowtie)
    }
    
    @IBAction func rate(sender: AnyObject) {
        let alert = UIAlertController(title: "New Rating",
                                      message: "Rate this bow tie",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default,
                                         handler:
            { (action: UIAlertAction!) in
        })
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler:
            { (action: UIAlertAction!) in
                let textField = alert.textFields![0] as UITextField
                self.updateRating(textField.text!)
        })
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) in
            textField.keyboardType = .DecimalPad
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
    
    func updateRating(numericString: String) {
        self.currentBowtie.rating = (numericString as NSString).doubleValue
        do {
            try self.managedContext.save()
            self.populate(self.currentBowtie)
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            if error.domain == NSCocoaErrorDomain &&
                (error.code == NSValidationNumberTooLargeError ||
                    error.code == NSValidationNumberTooSmallError) {
                self.rate(self.currentBowtie)
            }
        }
    }
    
    //Insert sample data
    func insertSampleData() {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
        let count = self.managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0 {
            return
        }
        
        let path = NSBundle.mainBundle().pathForResource("TiesData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict : AnyObject in dataArray {
            let entity = NSEntityDescription.entityForName("Bowtie",
                                                           inManagedObjectContext: managedContext)
            let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
            let btDict = dict as! NSDictionary
            bowtie.name = btDict["name"] as? String
            bowtie.searchKey = btDict["searchKey"] as? String
            bowtie.rating = btDict["rating"] as? NSNumber
            let hexTintColor = btDict["textColor"] as? String
            bowtie.tintColor = self.hexStringToUIColor(hexTintColor!)
            let imageName = btDict["imageName"] as? String
            let image = UIImage(named:imageName!)
            let photoData = UIImagePNGRepresentation(image!)
            bowtie.photoData = photoData
            bowtie.lastWorn = btDict["lastWorn"] as? NSDate
            bowtie.timesWorn = btDict["timesWorn"] as? NSNumber
            bowtie.isFavorite = btDict["isFavorite"] as? NSNumber
        }
        
//        do {
//            try self.managedContext.save()
//        } catch let error as NSError {
//            print("Saving error: \(error.localizedDescription)")
//        }
    }
    
    // Get color from hex string
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

