//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public protocol TextColorStylingRule: ItemStyling {

    var textColor : UIColor? { get }
}

extension ItemStyling {

    func neededTextColor() -> UIColor? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? TextColorStylingRule, styling.textColor != nil {
                return styling.textColor
            }
        }

        return nil
    }
}
