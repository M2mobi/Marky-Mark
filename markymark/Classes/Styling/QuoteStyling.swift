//
//  Created by Jim van Zummeren on 11/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public class QuoteStyling : ItemStyling, ContentInsetStylingRule, TextColorStylingRule, BaseFontStylingRule, ItalicStylingRule {
    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is QuoteMarkDownItem
    }

    public var baseFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
    public var textColor: UIColor? = UIColor.grayColor ()
    public var isItalic: Bool = true

    public var contentInsets = UIEdgeInsets(top: 0, left:  20, bottom: 0, right: 0)

    public init(){}

}