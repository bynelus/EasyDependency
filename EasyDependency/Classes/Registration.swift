//
//  Registration.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

public enum RegistrationType {
    case none
    case singleton
}

class Registration<Interface> {
    let type: RegistrationType
    let implementation: () throws -> Interface
    var cachedInstance: Interface?
    
    init(type: RegistrationType, implementation: @escaping () throws -> Interface) {
        self.type = type
        self.implementation = implementation
    }
    
    func resolve() throws -> Interface {
        if let cachedInstance = cachedInstance {
            return cachedInstance
        }
        
        let instance = try implementation()
        
        // Cache the instance if it needs to be a singleton
        if type == .singleton {
            cachedInstance = instance
        }
        
        return instance
    }
}
