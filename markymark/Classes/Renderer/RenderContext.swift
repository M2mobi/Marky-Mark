//
//  RenderContext.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/01/2023.
//

import Foundation

public struct RenderContext {

    public var urlOpener: URLOpener?
    public var hasScalableFonts: Bool
    public var accessibilityConfig: AccessibilityConfig?

    public init(
        urlOpener: URLOpener? = nil,
        hasScalableFonts: Bool = false,
        accessibilityConfig: AccessibilityConfig? = nil
    ) {
        self.urlOpener = urlOpener
        self.hasScalableFonts = hasScalableFonts
        self.accessibilityConfig = accessibilityConfig
    }
}
