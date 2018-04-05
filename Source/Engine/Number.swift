//
//  Number.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 05.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import UIKit

public class Number {
    
    // MARK: Class variables & properties
    
    // MARK: Public class methods
    
    // MARK: Private class methods
    
    // MARK: Initializers
    
    public init(value: Int) {
        self.value = value
    }
    
    public init(value: Float) {
        self.value = value
    }
    
    public init(value: Double) {
        self.value = value
    }
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    // MARK: Object variables & properties
    
    fileprivate var value: Any
    
    public var isInteger: Bool {
        get {
            switch self.value {
            case is Int:
                return true
            case is Float:
                let floatValue = self.value as! Float
                return floor(floatValue) == floatValue
            case is Double:
                let doubleValue = self.value as! Double
                return floor(doubleValue) == doubleValue
            default:
                return false
            }
        }
    }
    
    public var isNatural: Bool {
        get {
            guard self.isInteger else {
                return false
            }
            
            let integerValue = self.value as! Int
            return integerValue > 0
        }
    }
    
    public var isPrime: Bool {
        get {
            guard self.isInteger else {
                return false
            }
            
            let integerValue = self.value as! Int
            
            guard integerValue > 2 else {
                return integerValue == 1
            }
            
            return Array(2...(integerValue - 1)).filter({ (value) -> Bool in
                return integerValue % value == 0
            }).count == 0
        }
    }
    
    public var naturalDivisors: [Int] {
        get {
            guard self.isInteger else {
                return []
            }
            
            let integerValue = self.value as! Int
            
            guard integerValue > 0 else {
                return []
            }
            
            return Array(1...integerValue).filter({ (value) -> Bool in
                return integerValue % value == 0
            })
        }
    }
    
    // MARK: Public object methods
    
    // MARK: Private object methods
    
    // MARK: Protocol implementation
    
}
