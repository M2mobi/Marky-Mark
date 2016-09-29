//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol LineHeightStylingRule : ItemStyling {

    /// Spacing between lines
    var lineHeight : CGFloat? { get }
}

extension ItemStyling {
    
    func neededLineHeight() -> CGFloat? {
        
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? LineHeightStylingRule, styling.lineHeight != nil {
                return styling.lineHeight
            }
        }
        
        return nil
    }
}
