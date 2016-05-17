//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol UnderlineStylingRule : ItemStyling {
    var isUnderlined : Bool { get }
}

extension ItemStyling {
    
    func shouldFontBeUnderlined() -> Bool {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? UnderlineStylingRule {
                return styling.isUnderlined
            }
        }
        
        return false
    }
}