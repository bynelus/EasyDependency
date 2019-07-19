//
//  RegistrationType.swift
//  EasyDependency
//
//  Created by Niels Koole on 19/07/2019.
//

import Foundation

public enum RegistrationType {
	case lazyInstance
	case lazySingleton
	case singleton
	
	public var isSingleton: Bool {
		switch self {
		case .lazyInstance: return false
		case .lazySingleton: return true
		case .singleton: return true
		}
	}
}
