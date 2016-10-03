//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol BaseFontStylingRule : ItemStyling {

    var baseFont : UIFont? { get }
}

extension ItemStyling {

    func neededBaseFont() -> UIFont? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BaseFontStylingRule where styling.baseFont != nil {
                return styling.baseFont
            }
        }
        return nil
    }

    func neededFont() -> UIFont? {

        if var font = neededBaseFont() {

            if shouldFontBeBold() {

                font = font.makeBold()
            }

            if shouldFontBeItalic() {

                font = font.makeItalic()
            }

            if shouldFontBeBold() && shouldFontBeItalic() {
                font = font.makeItalicBold()
            }

            if let textSize = neededTextSize() {

                font = font.changeSize(textSize)
            }

            return font
        } else {
            
            return nil
        }
    }
}

private extension UIFont {

    func makeBold() -> UIFont {

        return UIFont.init(descriptor: self.fontDescriptor().fontDescriptorWithSymbolicTraits(.TraitBold)!, size: self.pointSize)
    }

    func makeItalic() -> UIFont {
        return UIFont.init(descriptor: self.fontDescriptor().fontDescriptorWithSymbolicTraits(.TraitItalic)!, size: self.pointSize)
    }

    func makeItalicBold() -> UIFont {
        return UIFont.init(descriptor: self.fontDescriptor().fontDescriptorWithSymbolicTraits([.TraitItalic, .TraitBold])!, size: self.pointSize)

    }

    func changeSize(size : CGFloat) -> UIFont {

        return UIFont.init(descriptor: self.fontDescriptor().fontDescriptorWithSize(size), size: size)
    }
}
