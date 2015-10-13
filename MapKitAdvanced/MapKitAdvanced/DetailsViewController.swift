//
//  DetailsViewController.swift
//  MapKitAdvanced
//
//  Created by Radi on 10/13/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var mapItemData:MKMapItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view delegate and data source methods
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cellIdentifier")
            
            if cell == nil{
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cellIdentifier")
                if indexPath.row == 0{
                    cell.textLabel?.text = mapItemData.name
                }
                if indexPath.row == 1{
                    cell.textLabel?.text = mapItemData.placemark.country
                    cell.detailTextLabel?.text = mapItemData.placemark.countryCode
                }
                if indexPath.row == 2{
                    cell.textLabel?.text = mapItemData.placemark.postalCode
                }
                if indexPath.row == 3{
                    cell.textLabel?.text = "Phone number"
                    cell.detailTextLabel?.text = mapItemData.phoneNumber
                }
            }
            return cell
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return 4
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
