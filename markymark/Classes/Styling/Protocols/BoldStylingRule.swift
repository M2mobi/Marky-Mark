//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol BoldStylingRule : ItemStyling {
    var isBold : Bool { get }
}

extension ItemStyling {

    func shouldFontBeBold() -> Bool {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BoldStylingRule {
                return styling.isBold
            }
        }

        return false
    }
}