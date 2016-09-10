//
//  ParentViewController.swift
//  SideBarMenu
//
//  Created by Radi on 9/10/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var cstrMenuLeading: NSLayoutConstraint!
    
    @IBOutlet weak var vNav: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcA")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
        self.lblTitle.text = "Screen A"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTap))
        self.containerView.addGestureRecognizer(tap);
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(screenDrag(_:)))
        self.view.addGestureRecognizer(drag)
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.toggleMenu(false,
                        animated: false,
                        completion: nil)
    }
    
    func screenTap() {
        self.toggleMenu(false,
                        animated: true,
                        completion: nil)
    }
    
    func screenDrag(drag: UIPanGestureRecognizer) {
        let dX  = drag.translationInView(self.view).x/1.5
        let menuLeft = self.cstrMenuLeading.constant
        let result = menuLeft + dX
        if drag.state == UIGestureRecognizerState.Changed {
            if result > 0 {
                self.cstrMenuLeading.constant = 0
                self.menuView.layoutIfNeeded()
            }
            else if result < -self.menuView.frame.size.width {
                self.cstrMenuLeading.constant = -self.menuView.frame.size.width
                self.menuView.layoutIfNeeded()
            }
            else {
                self.cstrMenuLeading.constant = result
                self.menuView.layoutIfNeeded()
            }
        }
        else if drag.state == UIGestureRecognizerState.Ended {
            if menuLeft > -self.menuView.frame.size.width/2 {
                self.cstrMenuLeading.constant = 0
                self.menuView.layoutIfNeeded()
            }
            else {
                self.cstrMenuLeading.constant = -self.menuView.frame.size.width
                self.menuView.layoutIfNeeded()
            }
        }
    }
    

    @IBAction func onMenu(sender: AnyObject) {
        self.toggleMenu(cstrMenuLeading.constant != 0,
                        animated: true,
                        completion: nil)
    }
    
    // Hide/Show side menu
    func toggleMenu(visible: Bool, animated: Bool, completion: ((Bool) -> Void)?) {
        cstrMenuLeading.constant = visible ? 0 : -self.menuView.frame.size.width
        UIView.animateWithDuration(animated ? 0.3 : 0.0,
                                   animations:
            {
                self.menuView.layoutIfNeeded()
        },
                                   completion: completion)
    }
    
    // Switch to another VC if not already shown
    func switchVisibleVC(index: Int) {
        if index == 0 && !self.currentViewController!.isKindOfClass(AViewController) {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcA")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            self.lblTitle.text = "Screen A"
        }
        else if index == 1 && !self.currentViewController!.isKindOfClass(BViewController) {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcB")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            self.lblTitle.text = "Screen B"
        }
    }
    
    // Switch transition
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        // TODO: Set the starting state of your constraints here
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        // TODO: Set the ending state of your constraints here
        
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            // only need to call layoutIfNeeded here
            newViewController.view.layoutIfNeeded()
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    // Switch child VC view with autolayout constraints
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
}

extension ParentViewController : MenuDelegate {
    // Menu delegate method to change visible VC
    func switchVC(index: Int) {
        self.toggleMenu(cstrMenuLeading.constant != 0,
                        animated: true,
                        completion: {
                            finished in
                            self.switchVisibleVC(index)
        })
    }
    
    // Set menu delegate here
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // you can set this name in 'segue.embed' in storyboard
        if segue.identifier == "appendMenu" {
            let menuVC = segue.destinationViewController as! Menu
            menuVC.delegate = self
        }
    }
}
