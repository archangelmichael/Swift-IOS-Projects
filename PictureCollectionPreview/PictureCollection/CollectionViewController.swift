//
//  CollectionViewController.swift
//  PictureCollection
//
//  Created by Sandy L on 2016-03-09.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let transition = Animator()
    var selectedImage: UIImageView?
    var category = Category?()
    var photos = [String]()
    var morePhotos = [String]()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.title = (category!.name).capitalizedString
        
        //loadMorePhotos()
        
        loadMorePhotos()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
 
        //selected image visible after presenting controller is dismissed
        transition.dismissCompletion = {
            self.selectedImage!.hidden = false
        }
    }

    func loadMorePhotos() {
    
        for _ in 0..<10 {
            
            for photo in photos {
                morePhotos.append(photo)
            }
     
        }
    }
    
    //MARK: Actions
    func didTapCell(sender: UITapGestureRecognizer) {
            
            selectedImage = sender.view as? UIImageView
            
            //present details view controller
            let photoDetails = storyboard!.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
            
            photoDetails.photo = selectedImage!.image
            photoDetails.transitioningDelegate = self
            presentViewController(photoDetails, animated: true, completion: nil)
    }
    
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({context in
            
            }, completion: nil)
    }
    
    
    //CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return morePhotos.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        let photo =  morePhotos[indexPath.row]
        
        cell.picture.image = UIImage(named: "\(photo).jpg")
        cell.picture.addGestureRecognizer(UITapGestureRecognizer(target:self, action: Selector("didTapCell:")))
      
        return cell
        
    }
}

//extension with UIViewControllerTransitioningDelegate protocole
extension CollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
    
        transition.presenting = true
        selectedImage!.hidden = true
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}







    