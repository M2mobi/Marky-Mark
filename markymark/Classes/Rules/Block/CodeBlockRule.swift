        //
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class CodeBlockRule: Rule  {

    public init() {}

    var numberOfLines:Int = 0

    /// Example: ```Code block```

    var expressionStart = NSRegularExpression.expressionWithPattern("^\\`{3}")
    var expressionEndFirstLine = NSRegularExpression.expressionWithPattern("(?<!^)(\\`{3})$")
    var expressionEnd = NSRegularExpression.expressionWithPattern("(\\`{3})$")

    open func recognizesLines(_ lines:[String]) -> Bool {
        if !expressionStart.hasMatchesInString(lines.first) {
            return false
        }

        numberOfLines = 0

        for line in lines {
            numberOfLines += 1

            if numberOfLines == 1 {
                if expressionEndFirstLine.hasMatchesInString(line) {
                    return true
                }
            } else {
                if expressionEnd.hasMatchesInString(line){
                    return true
                }
            }
        }

        return false
    }

    open func linesConsumed() -> Int {
        return numberOfLines
    }

    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        var content = lines.joined(separator: "\n")

        content = content.replacingOccurrences(of: "\n```", with: "")
        content = content.replacingOccurrences(of: "```\n", with: "")
        content = content.replacingOccurrences(of: "```", with: "")

        return CodeBlockMarkDownItem(lines: lines, content: content)
    }
}
