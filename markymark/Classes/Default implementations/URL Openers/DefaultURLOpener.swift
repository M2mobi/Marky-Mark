//
//  DefaultURLOpener.swift
//  markymark-iOS12.1
//
//  Created by Jim van Zummeren on 21/11/2018.
//

import Foundation

public class DefaultURLOpener: URLOpener {

    private var sharedApplication: UIApplication? {
        let sharedSelector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: sharedSelector) else {
            assertionFailure("[Extensions cannot access Application]")
            return nil
        }

        let shared = UIApplication.perform(sharedSelector)
        return shared?.takeUnretainedValue() as? UIApplication
    }

    public func open(url: URL) {
        _ = sharedApplication?.openURL(url)
    }
}
