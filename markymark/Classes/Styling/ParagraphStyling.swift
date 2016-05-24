//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct ParagraphStyling: ItemStyling, TextColorStylingRule, LineHeightStylingRule, BaseFontStylingRule, ContentInsetStylingRule, BoldStylingRule, ItalicStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is ParagraphMarkDownItem
    }

    public var baseFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
    public var textColor: UIColor? = UIColor.blackColor()

    public var contentInsets:UIEdgeInsets = UIEdgeInsets(top:0, left: 0, bottom: 10, right: 10)
    
    public var lineHeight:CGFloat? = 4
    
    public var isBold = false
    public var isItalic = false

    public init(){}

}