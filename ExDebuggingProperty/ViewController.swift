//
//  ViewController.swift
//  ExDebuggingProperty
//
//  Created by 김종권 on 2023/10/02.
//

import UIKit

class ViewController: UIViewController {

    @HistoryProperty 
    var personName = "jake"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personName = "jong"
        personName = "kim"
        personName = "j"
        
        $personName.printStack()
    }
}

@propertyWrapper
struct HistoryProperty<T> {
    private(set) var stack = [T]()
    var _wrappedValue: T
    var wrappedValue: T {
        get { _wrappedValue }
        set {
            stack.append(newValue)
            _wrappedValue = newValue
        }
    }
    
    init(wrappedValue: T) {
        self._wrappedValue = wrappedValue
        stack.append(wrappedValue)
    }
    
    var projectedValue: Self {
        self
    }
    
    func printStack() {
        stack
            .forEach { print($0, terminator: " ") }
    }
}
