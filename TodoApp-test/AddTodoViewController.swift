//
//  AddTodoViewController.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UITextFieldDelegate {

    
    var popDatePicker: PopDatePicker?
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    
    // MARK: IBActions
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        // TODO: Add some validation
        if nameText.text != "" {
            let date = self.datePicker.date
            TodoManager.sharedInstance.addTodo(nameText.text!, date: date)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // MARK: TextField Delegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("text field should return")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("Text field should begin")
        if textField === dateTextField {
            print("text field is date textfield")
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate: NSDate? = formatter.dateFromString(dateTextField.text!)
            let dataChangedCallBack: PopDatePicker.PopDatePickerCallBack = {(newDate: NSDate, forTextField: UITextField) -> () in
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
            }
            popDatePicker?.pick(self, initDate: initDate, dataChanged: dataChangedCallBack)
            return false
        } else {
            return true
        }
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    
    func resign() {
        dateTextField.resignFirstResponder()
        nameText.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popDatePicker = PopDatePicker(textField: dateTextField)
        nameText.delegate = self
        dateTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
