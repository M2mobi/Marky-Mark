//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

struct StringAttributesBuilder {

    func attributesForStyling(styling : ItemStyling) -> [String : AnyObject] {

        var attributes = [String : AnyObject]()

        if let font = styling.neededFont() {

            attributes[NSFontAttributeName] = font
        }

        if styling.shouldBeStrikeThrough() {

            attributes[NSStrikethroughStyleAttributeName] = NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)
        }

        if let textColor = styling.neededTextColor() {

            attributes[NSForegroundColorAttributeName] = textColor
        }
        
        if styling.shouldFontBeUnderlined() {
            attributes[NSUnderlineStyleAttributeName] = NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)
        }
        
        if let backgroundColor = styling.neededBackgroundColor() {
            attributes[NSBackgroundColorAttributeName] = backgroundColor
        }
        
        let paragraphStyle = NSMutableParagraphStyle()

        if let lineHeight = styling.neededLineHeight() {
            paragraphStyle.lineSpacing = lineHeight
        }

        if let textAlignment = styling.neededTextAlignment() {
            let alignment:NSTextAlignment

            switch textAlignment{
                case .Left:
                alignment = .Left
                case .Right:
                alignment = .Right
                case .Center:
                alignment = .Center
            }

            paragraphStyle.alignment = alignment
        }

        attributes[NSParagraphStyleAttributeName] = paragraphStyle

        return attributes
    }
}