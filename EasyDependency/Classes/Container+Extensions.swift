//
//  Container+Extensions.swift
//  EasyDependency
//
//  Created by Niels Koole on 19/07/2019.
//

import Foundation

// MARK: - Registration dependencies

public extension Container {
	func register<T>(_ interface: T.Type, _ type: RegistrationType = .lazyInstance, _ handler: @escaping (Self) throws -> T) throws {
		let registration = Registration<T>(type: type) { try handler(self) }
		registrations.append(registration)
		
		switch type {
		case .lazyInstance: break
		case .lazySingleton: break
		case .singleton:
			DispatchQueue(label: "Prepare implementation", qos: .userInitiated).async { [weak self] in
				do {
					try registration.prepareImplementation(logging: self?.logging ?? false)
				} catch let e {
					assertionFailure(e.localizedDescription)
				}
			}
		}
	}
	
	func build(_ prepare: (PreparationContainer) throws -> Void, waitUntilFinished: Bool, completion: @escaping (Container) -> Void) throws {
		let prepContainer = PreparationContainer(container: self)
		try prepare(prepContainer)
		
		/// After all dependencies are registered, we're going to initiate the ones that are non-lazy.
		if waitUntilFinished {
			try prepContainer.prepareDependenciesWhileWaiting(logging: logging) { completion(self) }
		} else {
			try prepContainer.prepareDependenciesNotWaiting(logging: logging) { completion(self) }
		}
	}
}

// MARK: - Resolving dependencies

public extension Container {
	func resolve<T>(_ interface: T.Type = T.self) throws -> T {
		// Due to potential performance decrease, the `resolveList` function is not used.
		for object in registrations {
			if let registration = object as? Registration<T> {
				return try registration.resolve(logging: logging)
			}
		}
		
		guard let container = superContainer else { throw EasyDependencyError.implementationNotFound(name: String(describing: T.self)) }
		return try container.resolve(interface)
	}
	
	func resolveList<T>(_ interface: T.Type = T.self) -> [T] {
		var implementations: [T] = []
		for object in registrations {
			if let registration = object as? Registration<T>,
				let instance = try? registration.resolve(logging: logging) {
				implementations.append(instance)
			}
		}
		
		let superContainerImplementations: [T] = superContainer?.resolveList() ?? []
		return implementations + superContainerImplementations
	}
}

