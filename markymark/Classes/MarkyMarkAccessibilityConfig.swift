//
//  MarkyMarkAccessibilityConfig.swift
//  markymark
//
//  Created by Nihal on 17/02/2026.
//

public struct MarkyMarkAccessibilityConfig {

    public static var shared = MarkyMarkAccessibilityConfig()

    public var listItemAccessibilityLabelPostfix: ((_ itemIndex: Int, _ totalCount: Int) -> String)?
}