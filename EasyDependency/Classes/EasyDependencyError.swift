//
//  EasyDependencyError.swift
//  EasyDependency
//
//  Created by Niels Koole on 19/07/2019.
//

import Foundation

public enum EasyDependencyError: LocalizedError {
	case implementationNotFound(name: String)
	case lostReferenceToContainer
	
	public var errorDescription: String? {
		switch self {
		case .lostReferenceToContainer: return "EasyDependencyError - Lost Reference To Container"
		case .implementationNotFound(let name): return "EasyDependencyError - Implementation Not Found: \(name)"
		}
	}
}
