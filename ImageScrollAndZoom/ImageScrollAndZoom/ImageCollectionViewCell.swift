//
//  ImageCollectionViewCell.swift
//  ImageScrollAndZoom
//
//  Created by Radi on 5/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    class func nibName() -> String {
        return "ImageCollectionViewCell"
    }
    
    class func reuseId() -> String {
        return "imageViewCell"
    }
}
