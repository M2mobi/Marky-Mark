//
//  MinimumHeightStylingRule.swift
//  Created by kris on 19.02.19.
//

import Foundation

public protocol MinimumHeightStylingRule: ItemStyling {
    
    var minimumHeight: CGFloat? { get }
}
