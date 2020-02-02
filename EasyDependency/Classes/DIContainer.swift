//
//  DIContainer.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

public enum DIError: LocalizedError {
	case implementationNotFound(name: String)
	case lostReferenceToContainer
}

public let DISharedContainer = DIContainer(container: nil)

open class DIContainer {
	private let superContainer: DIContainer?
    private var registrations: [Any] = []
	public var logging: Bool = true
	
	public init(container: DIContainer? = nil) {
		self.superContainer = container
	}
	
	public func register<T>(_ interface: T.Type, _ type: RegistrationType = .lazyInstance, _ handler: @escaping (DIContainer) throws -> T) throws {
		let registration = Registration<T>(type: type) { try handler(self) }
		registrations.append(registration)
	}
	
	public func resolve<T>() throws -> T {
		if let first = registrations.first(where: { ($0 as? Registration<T>) != nil }) as? Registration<T> {
			return try first.resolve(logging: logging)
		} else if let container = superContainer {
			return try container.resolve()
		} else {
			throw DIError.implementationNotFound(name: String(describing: T.self))
		}
	}
	
	public func resolve<T: Collection>() throws -> T {
		let filteredRegistrations: [Registration<T.Element>] = registrations.compactMap { $0 as? Registration<T.Element> }
		let filtered: [T.Element] = try filteredRegistrations.map { try $0.resolve(logging: logging) }
		let superContainerFiltered: [T.Element] = (try superContainer?.resolve()) ?? []
		let total = filtered + superContainerFiltered
		guard let mapped = total as? T else { throw DIError.implementationNotFound(name: String(describing: T.self)) }
		return mapped
	}
}
