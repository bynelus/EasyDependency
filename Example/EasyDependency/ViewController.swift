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
        appContainer.register(Storage.self) { _ in StorageAImpl() }
        
        let featureContainer = FeatureContainer(container: appContainer)
        featureContainer.register(String.self) { _ in "Test" }
        featureContainer.register(Storage.self) { container in StorageBImpl(string: try container.resolve()) }
        
        let storageImplementation: Storage? = try? featureContainer.resolve()
        let storageList: [Storage] = featureContainer.resolveList()
        
        dump(storageImplementation)
        dump(storageList)
    }
}

