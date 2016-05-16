//
//  CollectionViewController.swift
//  CollectionViewExample
//
//  Created by Radi on 4/14/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "apartmentCell"
private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)

class CollectionViewController: UICollectionViewController {

    let images = ["apartment1", "apartment2", "apartment3", "apartment4", "apartment5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count * 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> CollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        let row = indexPath.row
        cell.ivPreview.image = UIImage(named: self.images[row%5])
        cell.lblName.text = "Apartment \(row + 1)"
        
        // Configure the cell
    
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let rowWidth = self.collectionView?.bounds.width
        
        
        let orientation = UIDevice.currentDevice().orientation
        if orientation.isLandscape {
            return CGSize(width: rowWidth!/2 - sectionInsets.left * 2, height: rowWidth!/4)
        }
        else {
            return CGSize(width: rowWidth! - sectionInsets.left * 2, height: rowWidth!/2)
        }
        
//        if var size = flickrPhoto.thumbnail?.size {
//            size.width += 10
//            size.height += 10
//            return size
//        }
        
    }
    
    //3
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

// MARK: Orientation change delegate
extension CollectionViewController {

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}

// MARK: UICollectionViewDelegate
extension CollectionViewController {

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
