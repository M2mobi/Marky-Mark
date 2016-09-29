//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class StringComposer: ElementComposer<String> {

    override func compose(_ elements: [String]) -> String {

        var result = ""

        for element in elements {

            result += element
        }

        return result
    }
}
