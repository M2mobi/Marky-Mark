//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct BoldStyling: ItemStyling, BoldStylingRule, BaseFontStylingRule {

    public var parent : ItemStyling? = nil

    public func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {

        return markDownItem is BoldMarkDownItem
    }
    
    public var isBold = true
    public var baseFont : UIFont? = nil

    public init(){}
}
