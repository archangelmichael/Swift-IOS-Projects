//
//  LogoutViewController.swift
//  SocialLogins
//
//  Created by Radi on 4/8/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

class LogoutViewController: UIViewController {

    
    @IBOutlet weak var btnFBLogout: FBSDKLoginButton!
    
    @IBOutlet weak var btnCustomFBLogout: UIButton!
    
    @IBOutlet weak var ivAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnFBLogout.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        if AppDelegate.profilePic != nil {
            self.ivAvatar.image = AppDelegate.profilePic
        }
    }
    
    @IBAction func onCustomFBLogin(sender: AnyObject) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        AppDelegate.profilePic = UIImage(named: "empty")
        self.exit()
    }
    
    func exit() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension LogoutViewController : FBSDKLoginButtonDelegate {
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print("FB will logout")
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            print("FB error logout : \(error)")
        }
        else if result.isCancelled {
            print("FB logout cancelled")
        }
        else {
            print("FB logout success with permissions : \(result.grantedPermissions)")
            self.exit()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("FB logout")
    }
}