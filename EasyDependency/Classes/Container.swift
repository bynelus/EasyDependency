//
//  Registry.swift
//  EasyDependency
//
//  Created by Niels Koole on 18/10/2017.
//  Copyright © 2017 ByNelus. All rights reserved.
//

import Foundation

public protocol Container: AnyObject {
    var superContainer: Container? { get set }
    var registrations: [Any] { get set }
	var logging: Bool { get set }
	
    init(container: Container?)
}
