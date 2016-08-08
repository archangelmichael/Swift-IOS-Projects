//
//  WordsScrollView.swift
//  TextViewWithButtons
//
//  Created by Radi on 8/8/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class WordsScrollView: UIScrollView {

    var words : NSMutableOrderedSet = []
    
    var tagTextFont = UIFont.systemFontOfSize(20.0)
    var tagDeleteFont = UIFont.boldSystemFontOfSize(20.0)
    var verticalBtnOffset : CGFloat = 2.0
    let horizontalBtnOffset : CGFloat = 10.0
    
    var tagsOriginY : CGFloat = 10.0
    var tagsCountWidth : CGFloat = 0.0
    var tagMaxWidth : CGFloat = 0.0
    var tagMaxHeight : CGFloat = 30.0
    
    var addText : String = "Add new"
    
    var tagTextColor : UIColor = UIColor.whiteColor()
    var tagFillColor : UIColor = UIColor.redColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(words: NSMutableOrderedSet,
               addNewText: String,
               tagFontSize: CGFloat,
               backgroundColor: UIColor,
               textColor: UIColor,
               fillColor: UIColor,
               verticalOffset: CGFloat) -> Void {
        self.words = words
        self.addText = addNewText
        
        self.tagTextFont = UIFont.systemFontOfSize(tagFontSize)
        self.tagDeleteFont = UIFont.boldSystemFontOfSize(tagFontSize)
        
        self.backgroundColor = backgroundColor
        
        self.tagTextColor = textColor
        self.tagFillColor = fillColor
        
        self.verticalBtnOffset = verticalOffset
        
        self.tagMaxWidth = self.frame.size.width
        self.tagMaxHeight = self.tagTextFont.sizeOfString("test", constrainedToWidth: Double(self.tagMaxWidth)).height
        
        self.reloadWords()
    }
    
    // remove word if present in tags
    func removeWord(word: String?) -> Void {
        guard let newWord = word where newWord != "" else {
            return
        }
        
        if self.words.containsObject(newWord) {
            self.words.removeObject(newWord)
            self.reloadWords()
        }
    }
    
    
    private func reloadWords() -> Void {
        for subview in self.subviews {
            if subview.isKindOfClass(UIButton) {
                subview.removeFromSuperview()
            }
        }
        
        self.tagsOriginY = 10.0
        self.tagsCountWidth = 0.0
        
        if self.words.count == 0 {
            let createWord = self.addCreateWordButton(self.addText.lowercaseString , index: 0)
            let totalWordsHeight = createWord.frame.origin.y + createWord.frame.size.height + 10;
            self.contentSize = CGSizeMake(self.frame.width, totalWordsHeight)
            return
        }
        
        for index in 0...self.words.count-1 {
            self.addWordButton(self.words[index] as! String, index: index)
            
            if index == self.words.count - 1 { // the last button
                let createWord = self.addCreateWordButton(self.addText.lowercaseString, index: index + 1)
                let totalWordsHeight = createWord.frame.origin.y + createWord.frame.size.height + 10;
                self.contentSize = CGSizeMake(self.frame.width, totalWordsHeight)
            }
        }
    }
    
    func addWordButton(word: String, index: Int) -> UIButton {
        var wordBtnFrame : CGRect
        var textSize : CGSize = self.tagTextFont.sizeOfString(String.getDeleteStrForTag(word),
                                                              constrainedToWidth: Double(self.tagMaxWidth))
        if (textSize.width > self.tagMaxWidth) {
            textSize.width = self.tagMaxWidth
        }
        
        if (index == 0) {
            wordBtnFrame = CGRectMake(10, self.tagsOriginY, textSize.width, self.tagMaxHeight);
            self.tagsCountWidth = textSize.width + self.horizontalBtnOffset;
        }
        else {
            if (self.tagsCountWidth + textSize.width > self.tagMaxWidth - self.horizontalBtnOffset) {
                self.tagsOriginY += self.tagMaxHeight + self.verticalBtnOffset;
                self.tagsCountWidth = self.horizontalBtnOffset;
            }
            
            wordBtnFrame = CGRectMake(self.tagsCountWidth + 2, self.tagsOriginY, textSize.width, self.tagMaxHeight);
            self.tagsCountWidth += textSize.width + 2;
        }
        
        let wordButton = UIButton.getTagButton(wordBtnFrame,
                                               attrText: String.getDeleteAttrStrForTag(word,
                                                normalFont: self.tagTextFont,
                                                deleteFont: self.tagDeleteFont),
                                               tag: index,
                                               fontColor: self.tagTextColor,
                                               backgroundColor: self.tagFillColor,
                                               borderColor: nil,
                                               tapDelegate: self,
                                               tapSelector: #selector(onWordSelected(_:)))
        self.addSubview(wordButton)
        return wordButton
    }
    
    func addCreateWordButton(word: String, index: Int) -> UIButton {
        var wordBtnFrame : CGRect
        var textSize : CGSize = self.tagTextFont.sizeOfString(String.getCreateStrForTag(word),
                                                              constrainedToWidth: Double(self.tagMaxWidth))
        if (textSize.width > self.tagMaxWidth) {
            textSize.width = self.tagMaxWidth
        }
        
        if (index == 0) {
            wordBtnFrame = CGRectMake(10, self.tagsOriginY, textSize.width, textSize.height);
            self.tagsCountWidth = textSize.width + self.horizontalBtnOffset;
        }
        else {
            if (self.tagsCountWidth + textSize.width > self.tagMaxWidth - self.horizontalBtnOffset) {
                self.tagsOriginY += textSize.height + self.verticalBtnOffset;
                self.tagsCountWidth = horizontalBtnOffset;
            }
            
            wordBtnFrame = CGRectMake(self.tagsCountWidth + 2, self.tagsOriginY, textSize.width, textSize.height);
            self.tagsCountWidth += textSize.width + 2;
        }
        
        let createWordButton = UIButton.getTagButton(wordBtnFrame,
                                                     attrText: String.getCreateAttrStrForTag(word, createFont: self.tagTextFont),
                                                     tag: index,
                                                     fontColor: self.tagFillColor,
                                                     backgroundColor: self.tagTextColor,
                                                     borderColor: self.tagFillColor,
                                                     tapDelegate: self,
                                                     tapSelector: #selector(onCreateWord))
        self.addSubview(createWordButton)
        return createWordButton
    }
    
    func onCreateWord() -> Void {
        let alert = UIAlertController(title: "UCB Approvals", message: self.addText, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.addNewWord(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: "BACK", style: .Destructive, handler: nil))
        self.window!.rootViewController!.presentViewController(alert, animated: true, completion: nil)
    }
    
    func addNewWord(word: String?) -> Void {
        guard let newWord = word where newWord != "" else {
            return
        }
        
        self.words.addObject(newWord)
        self.reloadWords()
    }
    
    func onWordSelected(wordBtn: UIButton) -> Void {
        guard let wordStr = wordBtn.titleLabel?.text where wordStr != "" else {
            return
        }
        
        if let word = String.getTagFromDeleteStr(wordStr) {
            self.words.removeObject(word)
            self.reloadWords()
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

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
                                                         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: self],
                                                         context: nil).size
    }
}

