//: Playground - noun: a place where people can play

import UIKit

class Todo {
    var completed = false
}


var array = [Todo]()

func testThing() -> String {
    var s = ""
    for todo in array {
        s += "\(todo.completed) "
    }
    return s
}

for i in 1..<10 {
    let todo = Todo()
    todo.completed = Bool(i % 2)
    array.append(todo)
}

print(testThing())

array.sortInPlace { (a:Todo, b:Todo) -> Bool in
    !a.completed && b.completed
}

print(testThing())




