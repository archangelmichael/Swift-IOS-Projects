//
//  ViewController.swift
//  TextViewWithButtons
//
//  Created by Radi on 8/8/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var scrollTags: UIScrollView!
    
    let tagFontSize : CGFloat = 20.0
    var tagTextFont = UIFont.systemFontOfSize(20.0)
    var tagDeleteFont = UIFont.boldSystemFontOfSize(20.0)
    let textColor = UIColor.whiteColor()
    let backgroundColor = UIColor.redColor()
    let verticalBtnOffset : CGFloat = 2.0
    let horizontalBtnOffset : CGFloat = 10.0
    
    var tagsOriginY : CGFloat = 10.0
    var tagsCountWidth : CGFloat = 0.0
    var tagMaxWidth : CGFloat = 0.0
    var tagMaxHeight : CGFloat = 30.0
    
    let tags : NSMutableOrderedSet = ["new", "another", "really long one", "asdasdsa", "a", "wqeqw", "gfgdsfdsfsd", "yeah"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tagsView = WordsScrollView(frame: CGRectMake(0, 0, 300, 300))
        tagsView.setup(self.tags, addNewText: "Add new tag", tagFontSize: 20.0, backgroundColor: UIColor.greenColor(), textColor: UIColor.redColor(), fillColor: UIColor.yellowColor(), verticalOffset: 2.0)
        self.view.addSubview(tagsView)
        
        
        return
//        self.tagTextFont = UIFont.systemFontOfSize(self.tagFontSize)
//        self.tagDeleteFont = UIFont.systemFontOfSize(self.tagFontSize, weight: 0.5)
//        self.tagMaxWidth = self.scrollTags.frame.size.width
//        self.tagMaxHeight = self.tagTextFont.sizeOfString("test", constrainedToWidth: Double(self.tagMaxWidth)).height
//        
//        self.fillTags()
    }
    
    func fillTags() -> Void {
        for subview in self.scrollTags.subviews {
            if subview.isKindOfClass(UIButton) {
                subview.removeFromSuperview()
            }
        }
        
        self.tagsOriginY = 10.0
        self.tagsCountWidth = 0.0
        
        if self.tags.count == 0 {
            let createTag = self.addCreateTagButton("add tag", index: 0, to: self.scrollTags)
            let tagsHeight = createTag.frame.origin.y + createTag.frame.size.height + 10;
            self.scrollTags.contentSize = CGSizeMake(self.scrollTags.frame.width, tagsHeight)
            return
        }
        
        for index in 0...self.tags.count-1 {
            self.addTagButton(self.tags[index] as! String, index: index, to: self.scrollTags)
            
            if index == self.tags.count - 1 { // the last button
                let createTag = self.addCreateTagButton("add tag", index: index + 1, to: self.scrollTags)
                let tagsHeight = createTag.frame.origin.y + createTag.frame.size.height + 10;

                //tagsHeight = tagsHeight < 280 ? 280 : tagsHeight;
                self.scrollTags.contentSize = CGSizeMake(self.scrollTags.frame.width, tagsHeight)
            }
        }
    }
    
    
    func addTagButton(tag: String, index: Int, to: UIView) -> UIButton {
        var tagBtnFrame : CGRect
        var textSize : CGSize = self.tagTextFont.sizeOfString(String.getDeleteStrForTag(tag),
                                                              constrainedToWidth: Double(self.tagMaxWidth))
        if (textSize.width > self.tagMaxWidth) {
            textSize.width = self.tagMaxWidth
        }
        
        if (index == 0) {
            tagBtnFrame = CGRectMake(10, self.tagsOriginY, textSize.width, self.tagMaxHeight);
            self.tagsCountWidth = textSize.width + self.horizontalBtnOffset;
        }
        else {
            if (self.tagsCountWidth + textSize.width > self.tagMaxWidth - self.horizontalBtnOffset) {
                self.tagsOriginY += self.tagMaxHeight + self.verticalBtnOffset;
                self.tagsCountWidth = self.horizontalBtnOffset;
            }
            
            tagBtnFrame = CGRectMake(self.tagsCountWidth + 2, self.tagsOriginY, textSize.width, self.tagMaxHeight);
            self.tagsCountWidth += textSize.width + 2;
        }
        
        let tagButton = UIButton.getTagButton(tagBtnFrame,
                                              attrText: String.getDeleteAttrStrForTag(tag,
                                                normalFont: self.tagTextFont,
                                                deleteFont: self.tagDeleteFont),
                                              tag: index,
                                              fontColor: self.textColor,
                                              backgroundColor: self.backgroundColor,
                                              borderColor: nil,
                                              tapDelegate: self,
                                              tapSelector: #selector(onTagSelected(_:)))
        to.addSubview(tagButton)
        return tagButton
    }
    
    func addCreateTagButton(tag: String, index: Int, to: UIView) -> UIButton {
        var tagBtnFrame : CGRect
        var textSize : CGSize = self.tagTextFont.sizeOfString(String.getCreateStrForTag(tag),
                                                              constrainedToWidth: Double(self.tagMaxWidth))
        if (textSize.width > self.tagMaxWidth) {
            textSize.width = self.tagMaxWidth
        }
        
        if (index == 0) {
            tagBtnFrame = CGRectMake(10, self.tagsOriginY, textSize.width, textSize.height);
            self.tagsCountWidth = textSize.width + self.horizontalBtnOffset;
        }
        else {
            if (self.tagsCountWidth + textSize.width > self.tagMaxWidth - self.horizontalBtnOffset) {
                self.tagsOriginY += textSize.height + self.verticalBtnOffset;
                self.tagsCountWidth = horizontalBtnOffset;
            }
            
            tagBtnFrame = CGRectMake(self.tagsCountWidth + 2, self.tagsOriginY, textSize.width, textSize.height);
            self.tagsCountWidth += textSize.width + 2;
        }
        
        let createTagButton = UIButton.getTagButton(tagBtnFrame,
                                                    attrText: String.getCreateAttrStrForTag(tag, createFont: self.tagTextFont),
                                                    tag: index,
                                                    fontColor: self.backgroundColor,
                                                    backgroundColor: self.textColor,
                                                    borderColor: self.backgroundColor,
                                                    tapDelegate: self,
                                                    tapSelector: #selector(onCreateTagSelected))
        to.addSubview(createTagButton)
        return createTagButton
    }
    
    func onCreateTagSelected() -> Void {
        let alert = UIAlertController(title: "UCB Approvals", message: "Enter new tag", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.addNewTag(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: "BACK", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func addNewTag(tag: String?) -> Void {
        guard let newTag = tag where newTag != "" else {
            return
        }
    
        self.tags.addObject(newTag)
        self.fillTags()
    }
    
    func onTagSelected(tagBtn: UIButton) -> Void {
        guard let tagName = tagBtn.titleLabel?.text where tagName != "" else {
            return
        }
        
        if let tag = String.getTagFromDeleteStr(tagName.lowercaseString) {
            self.tags.removeObject(tag)
            self.fillTags()
        }
    }
}

//extension UIFont {
//    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
//        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
//                                                         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
//                                                         attributes: [NSFontAttributeName: self],
//                                                         context: nil).size
//    }
//}
//
//extension UIButton {
//    static func getTagButton(frame: CGRect,
//                             attrText: NSAttributedString,
//                             tag: Int,
//                             fontColor: UIColor,
//                             backgroundColor: UIColor,
//                             borderColor: UIColor?,
//                             tapDelegate: AnyObject,
//                             tapSelector: Selector) -> UIButton {
//        let button = UIButton(type: UIButtonType.RoundedRect)
//        button.frame = frame;
//        button.setAttributedTitle(attrText, forState: .Normal)
//        button.tag = tag
//        button.layer.cornerRadius = button.frame.size.height/2
//        button.clipsToBounds = true
//        button.tintColor = fontColor
//        button.titleLabel?.backgroundColor = UIColor.clearColor()
//        button.backgroundColor = backgroundColor
//        button.addTarget(tapDelegate, action: tapSelector, forControlEvents: .TouchUpInside)
//        
//        if (borderColor != nil) {
//            button.layer.borderColor = borderColor!.CGColor
//            button.layer.borderWidth = 2.0
//        }
//        
//        return button
//    }
//}
//
//extension String {
//    static func getTagFromDeleteStr(deleteStr: String) -> String? {
//        if deleteStr.characters.count < 7 {
//            return nil
//        }
//        
//        let tagRange = deleteStr.startIndex.advancedBy(2) ..< deleteStr.endIndex.advancedBy(-5)
//        return deleteStr.substringWithRange(tagRange)
//    }
//    
//    static func getCreateStrForTag(tag: String) -> String {
//        return "  + \(tag)  "
//    }
//    
//    static func getCreateAttrStrForTag(tag: String, createFont: UIFont) -> NSAttributedString {
//        let attrStr = NSMutableAttributedString(string: "  + \(tag)  ",  attributes: [ NSFontAttributeName : createFont])
//        return attrStr
//    }
//    
//    static func getDeleteStrForTag(tag: String) -> String {
//        return "  \(tag)  x  "
//    }
//    
//    static func getDeleteAttrStrForTag(tag: String, normalFont: UIFont, deleteFont: UIFont) -> NSAttributedString {
//        let attrDelete = NSAttributedString(string: "x  ", attributes: [ NSFontAttributeName : deleteFont])
//        let attrStr = NSMutableAttributedString(string: "  \(tag)  ",  attributes: [ NSFontAttributeName : normalFont])
//        attrStr.appendAttributedString(attrDelete)
//        return attrStr
//    }
//}

