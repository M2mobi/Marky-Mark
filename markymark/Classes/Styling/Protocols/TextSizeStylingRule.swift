//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol TextSizeStylingRule : ItemStyling {

    var textSize : CGFloat { get }
}

extension ItemStyling {

    func neededTextSize() -> CGFloat? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? TextSizeStylingRule {
                return styling.textSize
            }
        }

        return nil
    }
}