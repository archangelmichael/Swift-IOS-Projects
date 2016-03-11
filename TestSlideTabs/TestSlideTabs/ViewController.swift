//
//  ViewController.swift
//  TestSlideTabs
//
//  Created by Radi on 3/11/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vContainer: UIView!
    
    @IBOutlet weak var vActiveTab: UIView!
    @IBOutlet weak var cstrActiveTab: NSLayoutConstraint!
    
    
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnMidRight: UIButton!
    @IBOutlet weak var btnMidLeft: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    
    var pagesVC : PagesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("pagesVC") as! PagesViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                self.btnLeft.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                self.btnLeft.setImage(UIImage(named: "ico_profile_purple"), forState: .Normal)
        
                self.btnMidLeft.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                self.btnMidLeft.setImage(UIImage(named: "ico_fav"), forState: .Normal)
        
                self.btnMidRight.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                self.btnMidRight.setImage(UIImage(named: "ico_compare"), forState: .Normal)
        
                self.btnRight.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                self.btnRight.setImage(UIImage(named: "ico_settings"), forState: .Normal)
        
        self.vContainer.addSubview(self.pagesVC.view)
        self.addChildViewController(self.pagesVC)
        pagesVC.view.frame = CGRectMake(0, 0, self.vContainer.frame.size.width, self.vContainer.frame.size.height);
        self.vContainer.addSubview(pagesVC.view)
        pagesVC.didMoveToParentViewController(self)
        
        self.pagesVC.parentVC = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLeft(sender: AnyObject) {
        self.pagesVC.goTo(0)
        self.setActiveTab(0)
    }
    
    @IBAction func onMidLeft(sender: AnyObject) {
        self.pagesVC.goTo(1)
        self.setActiveTab(1)
    }
    
    @IBAction func onMidRight(sender: AnyObject) {
        self.pagesVC.goTo(2)
        self.setActiveTab(2)
    }
    
    @IBAction func onRight(sender: AnyObject) {
        self.pagesVC.goTo(3)
        self.setActiveTab(3)
    }
    
    func setActiveTab(index: Int) {
        self.cstrActiveTab.constant = CGFloat(index) * 0.25 * self.view.frame.size.width
        self.vActiveTab.layoutIfNeeded()
    }
    
    func CRY() {
        print("CRYING")
    }
}

