//
// Created by Jim van Zummeren on 29/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class StrikeRule : InlineRegexRule {
    
    /// Example: ~~text~~
    var pattern = "\\~{2}(.+?)\\~{2}"

    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 1)
        return StrikeMarkDownItem(lines: lines, content: content ?? "")
    }
}
