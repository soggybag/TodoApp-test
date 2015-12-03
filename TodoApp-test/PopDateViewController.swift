//
//  PopDateViewController.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/20/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePickerVCDismissed(date: NSDate?)
}



class PopDateViewController: UIViewController {
    
    weak var delegate: DatePickerViewControllerDelegate?
    
    var currentDate: NSDate?  {
        didSet {
            updatePickerCurrentDate()
        }
    }
    
    
    // MARK: IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var container: UIView!
    
    
    
    // MARK: IBActions 
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            let date = self.datePicker.date
            self.delegate?.datePickerVCDismissed(date)
        }
    }
    
    
    func updatePickerCurrentDate() {
        if let currentDate = self.currentDate {
            if let datePicker = self.datePicker {
                datePicker.date = currentDate
            }
        }
    }
    
    
    // MARK: Init
    
    convenience init() {
        self.init(nibName: "PopDateViewController", bundle: nil)
    }
    
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatePickerCurrentDate()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.delegate?.datePickerVCDismissed(nil)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        self.delegate?.datePickerVCDismissed(nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
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
