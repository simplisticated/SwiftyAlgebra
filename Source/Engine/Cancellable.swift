//
//  Cancellable.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 26.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import Foundation

public protocol Cancellable {
    
    var isCancelled: Bool { get }
    
    func cancel()
    
}
