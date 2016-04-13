//
//  ViewController.swift
//  TWLoginPMPrep
//
//  Created by Radi on 4/13/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import Fabric
import TwitterKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ivAvatar: UIImageView!
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblToken: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lastSession = Twitter.sharedInstance().sessionStore.session() {
            print("Loading last session....")
            self.lblID.text = lastSession.userID
            self.lblToken.text = lastSession.authToken
            self.getTWUserData(lastSession.userID, userToken: lastSession.authToken)
        }
        else {
            self.resetFields()
        }
        
    }

    func getTWUserData(userID: String, userToken: String) {
//        let clientID = TWTRAPIClient()
//        
//        clientID.loadUserWithID(userID) { (user, error) -> Void in
//            if error != nil {
//                print("Error loading user : \(error!.localizedDescription)")
//            }
//            else {
//                print("Loaded user : \(user!)")
//            }
//            
//        }
        
        
        //let client = TWTRAPIClient(userID: userID)
        let client = TWTRAPIClient.clientWithCurrentUser()
        
        let request = client.URLRequestWithMethod("GET",
                                                  URL: "https://api.twitter.com/1.1/account/verify_credentials.json",
                                                  parameters: ["include_email": "true", "skip_status": "true"],
                                                  error: nil)
        
        client.sendTwitterRequest(request) { response, data, connectionError in
            if connectionError != nil {
                print("Failed loading TW user : \(connectionError!.localizedDescription)")
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                print("json: \(json)")
                
                let imageUrl = json["profile_image_url"] as? String
                //let id = json["id"] as? String
                let name = json["name"] as? String
                let email = json["email"] as? String
                //let token = json["token"] as? String
                self.setFields(imageUrl, id: userID, name: name, email: email, token: userToken)
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    @IBAction func onTWLogin(sender: AnyObject) {
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if error != nil {
                print("TW login error : \(error!.localizedDescription)")
                self.resetFields()
            }
            else {
                print("TW session created : \(session!)")
                
                self.getTWUserData(session!.userID, userToken: session!.authToken)
            }
        }
    }
    
    @IBAction func onTWLogout(sender: AnyObject) {
        let sessionStore = Twitter.sharedInstance().sessionStore
        if let userId = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userId)
        }
        
        self.resetFields()
    }
    
    func setFields(imageUrl: String?, id: String?, name: String?, email: String?, token: String?) {
        if imageUrl != nil {
            if let url = NSURL(string: imageUrl!) {
                if let data = NSData(contentsOfURL : url) {
                    if let image = UIImage(data: data) {
                        self.ivAvatar.image = image
                    }
                }
            }
        }
            
        self.lblID.text = id
        self.lblName.text = name
        self.lblEmail.text = email
        self.lblToken.text = token
    }
    
    func resetFields() {
        self.ivAvatar.image = UIImage(named: "empty")
        self.lblID.text = "ID"
        self.lblName.text = "Name"
        self.lblEmail.text = "Email"
        self.lblToken.text = "Token"
    }
}

