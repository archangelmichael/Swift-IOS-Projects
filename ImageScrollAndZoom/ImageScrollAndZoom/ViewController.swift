//
//  ViewController.swift
//  ImageScrollAndZoom
//
//  Created by Radi on 5/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let imageUlrs = ["http://www.cgarchitect.com/content/portfolioitems/2012/11/65206/AWing_Phase_002_003_large.jpg",
                             "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQ9TwZSsoC-ZWNmBxqQKh6J18YyjQ5i8ZJ68S8Mr674Sj0stHw6",
                             "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSDhqSXwwX0ZRYTi3A9caf7h_QjnRa8HBz7gzpt6wLZD7meCzCW",
                             "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSl3AngbzD1sMlJ7dOFeC-2-6oO-KHOqXHwAtSGAdt6NIwe1KoMgg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onShowGallery(sender: AnyObject) {
        let imagesVC = UIStoryboard(name: "ImageTabs", bundle: nil).instantiateViewControllerWithIdentifier("imageTabsVC") as!ImagesCollectionViewController
        imagesVC.imageUlrs = self.imageUlrs
        self.presentViewController(imagesVC, animated: true, completion: nil)
    }
}

