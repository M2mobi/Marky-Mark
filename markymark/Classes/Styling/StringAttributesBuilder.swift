//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

struct StringAttributesBuilder {

    func attributesForStyling(_ styling : ItemStyling) -> [String : AnyObject] {

        var attributes = [String : AnyObject]()

        if let font = styling.neededFont() {

            attributes[NSFontAttributeName] = font
        }

        if styling.shouldBeStrikeThrough() {

            attributes[NSStrikethroughStyleAttributeName] = NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)
        }

        if let textColor = styling.neededTextColor() {

            attributes[NSForegroundColorAttributeName] = textColor
        }
        
        if styling.shouldFontBeUnderlined() {
            attributes[NSUnderlineStyleAttributeName] = NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)
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
                case .left:
                alignment = .left
                case .right:
                alignment = .right
                case .center:
                alignment = .center
            }

            paragraphStyle.alignment = alignment
        }

        attributes[NSParagraphStyleAttributeName] = paragraphStyle

        return attributes
    }
}
