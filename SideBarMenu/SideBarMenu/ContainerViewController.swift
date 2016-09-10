//
//  ContainerViewController.swift
//  SideBarMenu
//
//  Created by Radi on 9/10/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var containerViewA: UIView!
    @IBOutlet weak var containerViewB: UIView!
    
    @IBOutlet weak var vNav: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchVisibleVC(true)
        // Do any additional setup after loading the view.
    }

    @IBAction func onMenu(sender: AnyObject) {
        let visible = self.containerViewA.alpha == 1.0
        self.switchVisibleVC(!visible)
    }
    
    func switchVisibleVC(showA: Bool) {
        self.lblTitle.text = showA ? "A" : "B"
        
        UIView.animateWithDuration(0.5, animations: {
            self.containerViewA.alpha = showA ? 1.0 : 0.0
            self.containerViewB.alpha = showA ? 0.0 : 1.0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
