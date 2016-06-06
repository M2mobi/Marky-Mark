//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class InlineTextRule : InlineRule {

    //MARK: Rule

    public func recognizesLines(lines:[String]) -> Bool {
        /// Always return true since this is used as default rule
        return true
    }

    public func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let line = lines.first ?? ""

        return InlineTextMarkDownItem(lines: lines, content: line)
    }

    //MARK: InlineRule

    public func getAllMatches(lines:[String]) -> [NSRange] {
        return []
    }

}