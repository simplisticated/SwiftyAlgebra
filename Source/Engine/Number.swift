//
//  Number.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 05.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

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
    
    private var value: Any
    
    // MARK: Public object methods
    
    // MARK: Private object methods
    
    // MARK: Protocol implementation
    
}

/*
 Conversions.
 */
public extension Number {
    
    public var integer: Int {
        get {
            switch self.value {
            case is Int:
                return self.value as! Int
            case is Float:
                let floatValue = self.value as! Float
                return Int(floatValue)
            case is Double:
                let doubleValue = self.value as! Double
                return Int(doubleValue)
            default:
                return self.value as! Int
            }
        }
    }
    
    public var float: Float {
        get {
            switch self.value {
            case is Int:
                let integerValue = self.value as! Int
                return Float(integerValue)
            case is Float:
                return self.value as! Float
            case is Double:
                let doubleValue = self.value as! Double
                return Float(doubleValue)
            default:
                return self.value as! Float
            }
        }
    }
    
    public var double: Double {
        get {
            switch self.value {
            case is Int:
                let integerValue = self.value as! Int
                return Double(integerValue)
            case is Float:
                let floatValue = self.value as! Float
                return Double(floatValue)
            case is Double:
                return self.value as! Double
            default:
                return self.value as! Double
            }
        }
    }
    
}

/*
 Integer numbers.
 */
public extension Number {
    
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
            
            let integerValue = self.integer
            return integerValue > 0
        }
    }
    
    public var isPrime: Bool {
        get {
            guard self.isInteger else {
                return false
            }
            
            let integerValue = self.integer
            
            guard integerValue > 0 else {
                return false
            }
            
            guard integerValue > 2 else {
                return true
            }
            
            for i in 2..<integerValue {
                if integerValue % i == 0 {
                    return false
                }
            }
            
            return true
        }
    }
    
    public var naturalDivisors: [Int] {
        get {
            guard self.isInteger else {
                return []
            }
            
            let integerValue = self.integer
            
            guard integerValue > 0 else {
                return []
            }
            
            return Array(1...integerValue).filter({ (value) -> Bool in
                return integerValue % value == 0
            })
        }
    }
    
    public var primeDivisors: [Int] {
        get {
            guard self.isNatural else {
                return []
            }
            
            let integerValue = self.integer
            
            return Array(1...integerValue).filter({ (value) -> Bool in
                guard Number(value: value).isPrime else {
                    return false
                }
                
                return integerValue % value == 0
            })
        }
    }
    
    public func primeDivisors(withCompletion completion: @escaping (_ divisors: [Int]) -> Void) -> PrimeDivisorsTask {
        let task = PrimeDivisorsTask(source: self) { (result, isCancelled) in
            if result != nil {
                completion(result!)
            }
        }
        task.start()
        return task
    }
    
    public var primeFactorization: [Int] {
        get {
            guard self.isNatural else {
                return []
            }
            
            guard !self.isPrime else {
                return []
            }
            
            let integerValue = self.integer
            var divident = integerValue
            var divisors = [Int]()
            
            while divident > 1 {
                for i in 2...divident {
                    guard Number(value: i).isPrime else {
                        continue
                    }
                    
                    guard divident % i == 0 else {
                        continue
                    }
                    
                    divisors.append(i)
                    divident /= i
                    break
                }
            }
            
            return divisors
        }
    }
    
    public func primeFactorization(withCompletion completion: @escaping (_ divisors: [Int]) -> Void) -> PrimeFactorizationTask {
        let task = PrimeFactorizationTask(source: self) { (result, isCancelled) in
            if result != nil {
                completion(result!)
            }
        }
        task.start()
        return task
    }
    
}

public extension Number {
    
    public class PrimeDivisorsTask: Task<Number, [Int]> {
        
        public override func perform(withSource source: Number) {
            guard source.isNatural else {
                self.didFinish(withResult: [])
                return
            }
            
            let integerValue = source.integer
            
            var divisors = [Int]()
            
            for i in 1...integerValue {
                guard Number(value: i).isPrime else {
                    continue
                }
                
                guard integerValue % i == 0 else {
                    continue
                }
                
                divisors.append(i)
                
                guard !self.isCancelled else {
                    return
                }
            }
            
            self.didFinish(withResult: divisors)
        }
        
    }
    
    public class PrimeFactorizationTask: Task<Number, [Int]> {
        
        public override func perform(withSource source: Number) {
            guard source.isNatural else {
                self.didFinish(withResult: [])
                return
            }
            
            guard !source.isPrime else {
                guard !self.isCancelled else {
                    return
                }
                
                self.didFinish(withResult: [])
                return
            }
            
            let integerValue = source.integer
            var divident = integerValue
            var divisors = [Int]()
            
            while divident > 1 {
                guard !self.isCancelled else {
                    return
                }
                
                for i in 2...divident {
                    guard !self.isCancelled else {
                        return
                    }
                    
                    guard Number(value: i).isPrime else {
                        continue
                    }
                    
                    guard divident % i == 0 else {
                        continue
                    }
                    
                    divisors.append(i)
                    divident /= i
                    break
                }
                
                self.didProgress(1.0 - (Float(divident) / Float(integerValue)))
            }
            
            self.didFinish(withResult: divisors)
        }
        
    }
    
}

/*
 Operators.
 */

public extension Number {
    
    // MARK: Addition
    
    public static func +(left: Number, right: Number) -> Number {
        return Number(value: left.double + right.double)
    }
    
    public static func +(left: Number, right: Int) -> Number {
        return Number(value: left.double + Double(right))
    }
    
    public static func +(left: Number, right: Float) -> Number {
        return Number(value: left.double + Double(right))
    }
    
