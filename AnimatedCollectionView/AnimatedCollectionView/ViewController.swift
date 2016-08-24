//
//  ViewController.swift
//  AnimatedCollectionView
//
//  Created by Radi on 8/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vCollection: ADLivelyCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vCollection.delegate = self
        self.vCollection.dataSource = self
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformCurl)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformFade)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformFan)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformFlip)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformHelix)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformTilt)
//        self.vCollection.setInitialCellTransformBlock(ADLivelyTransformWave)
         self.vCollection.setInitialCellTransformBlock(ADLivelyTransformGrow)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DefaultCell",
                                                                         forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 200)
        
        
        let rowWidth : CGFloat = collectionView.bounds.width
        let insets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        let rowHeightLandscape : CGFloat = collectionView.bounds.height / 3 - insets.top * 2
        let rowHeightPortrait : CGFloat = collectionView.bounds.height / 4 - insets.top * 2
        
        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
            return CGSize(width: rowWidth/2 - insets.left * 4, height: rowHeightLandscape)
        }
        else {
            return CGSize(width: rowWidth - insets.left * 2, height: rowHeightPortrait)
        }
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
}

