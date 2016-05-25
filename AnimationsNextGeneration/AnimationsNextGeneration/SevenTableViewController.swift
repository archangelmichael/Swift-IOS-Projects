//
//  SevenTableViewController.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/25/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class SevenTableViewController: UITableViewController {

    let images = ["rainy", "sunny", "stormy", "cloudy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 * images.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)

        let row = indexPath.row % images.count
        let imageName = self.images[row]
        
        if let iv = cell.viewWithTag(1) as? UIImageView {
            iv.image = UIImage(named:imageName)
        }
        
        if let lbl = cell.viewWithTag(2) as? UILabel {
            lbl.text = imageName.uppercaseString
        }
        

        return cell
    }
    
    @IBAction func onRefresh(sender: AnyObject) {
        self.animateTable()
    }
    
    //animates tableView rows
    func animateTable() {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a
            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
}
