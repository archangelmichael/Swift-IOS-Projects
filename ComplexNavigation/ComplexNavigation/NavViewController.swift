//
//  NavViewController.swift
//  ComplexNavigation
//
//  Created by Radi on 2/5/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showStartVC() {
       self.popToRootViewControllerAnimated(true)
    }
    
    
    func showFirstVC() {
        var vcs = self.viewControllers
        print(vcs.count)
        var vc1 : UIViewController?
        for index in 0..<vcs.count {
            let vc = vcs[index]
            if vc.isKindOfClass(FirstViewController) {
                vc1 = vc
                break
            }
        }
        
        if vc1 != nil {
            self.popToViewController(vc1!, animated: true)
        }
        else {
            print("NEW VC")
            vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("firstVC")
            self.pushViewController(vc1!, animated: true)
        }
    }
    
    
    func showSecondVC() {
        var vcs = self.viewControllers
        print(vcs.count)
        var vc2 : UIViewController?
        for index in 0..<vcs.count {
            let vc = vcs[index]
            if vc.isKindOfClass(SecondViewController) {
                vc2 = vc
                break
            }
        }
        
        if vc2 != nil {
            self.popToViewController(vc2!, animated: true)
        }
        else {
            print("NEW VC")
            vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("secondVC")
            self.pushViewController(vc2!, animated: true)
        }
    }
    
    
    func showThirdVC() {
        var vcs = self.viewControllers
        print(vcs.count)
        var vc1 : UIViewController?
        for index in 0..<vcs.count {
            let vc = vcs[index]
            if vc.isKindOfClass(ThirdViewController) {
                vc1 = vc
                break
            }
        }
        
        if vc1 != nil {
            self.popToViewController(vc1!, animated: true)
        }
        else {
            print("NEW VC")
            vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("thirdVC")
            self.pushViewController(vc1!, animated: true)
        }
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
