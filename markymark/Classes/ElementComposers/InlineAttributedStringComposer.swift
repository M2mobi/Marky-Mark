//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class InlineAttributedStringComposer: ElementComposer<NSMutableAttributedString> {

    override func compose(elements: [NSMutableAttributedString]) -> NSMutableAttributedString {

        let result = NSMutableAttributedString()

        for element in elements {

            result.appendAttributedString(element)
        }
        
        return result
    }
}