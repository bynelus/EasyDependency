//
//  AppContainer.swift
//  EasyDependency_Example
//
//  Created by Niels Koole on 29/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import EasyDependency

class AppContainer: Container {
	var superContainer: Container?
	var registrations: [Any] = []
	var logging: Bool = true
	
	required init(container: Container?) {
		self.superContainer = container
	}
	
	func runBackgroundTasks() throws {
		print("START BACKGROUND TASKS")
	}
}
