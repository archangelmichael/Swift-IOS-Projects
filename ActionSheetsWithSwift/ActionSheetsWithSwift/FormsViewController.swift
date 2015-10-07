//
//  FormsViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/7/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

class FormsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSimpleForm(sender: AnyObject) {
        let alertController = UIAlertController(
            title: "Simple Form",
            message: "Fill Form",
            preferredStyle: .Alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .Default,
            handler: {
                (action:UIAlertAction!) -> Void in
                let usernameField = alertController.textFields?.first
                if let username = usernameField?.text {
                    print("\(username)")
                }
            }
        )
        
        alertController.addAction(okAction)
        
        let closeAction = UIAlertAction(
            title: "CLOSE",
            style: .Destructive,
            handler: nil
        )
        
        alertController.addAction(closeAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Username"
        }
        
        self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
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
