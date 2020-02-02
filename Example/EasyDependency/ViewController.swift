//
//  ViewController.swift
//  EasyDependency
//
//  Created by NielsKoole on 10/29/2017.
//  Copyright (c) 2017 NielsKoole. All rights reserved.
//

import UIKit
import EasyDependency

class ViewController: UIViewController {
	
	@DIInject var someView: UIView
	@DIInjectList var views: [UIView]

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .green
		
        // Do any additional setup after loading the view, typically from a nib.
		do {
			let nonOptional: UIView = try DISharedContainer.resolve()
			let list: [UIView] = try DISharedContainer.resolve()
			let optional = try? (DISharedContainer.resolve() as UIView)
			let optional2 = try? (DISharedContainer.resolve() as Int)
			let nonOptional2: Int = try DISharedContainer.resolve()
			
			print(nonOptional)
			print(list)
			print(optional?.description)
			print(optional2?.description)
			print(nonOptional2)
			print(views)
			print(someView)
			
		} catch let e {
			print(e)
		}
    }
}

