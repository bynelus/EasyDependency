//
//  StorageCImpl.swift
//  EasyDependency_Example
//
//  Created by Niels Koole on 19/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class StorageCImpl: Storage {
	
	let random: Int = Int(arc4random_uniform(1000))
	let string: String
	
	init(string: String) {
		sleep(2)
		self.string = string
	}
	
	func retrieve() {
		// Implementation ..
	}
	
	func clear() {
		// Implementation ..
	}
	
	func save() {
		// Implementation ..
	}
}
