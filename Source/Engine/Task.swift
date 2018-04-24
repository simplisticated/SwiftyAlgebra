//
//  Task.swift
//  SwiftyAlgebra
//
//  Created by Igor Matyushkin on 23.04.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import UIKit

open class Task<Source, Result> {
    
    // MARK: Class variables & properties
    
    // MARK: Public class methods
    
    // MARK: Private class methods
    
    // MARK: Initializers
    
    public init(source: Source, onResult resultHandler: @escaping ResultHandler) {
        self.source = source
        self.resultHandler = resultHandler
        self.isCancelled = false
    }
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    // MARK: Object variables & properties
    
    public fileprivate(set) var source: Source
    
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
    
    public func onProgress(_ handler: @escaping ProgressHandler) {
        self.progressHandler = handler
    }
    
    public func didProgress(_ progress: Float) {
        self.progressHandler?(progress)
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
