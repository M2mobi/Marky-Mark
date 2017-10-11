//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class InlineTextRule : InlineRule {
    
    public init() {}

    //MARK: Rule

    open func recognizesLines(_ lines:[String]) -> Bool {
        /// Always return true since this is used as default rule
        return true
    }

    open func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        let line = lines.first ?? ""

        return InlineTextMarkDownItem(lines: lines, content: line)
    }

    //MARK: InlineRule

    open func getAllMatches(_ lines:[String]) -> [NSRange] {
        return []
    }

}
