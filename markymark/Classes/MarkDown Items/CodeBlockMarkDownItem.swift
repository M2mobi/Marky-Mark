//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class CodeBlockMarkDownItem: MarkDownItem {

    override open func allowsChildMarkDownItems() -> Bool {
        return false
    }
}
