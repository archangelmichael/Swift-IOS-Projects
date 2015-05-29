//
//  ViewController.swift
//  SwiftURLRequests
//
//  Created by Radi on 5/29/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var methodSelected: UILabel!
    @IBOutlet weak var responseText: UITextView!
    
    var pickerData:[String] = [String]();
    var url: String = "";
    var method: String = "";

// RENDERING CONTROLLER VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self;
        picker.delegate = self;
        urlInput.delegate = self;
        responseText.delegate = self;
        
        pickerData = ["GET", "POST", "PUT", "DELETE"];
        urlInput.text = "";
        url = "";
        method = pickerData[0];
        methodSelected.text = method
        responseText.text = "";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// BUTTONS ACTIONS
    
    @IBAction func onSendGeneralRequest(sender: AnyObject) {
        var googleUrl = NSURL(string: "http://google.ca")
        var request = NSMutableURLRequest(URL: googleUrl!)
        // Set Method
        request.HTTPMethod = "GET"
        // Set Sent Data
        var params = ["username":"jameson", "password":"password"] as Dictionary<String, String>
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        // Set Headers
        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
        var session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if((error) != nil) {
                println(error.localizedDescription)
            }
            
            var strData = NSString(data: data, encoding: NSASCIIStringEncoding)
            println(strData)
        })
        
        task.resume()
    }
    
    func handleRequestResponce(data: NSData!, response:NSURLResponse!, error: NSError!) -> Void {
        println("Response: \(response)")
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
        
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        if(err != nil) {
            println(err!.localizedDescription)
            let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Error could not parse JSON: '\(jsonStr)'")
        }
        else {
            // The JSONObjectWithData constructor didn't return an error. But, we should still
            // check and make sure that json has a value using optional binding.
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                var success = parseJSON["success"] as? Int
                println("Succes: \(success)")
            }
            else {
                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: \(jsonStr)")
            }
        }
    }
    
    @IBAction func onSendRequest(sender: AnyObject) {
        url = urlInput.text;
        if  count(url) <= 0 {
                let alert = UIAlertView(title: "Invalid url",
                                                message: "Please enter valid url",
                                                delegate: nil,
                                                cancelButtonTitle: "OK")
            alert.show()
            return;
        }
        
        let requestUrl = NSURL(string: url)
        let request = NSURLRequest(URL: requestUrl!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            if error != nil {
                println(((error.code) as NSNumber).stringValue)
                self.responseText!.text = "Error: \n" +
                                    ((error.code) as NSNumber).stringValue +
                                    "\n" +
                                    error.description
            }
            else {
                println(NSString(data: data, encoding: NSUTF8StringEncoding))
                self.responseText!.text = "Request Successful: \n" + (NSString(data: data, encoding:NSUTF8StringEncoding) as! String)
            }
        }
    }
    
    // BEST SOLUTION !!!
    @IBAction func onSendRequestUsingNSURLSession(sender: AnyObject) {
        let sessionUrl = NSURL(string: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(sessionUrl!) {(data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
            if  (error != nil) {
                self.responseText!.text = "Error: \n" +
                    ((error.code) as NSNumber).stringValue +
                    "\n" +
                    error.description
            }
            else {
                self.responseText!.text = "Request Successful: \n" + (NSString(data: data, encoding:NSUTF8StringEncoding) as! String)
            }
        }
        
        task.resume()
    }
    
    @IBAction func onSendRequestUsingNSURLConnection(sender: AnyObject) {
        //  First, initialize an NSURL and an NSURLRequest:
        let connectionUrl = NSURL(string: url)
        let request = NSURLRequest(URL: connectionUrl!)
        
        //  Then, you can load the request asynchronously with:
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            if  (error != nil) {
                self.responseText!.text = "Error: \n" +
                    ((error.code) as NSNumber).stringValue +
                    "\n" +
                    error.description
            }
            else {
                self.responseText!.text = "Request Successful: \n" + (NSString(data: data, encoding:NSUTF8StringEncoding) as! String)
            }
        }
        
        //  Or you can initialize an NSURLConnection:
        //let connection = NSURLConnection(request: request, delegate:someObject, startImmediately: true)
        /**
            Just make sure someObject implements the NSURLConnectionDataDelegate protocol, 
            and then deal with the data received in the appropriate delegate methods.
        */
    }

    
    
// TEXT FIELD DELEGATE METHODS
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return false
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        self.view.endEditing(true);
        return true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
// PICKER VIEW METHODS
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        method = pickerData[row];
        methodSelected.text = method
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerRowLabel : UILabel? = view as? UILabel; // if let pickerRowLabel = view as? UILabel
        if pickerRowLabel == nil {
            //YOUR PICKERVIEW FRAME. HEIGHT IS 44 by default.
            pickerRowLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 22))
            pickerRowLabel!.textAlignment = NSTextAlignment.Center
            //FORMAT THE FONT FOR THE LABEL AS YOU LIKE
            pickerRowLabel!.backgroundColor = UIColor.clearColor();
            pickerRowLabel!.userInteractionEnabled = true;
        }
        
        pickerRowLabel!.text = pickerData[row];
        return pickerRowLabel!;
    }
}

