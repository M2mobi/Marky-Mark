//
//  AccessibilityConfig.swift
//  markymark
//
//  Created by Nihal on 24/02/2026.
//

public struct AccessibilityConfig {

    public var listItemAccessibilityLabelPostfix: ((_ itemIndex: Int, _ totalCount: Int) -> String)?

    public init(listItemAccessibilityLabelPostfix: ((_ itemIndex: Int, _ totalCount: Int) -> String)? = nil) {
        self.listItemAccessibilityLabelPostfix = listItemAccessibilityLabelPostfix
    }
}
