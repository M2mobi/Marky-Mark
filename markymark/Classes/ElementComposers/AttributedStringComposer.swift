//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class AttributedStringComposer: ElementComposer<NSMutableAttributedString> {
    
    override func compose(_ elements: [NSMutableAttributedString]) -> NSMutableAttributedString {

        let result = NSMutableAttributedString()
        for element in elements {
            result.append(element)

            if element != elements.last {
                result.append(NSAttributedString(string: "\n"))
            }
        }
        
        return result
    }
}
