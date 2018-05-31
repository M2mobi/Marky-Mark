//
//  LetterSpacingStylingRule.swift
//  markymark
//
//  Created by Jim van Zummeren on 31/05/2018.
//

import Foundation

public protocol LetterSpacingStylingRule: ItemStyling {
    var letterSpacing : CGFloat? { get }
}

extension ItemStyling {

    func neededLetterSpacing() -> CGFloat? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? LetterSpacingStylingRule {
                return styling.letterSpacing
            }
        }

        return nil
    }
}
