//
//  PreparationContainer.swift
//  EasyDependency
//
//  Created by Niels Koole on 19/07/2019.
//

import Foundation

public class PreparationContainer {
	typealias Prep = (Bool, @escaping () throws -> Void) throws -> Void
	
	let container: Container
	private var prepareImplementations: [Prep] = []
	
	init(container: Container) {
		self.container = container
	}
	
	func prepareDependenciesWhileWaiting(logging: Bool, completion: @escaping () throws -> Void) throws {
		let group = DispatchGroup()
		
		try prepareImplementations.forEach { impl in
			group.enter()
			try impl(logging) { group.leave() }
		}
		
		group.notify(queue: .main, execute: {
			do {
				try completion()
			} catch let e {
				assertionFailure(e.localizedDescription)
			}
		})
	}
	
	func prepareDependenciesNotWaiting(logging: Bool, completion: @escaping () throws -> Void) throws {
		try prepareImplementations.forEach { try $0(logging) { } }
		DispatchQueue.main.async {
			do {
				try completion()
			} catch let e {
				assertionFailure(e.localizedDescription)
			}
		}
	}
	
	public func register<T>(_ interface: T.Type, _ type: RegistrationType = .lazyInstance, _ handler: @escaping (Container) throws -> T) throws {
		let registration = Registration<T>(type: type) { try handler(self.container) }
		container.registrations.append(registration)
		
		switch type {
		case .lazyInstance: break
		case .lazySingleton: break
		case .singleton:
			
			/// We want this action to be cached, so we can do all registrations at once.
			/// This will solve the issue where dependencies were not registered yet while registering a non-lazy object.
			let preparationAction: Prep = { logging, completion in
				DispatchQueue(label: "Prepare implementation", qos: .userInitiated).async {
					do {
						try registration.prepareImplementation(logging: logging)
						try completion()
					} catch let e {
						assertionFailure(e.localizedDescription)
					}
				}
			}
			
			prepareImplementations.append(preparationAction)
		}
	}
}
