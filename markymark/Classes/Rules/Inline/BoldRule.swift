//
// Created by Jim van Zummeren on 29/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class BoldRule : InlineRegexRule {

    var pattern:String
    
    init(character:String) {
        /// Example: **text**
        pattern = "(\\\(character){2})(.+?)(\\\(character){2})(?!\\\(character))"
    }
    
    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return BoldMarkDownItem(lines: lines, content: content ?? "")
    }    
}