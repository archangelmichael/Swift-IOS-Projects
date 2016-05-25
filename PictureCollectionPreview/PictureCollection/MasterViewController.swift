//
//  MasterViewController.swift
//  PictureCollection
//
//  Created by Sandy L on 2016-03-09.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"


class MasterViewController: UICollectionViewController {
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let array = ["fashion", "food", "nature", "holidays", "people", "technology"]
        
        //loadCategories()
        loadCategories(array, completion: {
            
            self.loadPhotos()
        })
      
    
    }
    
    func loadCategories(Allcategories: NSArray, completion: () -> ()) {
        
        for category in Allcategories {
            let newCategory = Category(name: category as! String, photos: [])
            self.categories.append(newCategory)
        }
        
        completion()
    }
    
    func loadPhotos() {
        
        for category in self.categories {
            
            var counter:Int = 0
            
            for _ in 0..<10 {
                
                let photo = "\(category.name)\(counter)"
                category.photos.append(photo)
                
                counter++
                
            }
        }
    }
    
    func randomNumber(num: Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryViewCell
        
        let category  = categories[indexPath.row]
        let index = randomNumber(10)
        
        cell.categoryLabel.text = (category.name).capitalizedString
        let cover = category.photos[index]
        cell.image.image = UIImage(named: "\(cover).jpg")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.bounds.size.width, 180);
        
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
        
        if let indexPath = self.collectionView?.indexPathForCell(sender as! CategoryViewCell) {
           
            if segue.identifier == "goToCollection" {
                
                let categorySelected = categories[indexPath.row] as Category
                let photos = categorySelected.photos
                
                
                let destVC = segue.destinationViewController as! CollectionViewController
                
                destVC.category = categorySelected
                destVC.photos = photos
                     
                
            }
        }
    }
    
    
}
