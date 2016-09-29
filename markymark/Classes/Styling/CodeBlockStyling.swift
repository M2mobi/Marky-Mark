//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

open class CodeBlockStyling : ItemStyling, BackgroundStylingRule, TextColorStylingRule, ContentInsetStylingRule, BaseFontStylingRule {
    open var parent : ItemStyling? = nil

    open func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {

        return markDownItem is CodeBlockMarkDownItem
    }

    open var backgroundColor: UIColor? = UIColor.lightGray.withAlphaComponent(0.25)
    open var baseFont: UIFont? = .systemFont(ofSize: UIFont.systemFontSize)
    open var textColor: UIColor? = .gray

    open var contentInsets = UIEdgeInsets(top: 0, left:  20, bottom: 10, right: 10)

    public init(){}

}
