//
//  AppDelegate.swift
//  markymark
//
//  Created by Menno Lovink on 05/17/2016.
//  Copyright (c) 2016 Menno Lovink. All rights reserved.
//

import UIKit
import markymark

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return true }

        window.backgroundColor = .white
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()

        return true
    }
}
