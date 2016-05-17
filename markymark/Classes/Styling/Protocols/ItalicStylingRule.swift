//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol ItalicStylingRule : ItemStyling {
    
    var isItalic : Bool { get }
}

extension ItemStyling {

    func shouldFontBeItalic() -> Bool {
        for styling in stylingWithPrecedingStyling() {
            if let styling = styling as? ItalicStylingRule {
                return styling.isItalic
            }
        }

        return false
    }
}