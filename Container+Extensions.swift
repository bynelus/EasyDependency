//
//  Container+Extensions.swift
//  EasyDependency
//
//  Created by Niels Koole on 04/04/2019.
//

import Foundation

extension Container {
	
	public func register<T>(_ interface: T.Type, _ type: RegistrationType = .lazyInstance, _ handler: @escaping (Self) throws -> T) throws {
		let registration = Registration<T>(isSingleton: type.isSingleton) { try handler(self) }
		registrations.append(registration)
		
		switch type {
		case .lazyInstance: break
		case .lazySingleton: break
		case .singleton(let scheduler):
			switch scheduler {
			case .main: try registration.prepareImplementation(logging: logging)
			case .background:
				DispatchQueue(label: "Prepare implementation", qos: .userInitiated).async { [weak self] in
					do {
						try registration.prepareImplementation(logging: self?.logging ?? false)
					} catch let e {
						assertionFailure(e.localizedDescription)
					}
				}
			}
		}
	}
	
	public func resolve<T>(_ interface: T.Type = T.self) throws -> T {
		// Due to potential performance decrease, the `resolveList` function is not used.
		for object in registrations {
			if let registration = object as? Registration<T> {
				return try registration.resolve(logging: logging)
			}
		}
		
		guard let container = superContainer else { throw EasyDependencyError.implementationNotFound(name: String(describing: T.self)) }
		return try container.resolve(interface)
	}
	
	public func resolveList<T>(_ interface: T.Type = T.self) -> [T] {
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
