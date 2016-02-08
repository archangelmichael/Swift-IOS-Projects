//
//  SecondViewController.swift
//  ComplexNavigation
//
//  Created by Radi on 2/5/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.title = "SECOND"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gostart(sender: AnyObject) {
        (self.navigationController as! NavViewController).showStartVC()
    }
    
    @IBAction func go1(sender: AnyObject) {
        (self.navigationController as! NavViewController).showFirstVC()
    }
    
    @IBAction func go3(sender: AnyObject) {
        (self.navigationController as! NavViewController).showThirdVC()
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
