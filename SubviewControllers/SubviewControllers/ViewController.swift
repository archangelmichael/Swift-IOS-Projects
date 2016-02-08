//
//  ViewController.swift
//  SubviewControllers
//
//  Created by Radi on 1/28/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    var customSubview : UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        let storyboard = UIStoryboard(name: "SubStoryboard", bundle: nil)
        customSubview = storyboard.instantiateViewControllerWithIdentifier("tabs") as! UITabBarController
        
        self.addChildViewController(customSubview)
        customSubview.view.frame = contentView.frame
        
        self.view.addSubview(customSubview.view)
        //self.view.viewWithTag(<#T##tag: Int##Int#>)
        customSubview.didMoveToParentViewController(self)
        
    }
    
    override func viewDidLayoutSubviews() {
        if customSubview != nil {
            customSubview.view.frame = contentView.frame
        }
        //controller.removeFromParentViewController()
        //controller.view.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

