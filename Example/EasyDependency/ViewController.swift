//
//  ViewController.swift
//  EasyDependency
//
//  Created by NielsKoole on 10/29/2017.
//  Copyright (c) 2017 NielsKoole. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
		regularUseCase()
		buildUseCase()
    }
	
	func regularUseCase() {
		let appContainer = AppContainer(container: nil)
		let featureContainer = FeatureContainer(container: appContainer)
		
		do {
			try appContainer.register(Storage.self) { _ in StorageAImpl() }
			try featureContainer.register(String.self) { _ in "Test je mofo" }
			try featureContainer.register(Storage.self, .singleton) { container in StorageBImpl(string: try container.resolve()) }
		} catch let e {
			dump(e.localizedDescription)
		}
		
		let storageImplementation = try? featureContainer.resolve(Storage.self)
		let storageList: [Storage] = featureContainer.resolveList()
		
		dump(storageImplementation)
		dump(storageList)
	}
	
	func buildUseCase() {
		let appContainer = AppContainer(container: nil)
		
		do {
			try appContainer.build({ container in
				try container.register(String.self) { _ in "Test je mofo 2 - FANTASTICS" }
				try container.register(String.self, .singleton) { _ in "Deze is op de background geinitieerd.." }
				try container.register(Storage.self, .singleton) { _ in StorageCImpl(string: "test") }
				try container.register(String.self) { _ in "Test je mofo 3 - FANTASTICS MAGIC" }
			}, waitUntilFinished: true, completion: { container in
				print("Completed")
				
				let stringList: [String] = container.resolveList()
				print(stringList)
				
				let storageList: [Storage] = container.resolveList()
				print(storageList)
			})
		} catch let e {
			dump(e.localizedDescription)
		}
	}
}

