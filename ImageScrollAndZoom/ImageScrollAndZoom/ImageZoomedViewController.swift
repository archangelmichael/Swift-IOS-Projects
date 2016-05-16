//
//  ImageZoomedViewController.swift
//  ImageScrollAndZoom
//
//  Created by Radi on 5/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ImageZoomedViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var downloadedImage : UIImage = UIImage()
    
    override func viewDidLoad() {
        self.imageView.hidden = true
        self.scrollView.delegate = self
        self.imageView.image = self.downloadedImage
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollViewDidZoom(self.scrollView)
        self.imageView.hidden = false
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / self.imageView.bounds.width
        let heightScale = size.height / self.imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        self.scrollView.minimumZoomScale = minScale
        self.scrollView.zoomScale = minScale
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateMinZoomScaleForSize(view.bounds.size)
    }
    
    private func updateConstraintsForSize(size: CGSize) {
        let yOffset = max(0, (size.height - self.imageView.frame.height) / 2)
        self.imageViewTopConstraint.constant = yOffset
        self.imageViewBottomConstraint.constant = yOffset
        let xOffset = max(0, (size.width - self.imageView.frame.width) / 2)
        self.imageViewLeadingConstraint.constant = xOffset
        self.imageViewTrailingConstraint.constant = xOffset
        view.layoutIfNeeded()
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ImageZoomedViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        self.updateConstraintsForSize(view.bounds.size)
    }
}

// MARK: Orientation change delegate
extension ImageZoomedViewController {
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.updateConstraintsForSize(size)
        }
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.updateConstraintsForSize(view.bounds.size)
        }
    }
}

