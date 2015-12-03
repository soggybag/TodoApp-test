//
//  Todo.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

class Todo2 {
    var name: String
    var completed: Bool = false
    
    init() {
        name = ""
    }
    
    init(name: String) {
        self.name = name
    }
}

