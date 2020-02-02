//
//  PropertyWrapper+DIInjectList.swift
//  EasyDependency
//
//  Created by Niels Koole on 01/02/2020.
//

import Foundation

@propertyWrapper
public struct DIInjectList<Value: Collection> {
	private var _value: Value
	
    public var wrappedValue: Value {
		get { return _value }
		set { _value = newValue }
    }

	public init() {
		do {
			_value = try DISharedContainer.resolve()
		} catch let e {
			fatalError(e.localizedDescription)
		}
	}
	
	public init(container: DIContainer) {
		do {
			_value = try container.resolve()
		} catch let e {
			fatalError(e.localizedDescription)
		}
	}
}
