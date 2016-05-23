//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class ItalicRule: InlineRegexRule {

    /// Example: *text* or _text_
    var expression = NSRegularExpression.expressionWithPattern("(?<!\\_|\\*)(\\_{1}|\\*{1})(?!\\_|\\*)(.+?)(?<!\\_|\\*)(\\_{1}|\\*{1})(?!\\_|\\*)")

    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return ItalicMarkDownItem(lines: lines, content: content ?? "")
    }

}
