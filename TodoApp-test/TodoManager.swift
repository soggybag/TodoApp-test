//
//  TodoManager.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit
import CoreData

class TodoManager {
    // Make a singleton
    static let sharedInstance = TodoManager()
    
    // An Array to hold todos
    var todos = [Todo]()
    // ManagedObjectContext
    let context: NSManagedObjectContext!
    // Count of todos
    var count: Int {
        get {
            return todos.count
        }
    }
    
    
    
    
    // Fetch Todo items from core data
    func fetchTodos() {
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        
        // Sort the results on completed
        let sortDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            todos = results as! [Todo]
            print("Fetch todos count:\(todos.count)")
        } catch let error as NSError {
            print("Could not fetch \(error) \(error.userInfo)")
        }
        
        var t = ""
        for todo in todos {
            let formatter = NSDateFormatter()
            print(todo.date)
            let date = formatter.stringFromDate(NSDate(timeIntervalSince1970: todo.date))
            t += "\(todo.name):\(todo.completed) *\(date)* "
        }
        print(t)
    }
    
    
    func sortTodos() {
        todos.sortInPlace { (a:Todo, b:Todo) -> Bool in
            !a.completed && b.completed
        }
    }
    
    
    
    func todoAtIndex(index: Int) -> Todo {
        return todos[index]
    }
    
    
    func addTodo(name: String, date: NSDate) {
        let todo = NSEntityDescription.insertNewObjectForEntityForName("Todo", inManagedObjectContext: context) as! Todo
        // let todo = Todo(name: name)
        todo.name = name
        todo.completed = false
        print("add todo date:\(date.timeIntervalSince1970)")
        todo.date = date.timeIntervalSince1970
        print(todo.date)
        todos.append(todo)
        saveContext()
        sortTodos()
    }
    
    
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Problem saving \(error), \(error.userInfo)")
        }
    }
    
    
    func deleteTodoAtIndex(index: Int) {
        self.context.deleteObject(todoAtIndex(index))
        todos.removeAtIndex(index)
        saveContext()
    }
    
    
    // MARK: Init
    
    private init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        fetchTodos()
        // addDefaultTodos()
    }
    
    
    
    // MARK: Test methods
    func addDefaultTodos() {
        /*
        addTodo("Get out of bed")
        addTodo("Eat breakfast")
        addTodo("Brush teeth")
        addTodo("Tie shoes")
        */
    }
}





