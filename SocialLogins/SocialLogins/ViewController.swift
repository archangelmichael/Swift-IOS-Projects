//
//  ViewController.swift
//  SocialLogins
//
//  Created by Radi on 4/8/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    
    @IBOutlet weak var btnCustomFBLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate
        self.btnFBLogin.delegate = self
        
        // Set read permissions
        self.btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let accessToken = FBSDKAccessToken.currentAccessToken()
        print("ACCESS TOKEN : \(accessToken)")
        
        if accessToken != nil {
            print("ACCESS TOKEN STRING : \(accessToken.tokenString)")
            self.getUserData()
        }
    }

    
    @IBAction func onTwitterLogin(sender: AnyObject) {
        
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
        
        
    }
    
    func getTWUserData() {
        // Swift
        let client = TWTRAPIClient.clientWithCurrentUser()
        let request = client.URLRequestWithMethod("GET",
                                                  URL: "https://api.twitter.com/1.1/account/verify_credentials.json",
                                                  parameters: ["include_email": "true", "skip_status": "true"],
                                                  error: nil)
        
        client.sendTwitterRequest(request) { response, data, connectionError in
            
            print(response)
            print(data)
            print(connectionError)
        }
    }
    
    @IBAction func onCustomFBLogin(sender: AnyObject) {
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self) { (result, error) in
            if error != nil {
                print("FB error login : \(error)")
            }
            else if result.isCancelled {
                print("FB login cancelled")
            }
            else {
                print("FB login success with permissions : \(result.grantedPermissions)")
                
                if result.grantedPermissions.contains("email") {
                    print("FB email permission granted")
                    self.getUserData()
                }
                else {
                    print("FB no email permission granted")
                    fbLoginManager.logOut()
                }
            }
        }
    }
    
    func getUserData() {
        if FBSDKAccessToken.currentAccessToken().hasGranted("email") {
            let fbRequest = FBSDKGraphRequest(graphPath: "me?fields=id,email,name,picture", parameters: nil, HTTPMethod: "GET")
            fbRequest.startWithCompletionHandler { (connection, result, error) in
                if error != nil {
                    print("FB Get user data failed : \(error.localizedDescription)")
                }
                else {
                    print("FB user data fetched : \(result)")
                    if let userID = result["id"] as? String {
                        //self.getFBSizedPic(userID, width: 300, height: 300)
                        self.getFBLargePic(userID)
                    }
                    else {
                        print("NO USER ID")
                        FBSDKLoginManager().logOut()
                    }
                }
            }
        }
        else {
            print("NO EMAIL ACCESS")
            FBSDKLoginManager().logOut()
        }
    }
    
    func getFBSizedPic(userID: String, width: Int, height: Int) {
        let url = NSURL(string: "https://graph.facebook.com/\(userID)/picture?width=\(width)&height=\(height)")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if error != nil {
                print("Error getting profile image : \(error)")
            }
            else {
                if let image = UIImage(data: data!) {
                    AppDelegate.profilePic = image
                }
                else {
                    AppDelegate.profilePic = UIImage(named: "empty")
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.enter()
                }
            }
        }
    }
    
    func getFBLargePic(userID: String) {
        let url = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large&return_ssl_resources=1")
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
            if error != nil {
                print("Error getting profile image : \(error)")
            }
            else {
                if let image = UIImage(data: data!) {
                    AppDelegate.profilePic = image
                }
                else {
                    AppDelegate.profilePic = UIImage(named: "empty")
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.enter()
                }
            }
        }
    }
    
    func enter() {
        self.performSegueWithIdentifier("enterSegue", sender: self)
    }
}
    
extension ViewController : FBSDKLoginButtonDelegate {
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print("FB will login")
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            print("FB error login : \(error)")
        }
        else if result.isCancelled {
            print("FB login cancelled")
        }
        else {
            print("FB login success with permissions : \(result.grantedPermissions)")
            if result.grantedPermissions.contains("email") {
                print("FB email permission granted")
                self.getUserData()
            }
            else {
                print("FB no email permission granted")
                FBSDKLoginManager().logOut()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("FB logout")
    }
}

