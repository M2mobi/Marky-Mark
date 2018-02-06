//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

open class HeaderRule: RegExRule, HasLevel {
    
    public init() {}

    /// Example: # Header 1
    open var expression = NSRegularExpression.expressionWithPattern("^(#{1,6}) (.*?)$")

    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        let line = lines.first ?? ""
        let content = line.subStringWithExpression(expression, ofGroup: 2)
        let level = getLevel(line)

        return HeaderMarkDownItem(lines: lines, content: content, level: level)
    }

    //MARK: Private

    open func getLevel(_ string: String) -> Int {
        let range = expression.rangeInString(string, forGroup: 1)
        return range?.length ?? 0
    }
}