    public static func +(left: Number, right: Double) -> Number {
        return Number(value: left.double + right)
    }
    
    public static func +(left: Int, right: Number) -> Number {
        return Number(value: Double(left) + right.double)
    }
    
    public static func +(left: Float, right: Number) -> Number {
        return Number(value: Double(left) + right.double)
    }
    
    public static func +(left: Double, right: Number) -> Number {
        return Number(value: left + right.double)
    }
    
    public static func +=(left: Number, right: Number) {
        left.value = left.double + right.double
    }
    
    public static func +=(left: Number, right: Int) {
        left.value = left.double + Double(right)
    }
    
    public static func +=(left: Number, right: Float) {
        left.value = left.double + Double(right)
    }
    
    public static func +=(left: Number, right: Double) {
        left.value = left.double + right
    }
    
    public static func +=(left: inout Int, right: Number) {
        left = left + right.integer
    }
    
    public static func +=(left: inout Float, right: Number) {
        left = left + right.float
    }
    
    public static func +=(left: inout Double, right: Number) {
        left = left + right.double
    }
    
    @discardableResult
    public static postfix func ++(number: Number) -> Number {
        number.value = number.double + 1.0
        return number
    }
    
    // MARK: Subtraction
    
    public static func -(left: Number, right: Number) -> Number {
        return Number(value: left.double - right.double)
    }
    
    public static func -(left: Number, right: Int) -> Number {
        return Number(value: left.double - Double(right))
    }
    
    public static func -(left: Number, right: Float) -> Number {
        return Number(value: left.double - Double(right))
    }
    
    public static func -(left: Number, right: Double) -> Number {
        return Number(value: left.double - right)
    }
    
    public static func -(left: Int, right: Number) -> Number {
        return Number(value: Double(left) - right.double)
    }
    
    public static func -(left: Float, right: Number) -> Number {
        return Number(value: Double(left) - right.double)
    }
    
    public static func -(left: Double, right: Number) -> Number {
        return Number(value: left - right.double)
    }
    
    public static func -=(left: Number, right: Number) {
        left.value = left.double - right.double
    }
    
    public static func -=(left: Number, right: Int) {
        left.value = left.double - Double(right)
    }
    
    public static func -=(left: Number, right: Float) {
        left.value = left.double - Double(right)
    }
    
    public static func -=(left: Number, right: Double) {
        left.value = left.double - right
    }
    
    public static func -=(left: inout Int, right: Number) {
        left = left - right.integer
    }
    
    public static func -=(left: inout Float, right: Number) {
        left = left - right.float
    }
    
    public static func -=(left: inout Double, right: Number) {
        left = left - right.double
    }
    
    @discardableResult
    public static postfix func --(number: Number) -> Number {
        number.value = number.double - 1.0
        return number
    }
    
    // MARK: Multiplication
    
    public static func *(left: Number, right: Number) -> Number {
        return Number(value: left.double * right.double)
    }
    
    public static func *(left: Number, right: Int) -> Number {
        return Number(value: left.double * Double(right))
    }
    
    public static func *(left: Number, right: Float) -> Number {
        return Number(value: left.double * Double(right))
    }
    
    public static func *(left: Number, right: Double) -> Number {
        return Number(value: left.double * right)
    }
    
    public static func *(left: Int, right: Number) -> Number {
        return Number(value: Double(left) * right.double)
    }
    
    public static func *(left: Float, right: Number) -> Number {
        return Number(value: Double(left) * right.double)
    }
    
    public static func *(left: Double, right: Number) -> Number {
        return Number(value: left * right.double)
    }
    
    public static func *=(left: Number, right: Number) {
        left.value = left.double * right.double
    }
    
    public static func *=(left: Number, right: Int) {
        left.value = left.double * Double(right)
    }
    
    public static func *=(left: Number, right: Float) {
        left.value = left.double * Double(right)
    }
    
    public static func *=(left: Number, right: Double) {
        left.value = left.double * right
    }
    
    public static func *=(left: inout Int, right: Number) {
        left = left * right.integer
    }
    
    public static func *=(left: inout Float, right: Number) {
        left = left * right.float
    }
    
    public static func *=(left: inout Double, right: Number) {
        left = left * right.double
    }
    
    // MARK: Division
    
    public static func /(left: Number, right: Number) -> Number {
        return Number(value: left.double / right.double)
    }
    
    public static func /(left: Number, right: Int) -> Number {
        return Number(value: left.double / Double(right))
    }
    
    public static func /(left: Number, right: Float) -> Number {
        return Number(value: left.double / Double(right))
    }
    
    public static func /(left: Number, right: Double) -> Number {
        return Number(value: left.double / right)
    }
    
    public static func /(left: Int, right: Number) -> Number {
        return Number(value: Double(left) / right.double)
    }
    
    public static func /(left: Float, right: Number) -> Number {
        return Number(value: Double(left) / right.double)
    }
    
    public static func /(left: Double, right: Number) -> Number {
        return Number(value: left / right.double)
    }
    
    public static func /=(left: Number, right: Number) {
        left.value = left.double / right.double
    }
    
    public static func /=(left: Number, right: Int) {
        left.value = left.double / Double(right)
    }
    
    public static func /=(left: Number, right: Float) {
        left.value = left.double / Double(right)
    }
    
    public static func /=(left: Number, right: Double) {
        left.value = left.double / right
    }
    
    public static func /=(left: inout Int, right: Number) {
        left = left / right.integer
    }
    
    public static func /=(left: inout Float, right: Number) {
        left = left / right.float
    }
    
    public static func /=(left: inout Double, right: Number) {
        left = left / right.double
    }
    
}
