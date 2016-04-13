//
//  ViewController.swift
//  AttributedLocalisedText
//
//  Created by Radi on 4/4/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var titles : [String] = ["en", "bg"]
    
    @IBOutlet weak var tfInput: UITextField!
    
    @IBOutlet weak var lblOutput: UILabel!
    
    @IBOutlet weak var vPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.titles = [NSLocalizedString("english", comment:""), NSLocalizedString("bulgarian", comment:"")]
//        self.tfInput.placeholder = NSLocalizedString("input", comment:"")
//        self.lblOutput.text = NSLocalizedString("output", comment:"")
        
        let stringStart = "Area"
        let stringEnd = "100"
        
        self.lblOutput.attributedText = self.getNormalBoldAttributedText(stringStart, strEnd: stringEnd)
    }
    
    func getNormalBoldAttributedText(strStart: String, strEnd: String) -> NSMutableAttributedString {
        let connector = ": "
        
        let startAttributes = [NSForegroundColorAttributeName: UIColor.blueColor(),
                               NSBackgroundColorAttributeName: UIColor.clearColor(),
                               NSFontAttributeName: UIFont.systemFontOfSize(100)]
        let attributedResult = NSMutableAttributedString(string: "\(strStart)\(connector)", attributes: startAttributes)
        
        let endAttributes = [NSForegroundColorAttributeName: UIColor.blueColor(),
                               NSBackgroundColorAttributeName: UIColor.clearColor(),
                               NSFontAttributeName: UIFont.boldSystemFontOfSize(100)]
        let attrStrEnd = NSAttributedString(string: strEnd, attributes: endAttributes)
        attributedResult.appendAttributedString(attrStrEnd)
        return attributedResult
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.lblOutput.text = self.tfInput.text
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titles.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }
}

extension ViewController : UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.lblOutput.text = self.titles[row]
    }
}

