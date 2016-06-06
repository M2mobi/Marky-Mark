//
// Created by Jim van Zummeren on 29/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public class BoldRule : InlineRegexRule {

    public var expression = NSRegularExpression.expressionWithPattern("(\\*{2}|\\_{2})(.+?)(\\*{2}|\\_{2})(?!\\*|\\_)")
    
    //MARK: Rule

    public func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return BoldMarkDownItem(lines: lines, content: content ?? "")
    }
}