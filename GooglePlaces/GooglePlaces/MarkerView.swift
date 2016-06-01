//
//  MarkerView.swift
//  GooglePlaces
//
//  Created by Radi on 6/1/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import iPhone_AR_Toolkit

protocol MarkerViewDelegate : AnyObject {
    func didTouchMarkerView(markerView: MarkerView)
}

class MarkerView : UIView {
    var lblTitle : UILabel
    var lblDistance : UILabel
    
    let kWidth : CGFloat = 200.0
    let kHeight : CGFloat = 100.0
    
    let coordinate : ARGeoCoordinate
    let delegate : MarkerViewDelegate
    
    let font : UIFont = UIFont.systemFontOfSize(24)
    
    init(coordinate: ARGeoCoordinate, delegate: MarkerViewDelegate) {
        self.coordinate = coordinate
        self.delegate = delegate
        
        //3
        self.lblTitle = UILabel(frame: CGRectMake(0.0, 0.0, kWidth, 40.0))
        self.lblTitle.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        self.lblTitle.textColor = UIColor.whiteColor()
        self.lblTitle.textAlignment = NSTextAlignment.Center
        self.lblTitle.text = coordinate.title
        self.lblTitle.font = self.font
        self.lblTitle.sizeToFit()
        
        //4
        self.lblDistance = UILabel(frame: CGRectMake(0.0, 45.0, kWidth, 40.0))
        self.lblDistance.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        self.lblDistance.textColor = UIColor.whiteColor()
        self.lblDistance.textAlignment = NSTextAlignment.Center
        self.lblDistance.text = "\(Int(coordinate.distanceFromOrigin)) m"
        self.lblDistance.font = self.font
        self.lblDistance.sizeToFit()
        
        super.init(frame: CGRectMake(0.0, 0.0, kWidth, kHeight))
        
        self.userInteractionEnabled = true
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblDistance)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.lblDistance.text = "\(Int(self.coordinate.distanceFromOrigin)) m"
    }
}
