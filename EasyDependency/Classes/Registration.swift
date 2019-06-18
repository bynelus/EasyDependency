//
//  Registration.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

class Registration<T> {
	let isSingleton: Bool
    let implementation: () throws -> T
    var cachedInstance: T?
    
    init(isSingleton: Bool, implementation: @escaping () throws -> T) {
        self.isSingleton = isSingleton
        self.implementation = implementation
    }
	
	private func createImplementationInstance(logging: Bool) throws -> T {
		guard logging else { return try implementation() }
		
		let start = CFAbsoluteTimeGetCurrent()
		let instance = try implementation()
		let diff = CFAbsoluteTimeGetCurrent() - start
		print("----- EASYDEPENDENCY -----> \(String(describing: instance)) (Duration: \(diff) ms)")
		return instance
	}
	
	func prepareImplementation(logging: Bool) throws {
		cachedInstance = try createImplementationInstance(logging: logging)
	}
    
	func resolve(logging: Bool) throws -> T {
        guard let cachedInstance = cachedInstance else {
			let instance = try createImplementationInstance(logging: logging)
			
			if isSingleton {
				self.cachedInstance = instance
			}
			
			return instance
		}
		
		return cachedInstance
    }
}
