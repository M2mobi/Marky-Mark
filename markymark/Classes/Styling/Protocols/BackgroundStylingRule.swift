//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol BackgroundStylingRule : ItemStyling {
    var backgroundColor : UIColor? { get }
}

extension ItemStyling {
    
    func neededBackgroundColor() -> UIColor? {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? BackgroundStylingRule, styling.backgroundColor != nil {
                return styling.backgroundColor
            }
        }
        
        return nil
    }
}
