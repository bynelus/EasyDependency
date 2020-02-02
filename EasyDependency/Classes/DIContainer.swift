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
	
	var localizedDescription: String {
		switch self {
		case .lostReferenceToContainer: return "----- EASYDEPENDENCY -----> Container reference lost"
		case .implementationNotFound(let name): return "----- EASYDEPENDENCY -----> Implementation not found for: \(name).self"
		}
	}
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
	
	public func resolve<T>(filePath: String = #file, line: Int = #line, function: String = #function) throws -> T {
		if let first = registrations.first(where: { ($0 as? Registration<T>) != nil }) as? Registration<T> {
			return try first.resolve(logging: logging)
		} else if let container = superContainer {
			return try container.resolve(filePath: filePath, line: line, function: function)
		} else {
			let interfaceName = String(describing: T.self)
			logCrashIfEnabled(interface: interfaceName, filePath: filePath, line: line, function: function)
			throw DIError.implementationNotFound(name: interfaceName)
		}
	}
	
	public func resolve<T: Collection>(filePath: String = #file, line: Int = #line, function: String = #function) throws -> T {
		let filteredRegistrations: [Registration<T.Element>] = registrations.compactMap { $0 as? Registration<T.Element> }
		let filtered: [T.Element] = try filteredRegistrations.map { try $0.resolve(logging: logging) }
		let superContainerFiltered: [T.Element] = (try? superContainer?.resolve(filePath: filePath, line: line, function: function)) ?? []
		let total = filtered + superContainerFiltered
		guard let mapped = total as? T else {
			let interfaceName = String(describing: T.self)
			logCrashIfEnabled(interface: interfaceName, filePath: filePath, line: line, function: function)
			throw DIError.implementationNotFound(name: interfaceName)
		}
		return mapped
	}
	
	private func logCrashIfEnabled(interface: String, filePath: String, line: Int, function: String) {
		guard logging else { return }
		let fileName = URL(string: filePath)?.lastPathComponent ?? ""
		print("----- EASYDEPENDENCY -----> WARNING: \(interface).self not found (in \(fileName):\(line) -> \(function))")
	}
}