extension UIButton {
    static func getTagButton(frame: CGRect,
                             attrText: NSAttributedString,
                             tag: Int,
                             fontColor: UIColor,
                             backgroundColor: UIColor,
                             borderColor: UIColor?,
                             tapDelegate: AnyObject,
                             tapSelector: Selector) -> UIButton {
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.frame = frame;
        button.setAttributedTitle(attrText, forState: .Normal)
        button.tag = tag
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
        button.tintColor = fontColor
        button.titleLabel?.backgroundColor = UIColor.clearColor()
        button.backgroundColor = backgroundColor
        button.addTarget(tapDelegate, action: tapSelector, forControlEvents: .TouchUpInside)
        
        if (borderColor != nil) {
            button.layer.borderColor = borderColor!.CGColor
            button.layer.borderWidth = 2.0
        }
        
        return button
    }
}

extension String {
    static func getTagFromDeleteStr(deleteStr: String) -> String? {
        if deleteStr.characters.count < 7 {
            return nil
        }
        
        let tagRange = deleteStr.startIndex.advancedBy(2) ..< deleteStr.endIndex.advancedBy(-5)
        return deleteStr.substringWithRange(tagRange)
    }
    
    static func getCreateStrForTag(tag: String) -> String {
        return "  + \(tag)  "
    }
    
    static func getCreateAttrStrForTag(tag: String, createFont: UIFont) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: "  + \(tag)  ",  attributes: [ NSFontAttributeName : createFont])
        return attrStr
    }
    
    static func getDeleteStrForTag(tag: String) -> String {
        return "  \(tag)  x  "
    }
    
    static func getDeleteAttrStrForTag(tag: String, normalFont: UIFont, deleteFont: UIFont) -> NSAttributedString {
        let attrDelete = NSAttributedString(string: "x  ", attributes: [ NSFontAttributeName : deleteFont])
        let attrStr = NSMutableAttributedString(string: "  \(tag)  ",  attributes: [ NSFontAttributeName : normalFont])
        attrStr.appendAttributedString(attrDelete)
        return attrStr
    }
}

