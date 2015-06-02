//
//  TicketCheckViewController.swift
//  TotoCheck
//
//  Created by Radi on 6/2/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class TicketCheckViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var drawTitle = ""
    var drawnNumbersCount = 0;
    var totalNumbersCount = 0;
    var draws = [NSArray]()
    var errorMessage : String = ""
    
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawLabel.text = drawTitle
        
        // Set collection view options
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: ADD ITEM TO ARRAY OF NUMBERS
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: REMOVE ITEM FROM ARRAY OF NUMBERS
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalNumbersCount
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NUMBER_CELL_REUSE_ID,
            forIndexPath: indexPath) as! UICollectionViewCell
            
        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    
    @IBAction func onCheckTicket(sender: AnyObject) {
        
    }
    
    @IBAction func onGoBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}