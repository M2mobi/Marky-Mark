//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

import UIKit

public struct InlineCodeStyling: ItemStyling, BoldStylingRule, TextColorStylingRule, ItalicStylingRule, BackgroundStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is InlineCodeMarkDownItem
    }

    public var textColor: UIColor? = .blackColor()
    public var backgroundColor: UIColor? = UIColor.lightGrayColor().colorWithAlphaComponent(0.25)
    public var isBold = false
    public var isItalic = true

    public init(){}

}