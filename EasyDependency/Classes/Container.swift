//
//  Registry.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

public enum EasyDependencyError: Error {
    case implementationNotFound
}

public protocol Container: AnyObject {
    var superContainer: Container? { get set }
    var registrations: [Any] { get set }
    
    init(container: Container?)
}

extension Container {
    
    public func register<T>(_ handler: @escaping () -> T) {
        let registration = Registration<T> { () -> T in
            return handler()
        }
        
        registrations.append(registration)
    }
    
    public func resolve<T>(_ interface: T.Type = T.self) throws -> T {
        for object in registrations {
            if let registration = object as? Registration<T> {
                return registration.resolve()
            }
        }
        
        guard let container = superContainer else { throw EasyDependencyError.implementationNotFound }
        return try container.resolve(interface)
    }
}
