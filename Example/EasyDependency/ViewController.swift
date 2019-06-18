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
        let appContainer = AppContainer()
		let featureContainer = FeatureContainer(container: appContainer)
		
		do {
			try appContainer.register(Storage.self) { _ in StorageAImpl() }
			try featureContainer.register(String.self) { _ in "Test je mofo" }
			try featureContainer.register(Storage.self, .singleton(scheduler: .background)) { container in StorageBImpl(string: try container.resolve()) }
			
			featureContainer.schedule(type: String.self, in: 10.seconds, repeating: 1.minute, queue: .main) { [weak self] title in
				let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
				self?.present(alert, animated: true, completion: nil)
			}
		} catch let e {
			dump(e.localizedDescription)
		}
        
        let storageImplementation = try? featureContainer.resolve(Storage.self)
        let storageList: [Storage] = featureContainer.resolveList()
        
        dump(storageImplementation)
        dump(storageList)
    }
}

