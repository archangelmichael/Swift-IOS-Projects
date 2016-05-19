//
//  DataService.swift
//  AnimationsNextGeneration
//
//  Created by Radi on 5/19/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

import UIKit

class DataService {
    
    func getQuoteData(completion: (quote: String, author: String?) -> ()) {
        
        let url = NSURL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!
        
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let aQuote = jsonDictionary["quoteText"] as! String
                let aAuthor = jsonDictionary["quoteAuthor"] as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(quote: aQuote, author: aAuthor)
                })
                
            } catch {
                print("invalid json query")
            }
        }).resume()
    }
}
