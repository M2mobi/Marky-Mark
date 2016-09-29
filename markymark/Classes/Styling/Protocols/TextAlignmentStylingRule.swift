//
//  Created by Jim van Zummeren on 25/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public enum TextAlignment {
    case left
    case right
    case center
}

public protocol TextAlignmentStylingRule: ItemStyling {
    var textAlignment : TextAlignment { get }
}

extension ItemStyling {

    func neededTextAlignment() -> TextAlignment? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? TextAlignmentStylingRule {
                return styling.textAlignment
            }
        }

        return nil
    }
}
