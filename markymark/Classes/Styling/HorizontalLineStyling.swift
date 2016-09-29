//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public struct HorizontalLineStyling: ItemStyling, LineWidthStylingRule, BackgroundStylingRule, ContentInsetStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {

        return markDownItem is HorizontalLineMarkDownItem
    }

    public var backgroundColor: UIColor? = UIColor.gray
    public var lineWidth: CGFloat = 0.5

    public var contentInsets = UIEdgeInsets(top:   5, left:  0, bottom: 5, right: 0)

    public init(){}

}
