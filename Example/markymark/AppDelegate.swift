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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if #available(iOS 10.0, *) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            app.openURL(url)
        }
        return true
    }
}
