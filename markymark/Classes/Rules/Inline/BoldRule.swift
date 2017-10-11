//
// Created by Jim van Zummeren on 29/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class BoldRule: InlineRegexRule {
    
    public init() {}

    open var expression = NSRegularExpression.expressionWithPattern("(\\*{2}|\\_{2})(.+?)(\\*{2}|\\_{2})(?!\\*|\\_)")
    
    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return BoldMarkDownItem(lines: lines, content: content ?? "")
    }
}
