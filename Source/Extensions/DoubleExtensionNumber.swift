//
//  DoubleExtensionNumber.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 05.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

public extension Double {
    
    public var lgr: Number {
        get {
            return Number(value: self)
        }
    }
    
}
