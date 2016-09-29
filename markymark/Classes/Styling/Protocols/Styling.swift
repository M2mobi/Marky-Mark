//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol Styling {

    var itemStylingRules: [ItemStyling] { get }
}

extension Styling {

    func stylingForMarkownItem(_ item : MarkDownItem) -> ItemStyling {
        for styling in itemStylingRules {
            if styling.isApplicableOn(item) {
                return styling
            }
        }

        return EmptyItemStyling()
    }

    public var itemStylingRules: [ItemStyling] {
        return collectStylingRules()
    }

    /// Collects all ItemStyling properties of the instance by using reflection

    public func collectStylingRules() -> [ItemStyling] {
        return Mirror(reflecting: self).children.flatMap { $0.value as? ItemStyling }
    }
}

struct EmptyItemStyling: ItemStyling {

    var parent: ItemStyling? = nil

    func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {
        return true
    }
}
