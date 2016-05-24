//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct HeadingStyling: ItemStyling, TextColorStylingRule, BaseFontStylingRule, ContentInsetStylingRule, BoldStylingRule, ItalicStylingRule, UnderlineStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is HeaderMarkDownItem
    }

    var level:Int = 0

    mutating func configureForLevel(level:Int) {
        self.level = level
    }

    public var fontsForLevels = [
        UIFont.systemFontOfSize(24),
        UIFont.systemFontOfSize(18),
        UIFont.boldSystemFontOfSize(16),
        UIFont.systemFontOfSize(15),
        UIFont.systemFontOfSize(14),
        UIFont.systemFontOfSize(13)

    ]

    public var baseFont: UIFont {
        return fontsForLevels.elementForLevel(level)
    }

    public var textColorsForLevels:[UIColor] = [
        .orangeColor(),
        .blackColor(),
        .grayColor()
    ]

    public var textColor: UIColor? {
        return textColorsForLevels.elementForLevel(level)
    }

    public var contentInsets:UIEdgeInsets = UIEdgeInsets(top:5, left: 0, bottom: 5, right: 10)
    
    public var isBold = false
    public var isItalic = false
    public var isUnderlined : Bool = false

    public init(){}

}

private extension Array {

    func elementForLevel(level:Int) -> Element {

        if level > self.count {
            return self[self.count - 1]
        }

        return self[level - 1]
    }
}