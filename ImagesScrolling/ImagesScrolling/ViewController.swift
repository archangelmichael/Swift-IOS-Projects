//
//  ViewController.swift
//  ImagesScrolling
//
//  Created by Radi on 2/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController : PageViewController?
    var titles : Array<String> = []
    var images : Array<String> = []
    
    
    
    
    
    @IBOutlet weak var btnRestart: UIButton!
    
    @IBOutlet weak var ivMain: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action:"tapDetected:")
        singleTap.numberOfTapsRequired = 1
        ivMain.userInteractionEnabled = true
        ivMain.addGestureRecognizer(singleTap)
        
        titles = ["FIRST", "SECOND", "THIRD", "FOURTH", "FIFTH"]
        images = [
            "http://www.mooresvillerent.com/images/23/06/23064994_640x480.jpg",
            "http://imganuncios.mitula.net/over_809_sf_in_bermuda_dunes_4100129443130000304.jpg",
            "http://imganuncios.mitula.net/0_bedroom_rental_norfolk_va_5390114443040752979.jpg",
            "http://st.hzcdn.com/simgs/b181539c028d2e7a_4-2325/beach-style-living-room.jpg",
            "http://www.apartmentslancasterhanoi.com/images/products/lancaster-3-bedroom-apartment-for-rent-in-ba-dinh-district_2015817105531.JPG"
        ]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController
        self.pageViewController?.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0)
        let viewControllers : Array<UIViewController> = [startVC!]
        
        self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        // Change the size of page view controller
        self.pageViewController!.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40)
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMoveToParentViewController(self)
        
        self.view.bringSubviewToFront(btnRestart)
        
    }

    @IBAction func onRestart(sender: AnyObject) {
        let startVC   = self.viewControllerAtIndex(0)
        let vcs : Array<UIViewController> = [startVC!]
        self.pageViewController?.setViewControllers(vcs, direction:.Forward, animated: true, completion: nil)
    }
    
    func tapDetected(sender:UIImageView) {
        print("Single Tap on imageview")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index : Int = (viewController as! PageContentViewController).pageIndex!
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.titles.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index : Int = (viewController as! PageContentViewController).pageIndex!
        if index == 0 ||  index == NSNotFound {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> PageContentViewController? {
        if self.titles.count == 0 ||  index >= self.titles.count {
            return nil
        }
        
        let pageContentViewController : PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentController") as! PageContentViewController
            pageContentViewController.imageURL = self.images[index]
            pageContentViewController.titleText = self.titles[index]
            pageContentViewController.pageIndex = index
        return pageContentViewController
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.titles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

