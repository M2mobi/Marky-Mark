//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class LinkRule: InlineRegexRule {

    public init() {}

    /// Example: [Google](http://www.google.com "with custom title")
    open var expression = NSRegularExpression.expressionWithPattern(
        //             [  title  ] (    URL   "     optional title    "   )
        #"(?<!!\p{Z}?)\[{1}(.+?)\]\({1}(.+?)( "[[:print:]^"]+")?\)"#
    )

    // MARK: Rule

    open func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        let url: String? = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        let content: String? = lines.first?.subStringWithExpression(expression, ofGroup: 1)

        return LinkMarkDownItem(
            lines: lines,
            content: content ?? "",
            url: url ?? ""
        )
    }
}
