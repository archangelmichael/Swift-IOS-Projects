//
//  UserFormViewController.swift
//  ActionSheetsWithSwift
//
//  Created by Radi on 10/8/15.
//  Copyright © 2015 archangel. All rights reserved.
//

import UIKit

protocol UserFormViewControllerDelegate {
    func userDataChangedWithUsername(username : String, age: String, gender: String) -> Void
}

class UserFormViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : UserFormViewControllerDelegate?
    
    let ageRanges : [String] = ["< 18", "18 - 25", "25 - 30", "30 - 35", "35 - 40", ">= 40"]
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var agePickerView: UIPickerView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.nameTextField.delegate = self
        self.agePickerView.delegate = self
        self.agePickerView.dataSource = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDone(sender: AnyObject) {
        let name : String? = self.nameTextField.text
        let age : String? = self.ageRanges[self.agePickerView.selectedRowInComponent(0)]
        let sex : String? = self.sexSegmentedControl .titleForSegmentAtIndex(self.sexSegmentedControl.selectedSegmentIndex)
        self.delegate?.userDataChangedWithUsername(name!, age: age!, gender: sex!)
    }
    
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerViewDelegate
    
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageRanges.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.ageRanges[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
