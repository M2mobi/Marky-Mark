//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public class HeaderRule : RegExRule, HasLevel {

    /// Example: # Header 1
    public var expression = NSRegularExpression.expressionWithPattern("^(#{1,6}) (.*?)$")

    //MARK: Rule

    public func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let line = lines.first ?? ""
        let content = line.subStringWithExpression(expression, ofGroup: 2)
        let level = getLevel(line)

        return HeaderMarkDownItem(lines: lines, content: content ?? "", level: level)
    }

    //MARK: Private

    public func getLevel(string:String) -> Int {
        let range = expression.rangeInString(string, forGroup: 1)
        return range?.length ?? 0
    }
}