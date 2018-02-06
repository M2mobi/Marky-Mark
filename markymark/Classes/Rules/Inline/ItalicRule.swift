//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class ItalicRule: InlineRegexRule {
    
    public init() {}

    /// Example: *text* or _text_
    open var expression = NSRegularExpression.expressionWithPattern("(?<!\\_|\\*)(\\_{1}|\\*{1})(?!\\_|\\*)(.+?)(?<!\\_|\\*)(\\_{1}|\\*{1})(?!\\_|\\*)")

    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return ItalicMarkDownItem(lines: lines, content: content ?? "")
    }

}
