//
//  Storage.swift
//  EasyDependency_Example
//
//  Created by Niels Koole on 29/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

protocol Storage {
    func retrieve()
    func clear()
    func save()
}
