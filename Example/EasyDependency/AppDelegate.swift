//
//  AppDelegate.swift
//  EasyDependency
//
//  Created by NielsKoole on 10/29/2017.
//  Copyright (c) 2017 NielsKoole. All rights reserved.
//

import UIKit
import EasyDependency

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		DISharedContainer.logging = true
		try! DISharedContainer.register(UIView.self) { _ in UILabel(frame: .zero) }
		try! DISharedContainer.register(UIView.self) { _ in UIButton(frame: .zero) }
		try! DISharedContainer.register(UIView.self) { _ in UISwitch(frame: .zero) }
		try! DISharedContainer.register(Int.self) { _ in 1234 }
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = ViewController()
		window.makeKeyAndVisible()
		self.window = window
		
		return true
    }
}

