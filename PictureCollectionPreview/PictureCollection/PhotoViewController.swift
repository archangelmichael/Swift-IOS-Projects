//
//  PhotoViewController.swift
//  PictureCollection
//
//  Created by Sandy L on 2016-03-15.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var photo:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoView.image = photo
        
        //addGestureRecognizer
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissPresentingController:")))
      
    }
    
    func dismissPresentingController(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
