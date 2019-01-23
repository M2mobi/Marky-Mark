//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct StrikeThroughStyling: StrikeThroughStylingRule, TextColorStylingRule, BaseFontStylingRule {

    public var parent: ItemStyling?

    public func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {

        return markDownItem is StrikeMarkDownItem
    }

    public var isStrikeThrough: Bool = true
    public var baseFont: UIFont?

    public var textColor: UIColor?

    public init() {}

}
