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

    public init(urlOpener: URLOpener? = nil, hasScalableFonts: Bool = false) {
        self.urlOpener = urlOpener
        self.hasScalableFonts = hasScalableFonts
    }
}
