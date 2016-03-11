//
//  PagesViewController.swift
//  TestSlideTabs
//
//  Created by Radi on 3/11/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class PagesViewController: UIPageViewController {
    
    var currentPageIndex : Int = 0
    var nextPageIndex : Int = 0
    var previousPageIndex : Int = 0
    
    var parentVC : ViewController? = nil

    private(set) lazy var orderedVCs: [UIViewController] = {
        return [self.newChildVC("leftVC"), self.newChildVC("midleftVC"), self.newChildVC("midrightVC"), self.newChildVC("rightVC")]
    }()
    
    private func newChildVC(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(name)")
    }

    func goTo(index : Int) {
        if index == currentPageIndex {
            return
        }
        
        let direction : UIPageViewControllerNavigationDirection = index < currentPageIndex ? .Reverse : .Forward
        
        self.currentPageIndex = index
        // self.parentVC?.CRY()
        let indexVC = orderedVCs[index]
        self.setViewControllers([indexVC],
            direction: direction,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = orderedVCs.first {
            setViewControllers([firstVC],
                direction: .Forward,
                animated: true,
                completion: nil)
        }
    }
    
    func getVCIndex(vc: UIViewController) -> Int {
        for (var index = 0; index < self.orderedVCs.count; index++) {
            if self.orderedVCs[index] == vc {
                return index
            }
        }
        
        return 0
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

// MARK: UIPageViewControllerDataSource

extension PagesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedVCs.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard orderedVCs.count > previousIndex else {
                return nil
            }
            
            return orderedVCs[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let vcIndex = orderedVCs.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = vcIndex + 1
            let orderedVCsCount = orderedVCs.count
            
            guard orderedVCsCount != nextIndex else {
                return nil
            }
            
            guard orderedVCsCount > nextIndex else {
                return nil
            }
            
            return orderedVCs[nextIndex]
    }
    
    // PRESENTATION COUNT
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return orderedVCs.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        guard let firstVC = viewControllers?.first,
//            firstVCIndex = orderedVCs.indexOf(firstVC) else {
//                return 0
//        }
//        
//        return firstVCIndex
//    }
}

extension PagesViewController: UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //print("PREVIOUS : \(previousViewControllers) + \(completed)")
        if completed {
            self.previousPageIndex = self.getVCIndex(previousViewControllers[0])
        
            if self.nextPageIndex > self.previousPageIndex {
                self.currentPageIndex++
                self.parentVC?.setActiveTab(self.currentPageIndex)
            }
            
            if self.nextPageIndex < self.previousPageIndex {
                self.currentPageIndex--
                self.parentVC?.setActiveTab(self.currentPageIndex)
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        //print("PENDING : \(pendingViewControllers)")
        self.nextPageIndex = self.getVCIndex(pendingViewControllers[0])
    }
}
