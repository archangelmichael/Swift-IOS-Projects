//
//  ImagesCollectionViewController.swift
//  ImageScrollAndZoom
//
//  Created by Radi on 5/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController {
    var imageUlrs : [String] = []
    private let placeholderImage : UIImage = UIImage(named: "download3")!
    private var downloadedImages : [UIImage] = []
    private var currentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGallery()
        
        self.downloadedImages = [UIImage](count: self.imageUlrs.count, repeatedValue: self.placeholderImage)
        for (index, url) in self.imageUlrs.enumerate() {
            self.setImageFromUrl(url, index: index)
        }
    }
    
    func setupGallery() {
        self.collectionView!.registerNib(UINib(nibName: ImageCollectionViewCell.nibName(), bundle: nil),
                                         forCellWithReuseIdentifier: ImageCollectionViewCell.reuseId())
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let insets = ImageCollectionViewCell.sectionInsets
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = insets.left * 2
        self.collectionView!.pagingEnabled = true
        self.collectionView!.collectionViewLayout = flowLayout
    }
    
    func setImageFromUrl(urlStr: String?, index: Int){
        if urlStr != nil {
            if let url = NSURL(string: urlStr!) {
                self.getDataFromUrl(url) { (data, response, error)  in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        guard let data = data,
                            let downloadedAvatar = UIImage(data: data)
                            where error == nil else {
                            print("Image download failed.")
                            return
                        }
                        
                        if index < self.downloadedImages.count {
                            self.downloadedImages[index] = downloadedAvatar
                            print("Download complete")
                            self.collectionView!.reloadData()
                            return;
                        }
                    }
                }
            }
        }
        
        print("Image download failed.")
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}

// MARK: UICollectionViewDataSource
extension ImagesCollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUlrs.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.reuseId(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.imagePreview.image = self.downloadedImages[indexPath.row]
        return cell
    }
}

// MARK:UICollectionViewDelegateFlowLayout
extension ImagesCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        if row < self.downloadedImages.count {
            let image = self.downloadedImages[row]
            let zoomImageVC = UIStoryboard(name: "ImageTabs", bundle: nil).instantiateViewControllerWithIdentifier("imageZoomedVC") as! ImageZoomedViewController
            zoomImageVC.downloadedImage = image
            self.presentViewController(zoomImageVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let insets = ImageCollectionViewCell.sectionInsets
        return CGSize(width: self.collectionView!.frame.size.width - insets.left * 2, height: self.collectionView!.frame.size.height - insets.top * 2)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return ImageCollectionViewCell.sectionInsets
    }
}

// MARK: Orientation change delegate
extension ImagesCollectionViewController {
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.collectionView!.alpha = 0
            self.collectionView!.collectionViewLayout.invalidateLayout()
            let currentOffset = self.collectionView!.contentOffset
            self.currentIndex = Int(currentOffset.x / self.collectionView!.frame.size.width)
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            let indexPath = NSIndexPath(forItem: self.currentIndex, inSection: 0)
            self.collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            UIView.animateWithDuration(0.125, animations: { 
                self.collectionView!.alpha = 1
            })
        }
    }
}