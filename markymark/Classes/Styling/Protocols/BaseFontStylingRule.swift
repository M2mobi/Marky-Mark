//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol BaseFontStylingRule: ItemStyling {

    var baseFont: UIFont? { get }
    var textStyle: UIFont.TextStyle? { get }
    var maximumPointSize: CGFloat? { get }
}

public extension BaseFontStylingRule {

    var textStyle: UIFont.TextStyle? {
        nil
    }

    var maximumPointSize: CGFloat? {
        nil
    }
}

extension ItemStyling {

    func neededBaseFont() -> UIFont? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BaseFontStylingRule, styling.baseFont != nil {
                return styling.baseFont
            }
        }
        return nil
    }

    func neededTextStyle() -> UIFont.TextStyle? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BaseFontStylingRule, styling.textStyle != nil {
                return styling.textStyle
            }
        }
        return nil
    }

    func neededMaximumPointSize() -> CGFloat? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BaseFontStylingRule, styling.maximumPointSize != nil {
                return styling.maximumPointSize
            }
        }
        return nil
    }

    func neededFont(hasScalableFonts: Bool) -> UIFont? {
        var font: UIFont? = neededBaseFont()

        if shouldFontBeBold() && shouldFontBeItalic() {
            font = font?.makeItalicBold()
        } else if shouldFontBeBold() {
            font = font?.makeBold()
        } else if shouldFontBeItalic() {
            font = font?.makeItalic()
        }

        if let textSize = neededTextSize() {
            font = font?.changeSize(textSize)
        }

        if let textStyle = neededTextStyle(), hasScalableFonts {
            return font?.scaledFont(
                textStyle: textStyle,
                maximumPointSize: neededMaximumPointSize()
            )
        } else {
            return font
        }
    }
}

private extension UIFont {

    func makeBold() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) {
            return UIFont(descriptor: descriptor, size: pointSize)
        }

        return nil
    }

    func makeItalic() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic) {
            return UIFont(descriptor: descriptor, size: pointSize)
        }

        return nil
    }

    func makeItalicBold() -> UIFont? {
        if let descriptor = fontDescriptor.withSymbolicTraits([.traitItalic, .traitBold]) {
            return UIFont(descriptor: descriptor, size: pointSize)
        }

        return nil
    }

    func changeSize(_ size: CGFloat) -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSize(size), size: size)
    }
}
