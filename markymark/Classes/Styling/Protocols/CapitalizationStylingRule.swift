//
//  CapitalizationStylingRule.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

public enum Capitalization {
    case uppercased
    case lowercased
    case capitalized
}

public protocol CapitalizationStylingRule {
    var capitalization: Capitalization? { get }
}

extension ItemStyling {

    func neededCapitalization() -> Capitalization? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? CapitalizationStylingRule {
                return styling.capitalization
            }
        }

        return nil
    }
}
