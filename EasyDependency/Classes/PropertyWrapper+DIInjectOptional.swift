//
//  PropertyWrapper+DIInjectOptional.swift
//  EasyDependency
//
//  Created by Niels Koole on 01/02/2020.
//

import Foundation

@propertyWrapper
public struct DIInjectOptional<Value> {
	private var _value: Value?
	
    public var wrappedValue: Value? {
		get { return _value }
		set { _value = newValue }
    }

	public init(_ type: Value.Type) {
		_value = DIContainer.shared.resolve(type.self)
	}
	
	public init(_ type: Value.Type, container: DIContainer) {
		_value = container.resolve(type.self)
	}
}
