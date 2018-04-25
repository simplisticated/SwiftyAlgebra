//
//  Task.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 23.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import UIKit

open class Task<Source, Result>: Asynchronous {
    
    // MARK: Class variables & properties
    
    // MARK: Public class methods
    
    // MARK: Private class methods
    
    // MARK: Initializers
    
    public init(source: Source) {
        self.source = source
        self.progress = 0.0
        self.isCancelled = false
    }
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    // MARK: Object variables & properties
    
    public fileprivate(set) var source: Source
    
    public var progress: Float {
        didSet {
            self.progressHandler?(progress)
        }
    }
    
    fileprivate var resultHandler: ResultHandler?
    
    fileprivate var progressHandler: ProgressHandler?
    
    public fileprivate(set) var isCancelled: Bool
    
    fileprivate var dispatchWorkItem: DispatchWorkItem?
    
    // MARK: Public object methods
    
    public func start() {
        self.dispatchWorkItem = DispatchWorkItem { [weak self] in
            guard let source = self?.source else {
                return
            }
            
            self!.perform(withSource: source)
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: self.dispatchWorkItem!)
    }
    
    open func perform(withSource source: Source) {
        // Do something...
    }
    
    public func onResult(_ handler: @escaping ResultHandler) {
        self.resultHandler = handler
    }
    
    public func onProgress(_ handler: @escaping ProgressHandler) {
        self.progressHandler = handler
    }
    
    public func didFinish(withResult result: Result) {
        self.dispatchWorkItem = nil
        
        guard !self.isCancelled else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let handler = self?.resultHandler else {
                return
            }
            
            handler(result, false)
        }
    }
    
    public func cancel() {
        if self.dispatchWorkItem != nil {
            self.dispatchWorkItem!.cancel()
            self.dispatchWorkItem = nil
        }
        
        self.isCancelled = true
        
        DispatchQueue.main.async { [weak self] in
            guard let handler = self?.resultHandler else {
                return
            }
            
            handler(nil, true)
        }
    }
    
    // MARK: Private object methods
    
    // MARK: Protocol implementation
    
}

public extension Task {
    
    public typealias ResultHandler = (_ result: Result?, _ isCancelled: Bool) -> Void
    
    public typealias ProgressHandler = (_ progress: Float) -> Void
    
}
