//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct ItalicStyling: ItemStyling, ItalicStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {

        return markDownItem is ItalicMarkDownItem
    }

    public var isItalic: Bool = true
}
