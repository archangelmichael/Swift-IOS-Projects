//
//  AppDelegate.swift
//  SocialLogins
//
//  Created by Radi on 4/8/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import FBSDKCoreKit

import TwitterKit
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var profilePic : UIImage? = UIImage(named: "empty")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Twitter.sharedInstance().startWithConsumerKey("qyOz0CQ2oxg6Wv1gC7eMflaYe", consumerSecret: "To1BlXGa75GQosLz8Xbf1IopoxdHyMmMBLH3yFAuzmdPyCwq4g")
        Fabric.with([Twitter.self()])
        
        return true
    }

    //Track App Installs and App Opens
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    //Track App Installs and App Opens
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

