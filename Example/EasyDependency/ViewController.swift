//
//  ViewController.swift
//  EasyDependency
//
//  Created by NielsKoole on 10/29/2017.
//  Copyright (c) 2017 NielsKoole. All rights reserved.
//

import UIKit
import Schedule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let appContainer = AppContainer()
		let featureContainer = FeatureContainer(container: appContainer)
		
		do {
			try appContainer.register(Storage.self) { _ in StorageAImpl() }
			try featureContainer.register(String.self) { _ in "Test je mofo" }
			try featureContainer.register(Storage.self, .singleton(scheduler: .background)) { container in StorageBImpl(string: try container.resolve()) }
		} catch let e {
			dump(e.localizedDescription)
		}
        
        let storageImplementation = try? featureContainer.resolve(Storage.self)
        let storageList: [Storage] = featureContainer.resolveList()
        
        dump(storageImplementation)
        dump(storageList)
    }
}

