//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol StrikeThroughStylingRule : ItemStyling {

    var isStrikeThrough : Bool { get }
}

extension StrikeThroughStylingRule {
    var isStrikeThrough:Bool {
        return true
    }
}

extension ItemStyling {

    func shouldBeStrikeThrough() -> Bool {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? StrikeThroughStylingRule {
                return styling.isStrikeThrough
            }
        }

        return false
    }
}