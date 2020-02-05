//
//  DefaultURLOpener.swift
//  markymark-iOS12.1
//
//  Created by Jim van Zummeren on 21/11/2018.
//

import Foundation
import UIKit

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
        guard let sharedApplication = sharedApplication else { return }
        
        if #available(iOS 10, *) {
            _ = sharedApplication.delegate?.application?(sharedApplication, open: url, options: [:])
        } else {
            _ = sharedApplication.delegate?.application?(sharedApplication, handleOpen: url)
        }
    }
}
