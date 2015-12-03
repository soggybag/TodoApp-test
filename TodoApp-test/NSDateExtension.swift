//
//  NSDateExtension.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/20/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation

extension NSDate {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle;
        formatter.timeStyle = .NoStyle;
        return formatter.stringFromDate(self)
    }
}