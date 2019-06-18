//
//  Registry.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

public enum EasyDependencyError: LocalizedError {
    case implementationNotFound(name: String)
	case lostReferenceToContainer
	
	public var errorDescription: String? {
		switch self {
		case .lostReferenceToContainer: return "EasyDependencyError - Lost Reference To Container"
		case .implementationNotFound(let name):
			return "EasyDependencyError - Implementation Not Found: \(name)"
		}
	}
}

public enum SchedulerThread {
	case main
	case background
}

public enum RegistrationType {
	case lazyInstance
	case lazySingleton
	case singleton(scheduler: SchedulerThread)
	
	public var isSingleton: Bool {
		switch self {
		case .lazyInstance: return false
		case .lazySingleton: return true
		case .singleton: return true
		}
	}
}

public protocol Container: AnyObject {
    var superContainer: Container? { get set }
    var registrations: [Any] { get set }
	var logging: Bool { get set }
    
    init(container: Container?)
}
