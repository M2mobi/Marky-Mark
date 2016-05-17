//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct StrikeThroughStyling: StrikeThroughStylingRule, TextColorStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is StrikeMarkDownItem
    }

    public var isStrikeThrough: Bool = true
    public var textColor: UIColor? = UIColor.redColor()
}