//
//  ExtensionContextURLOpener.swift
//  markymark-iOS12.1
//
//  Created by Jim van Zummeren on 21/11/2018.
//

import Foundation

public class ExtensionContextURLOpener: URLOpener {

    private let extensionContext: NSExtensionContext?

    public init(extensionContext: NSExtensionContext?) {
        self.extensionContext = extensionContext
    }

    public func open(url: URL) {
        extensionContext?.open(url, completionHandler: nil)
    }
}
