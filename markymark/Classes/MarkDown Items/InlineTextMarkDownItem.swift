//
//  Created by Jim van Zummeren on 29/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class InlineTextMarkDownItem : MarkDownItem {

    override func allowsChildMarkDownItems() -> Bool {
        return false
    }
}
