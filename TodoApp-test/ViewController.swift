//
//  ViewController.swift
//  TodoApp-test
//
//  Created by mitchell hudson on 11/10/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: TableView Data Source 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoManager.sharedInstance.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        let todo = TodoManager.sharedInstance.todoAtIndex(indexPath.row)
        
        cell.textLabel?.text = todo.name
        setAccessoryForCell(cell, completed: todo.completed)
        
        let formatter = NSDateFormatter()
        // formatter.dateStyle = .FullStyle // easy, use a built in style
        formatter.dateFormat = "MMMM d, yyyy, H:mm:ss" // Or, use define a custom style 
        let date = formatter.stringFromDate(NSDate(timeIntervalSince1970: todo.date))
        print("Date in cell: \(NSDate(timeIntervalSince1970: todo.date))")
        cell.detailTextLabel?.text = date
        
        // let hue = 1 / CGFloat(TodoManager.sharedInstance.count) * CGFloat(indexPath.row)
        // cell.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        
        let b = 0.5 / CGFloat(TodoManager.sharedInstance.count) * CGFloat(indexPath.row) + 0.5
        cell.backgroundColor = UIColor(hue: 0.1, saturation: 1, brightness: b, alpha: 1)
        
        
        return cell
    }
    
    
    func setAccessoryForCell(cell: UITableViewCell, completed: Bool) {
        if completed {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
    
    
    // MARK: TableView Delegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todo = TodoManager.sharedInstance.todoAtIndex(indexPath.row)
        print("Did Select cell: \(todo.name)")
        todo.completed = !todo.completed
        TodoManager.sharedInstance.saveContext()
        TodoManager.sharedInstance.sortTodos()
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            setAccessoryForCell(cell, completed: todo.completed)
        }
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            TodoManager.sharedInstance.deleteTodoAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }
    
    
    // MARK: View Lifecycle methods
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

