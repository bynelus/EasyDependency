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
        appContainer.register { StorageAImpl() as Storage }
        
        let featureContainer = FeatureContainer(container: appContainer)
        let storageImplementation: Storage? = try? featureContainer.resolve(Storage.self)
    }
}

