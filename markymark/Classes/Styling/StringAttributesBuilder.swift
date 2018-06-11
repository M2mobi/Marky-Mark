//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

struct StringAttributesBuilder {

    func attributesForStyling(_ styling : ItemStyling) -> [NSAttributedStringKey : Any] {

        var attributes = [NSAttributedStringKey : Any]()

        if let font = styling.neededFont() {

            attributes[.font] = font
        }

        if styling.shouldBeStrikeThrough() {

            attributes[.strikethroughStyle] = NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)
        }

        if let textColor = styling.neededTextColor() {

            attributes[.foregroundColor] = textColor
        }
        
        if styling.shouldFontBeUnderlined() {
            attributes[.underlineStyle] = NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)
        }
        
        if let backgroundColor = styling.neededBackgroundColor() {
            attributes[.backgroundColor] = backgroundColor
        }
        
        let paragraphStyle = NSMutableParagraphStyle()

        if let lineHeight = styling.neededLineHeight() {
            paragraphStyle.lineSpacing = lineHeight
        }

        if let textAlignment = styling.neededTextAlignment() {
            let alignment:NSTextAlignment

            switch textAlignment{
                case .left:
                alignment = .left
                case .right:
                alignment = .right
                case .center:
                alignment = .center
            }

            paragraphStyle.alignment = alignment
        }

        attributes[.paragraphStyle] = paragraphStyle

        if let letterSpacing = styling.neededLetterSpacing() {
            attributes[.kern] = letterSpacing
        }

        return attributes
    }
}
