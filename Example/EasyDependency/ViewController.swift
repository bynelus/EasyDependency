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

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view, typically from a nib.
		do {
			try DIContainer.shared.register(UIView.self) { _ in UILabel(frame: .zero) }
			try DIContainer.shared.register(UIView.self) { _ in UIButton(frame: .zero) }
			try DIContainer.shared.register(UIView.self) { _ in UISwitch(frame: .zero) }
			try DIContainer.shared.register(Int.self) { _ in 1234 }
		} catch let e {
			print(e.localizedDescription)
		}
		
		do {
			let nonOptional: UIView = try DIContainer.shared.resolve()
			let list: [UIView] = try DIContainer.shared.resolve()
			let optional: UIView? = DIContainer.shared.resolve(UIView.self)
			let optional2: Int? = DIContainer.shared.resolve(Int.self)
			let nonOptional2: Int = try DIContainer.shared.resolve()
			
			print(nonOptional)
			print(list)
			print(optional?.description)
			print(optional2?.description)
			print(nonOptional2)
			
		} catch let e {
			print(e)
		}
    }
}

