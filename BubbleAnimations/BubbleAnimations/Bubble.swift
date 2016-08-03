//
//  Bubble.swift
//  BubbleAnimations
//
//  Created by Radi on 8/3/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Bubble: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    private var count : UInt = 0
    
    class func instanceFromNib(frame: CGRect, title: String, count: UInt) -> Bubble {
        let bubble : Bubble = UINib(nibName: "Bubble", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! Bubble
        bubble.frame = frame
        
        bubble.layer.cornerRadius = bubble.frame.size.width/2
        bubble.clipsToBounds = true
        
        bubble.setData(title, count: count)
        return bubble
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title: String, count: UInt) -> Void {
        self.lblTitle.text = title
        self.setCount(count)
    }
    
    func getCount() -> UInt {
        return self.count
    }
    
    func setCount(count: UInt) -> Void {
        self.count = count
        if count > 99 {
            self.lblCount.text = "99+"
        }
        else {
            self.lblCount.text = "\(count)"
        }
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
