//
// Created by Jim van Zummeren on 29/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class BoldRule : InlineRegexRule {

    var pattern:String
    
    init() {
        /// Example: **text** or __text__
        pattern = "(\\*{2}|\\_{2})(.+?)(\\*{2}|\\_{2})(?!\\*|\\_)"
    }
    
    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return BoldMarkDownItem(lines: lines, content: content ?? "")
    }

    func getAllMatches(lines:[String]) -> [NSRange] {
        guard let line = lines.first else { return [] }

        return expression.rangesForString(line)
    }
}