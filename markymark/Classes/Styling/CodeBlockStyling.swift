//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public class CodeBlockStyling : ItemStyling, BackgroundStylingRule, TextColorStylingRule, ContentInsetStylingRule, BaseFontStylingRule {
    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is CodeBlockMarkDownItem
    }

    public var backgroundColor: UIColor? = UIColor.lightGrayColor().colorWithAlphaComponent(0.25)
    public var baseFont: UIFont? = UIFont.systemFontOfSize(UIFont.systemFontSize())
    public var textColor: UIColor? = .grayColor()

    public var contentInsets = UIEdgeInsets(top: 0, left:  20, bottom: 10, right: 10)

    public init(){}

}