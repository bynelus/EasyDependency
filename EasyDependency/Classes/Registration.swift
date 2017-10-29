//
//  Registration.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

struct Registration<Interface> {
    private let implementation: () -> Interface
    
    init(implementation: @escaping () -> Interface) {
        self.implementation = implementation
    }
    
    func resolve() -> Interface {
        return implementation()
    }
}
