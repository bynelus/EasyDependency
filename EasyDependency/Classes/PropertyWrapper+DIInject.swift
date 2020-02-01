//
//  PropertyWrapper+DIInject.swift
//  EasyDependency
//
//  Created by Niels Koole on 01/02/2020.
//

import Foundation

@propertyWrapper
public struct DIInject<Value> {
	private var _value: Value
	
    public var wrappedValue: Value {
		get { return _value }
		set { _value = newValue }
    }

	public init() {
		do {
			_value = try DIContainer.shared.resolve(Value.self)
		} catch let e {
			fatalError(e.localizedDescription)
		}
	}
	
	public init(container: DIContainer) {
		do {
			_value = try container.resolve(Value.self)
		} catch let e {
			fatalError(e.localizedDescription)
		}
	}
}
