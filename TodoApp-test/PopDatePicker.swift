//
//  PopDatePicker.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/20/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

public class PopDatePicker: NSObject, UIPopoverPresentationControllerDelegate, DatePickerViewControllerDelegate {
    
    public typealias PopDatePickerCallBack = (newDate: NSDate, forTextField: UITextField) -> ()
    
    var datePickerVC: PopDateViewController
    var popover: UIPopoverPresentationController?
    var textField: UITextField!
    var dataChanged: PopDatePickerCallBack?
    var presented = false
    var offset: CGFloat = 8.0
    
    
    public init(textField: UITextField) {
        datePickerVC = PopDateViewController()
        self.textField = textField
        super.init()
    }
    
    public func pick(inViewController: UIViewController, initDate: NSDate?, dataChanged: PopDatePickerCallBack) {
        
        if presented {
            return
        }
        
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        datePickerVC.preferredContentSize = CGSizeMake(500, 208)
        datePickerVC.currentDate = initDate
        
        popover = datePickerVC.popoverPresentationController
        if let popover = popover {
            
            popover.sourceView = textField
            popover.sourceRect = CGRectMake(self.offset, textField.bounds.size.height, 0, 0)
            popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(datePickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    
    // MARK: UIPopoverPresentationControllerDelegate Methods
    
    public func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    // MARK: DatePickerViewControllerDelegate
    
    func datePickerVCDismissed(date: NSDate?) {
        if let dataChanged = dataChanged {
            if let date = date {
                dataChanged(newDate: date, forTextField: textField)
            }
        }
        presented = false
    }

}

