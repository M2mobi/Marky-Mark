//
//  Created by Edwin on 05/01/2021.
//  Copyright © 2021 M2mobi. All rights reserved.
//

import Foundation

open class TitledLinkRule: InlineRegexRule {

    public init() {}

    /// Example: [Google](http://www.google.com "with custom title")
    open var expression = NSRegularExpression.expressionWithPattern(
        //             [  title  ] (    URL   "     optional title    "   )
        #"(?<!!\p{Z}?)\[{1}(.+?)\]\({1}(.+?)( "[[:alnum:][:space:]^"]+")?\)"#
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
