//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public class HeadingStyling: ItemStyling, TextColorStylingRule, BaseFontStylingRule, ContentInsetStylingRule, BoldStylingRule, ItalicStylingRule, UnderlineStylingRule, TextAlignmentStylingRule, CapitalizationStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {
        return markDownItem is HeaderMarkDownItem
    }

    var level:Int = 0

    func configureForLevel(_ level:Int) {
        self.level = level
    }

    public var fontsForLevels = [
        UIFont.systemFont(ofSize: 24),
        UIFont.systemFont(ofSize: 18),
        UIFont.boldSystemFont(ofSize: 16),
        UIFont.systemFont(ofSize: 15),
        UIFont.systemFont(ofSize: 14),
        UIFont.systemFont(ofSize: 13)
    ]

    public var baseFont: UIFont? {
        return fontsForLevels.elementForLevel(level)
    }

    public var textColorsForLevels:[UIColor] = [
        .black
    ]

    public var textColor: UIColor? {
        return textColorsForLevels.elementForLevel(level)
    }

    public var contentInsetsForLevels: [UIEdgeInsets] = [
        UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 10)
    ]

    public var contentInsets: UIEdgeInsets {
        return contentInsetsForLevels.elementForLevel(level) ?? UIEdgeInsets()
    }
    
    public var isBold = false
    public var isItalic = false
    public var isUnderlined : Bool = false

    public var textAlignment:TextAlignment = .left

    public var capitalizationForLevels: [Capitalization?] = []

    public var capitalization: Capitalization? {
        return capitalizationForLevels.elementForLevel(level) ?? nil
    }

    public init(){}
}

private extension Array {

    func elementForLevel(_ level:Int) -> Element? {
        if level <= 0 {
            return self[0]
        }

        if level > count {
            return last
        }

        return self[level - 1]
    }
}
