//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class OrderedListRule : UnorderedListRule {

    init(){
        super.init(character: "-")
    }
    
    /// Example: 1. List item
    override var expression:NSRegularExpression {
        return NSRegularExpression.expressionWithPattern("^([  ]*)(\\d)\\. (.+?)$")
    }

    //MARK: Rule

    override func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let line = lines.first ?? ""
        let content = line.subStringWithExpression(expression, ofGroup: 3)
        let index = getIndex(line)
        return OrderedListMarkDownItem(lines: lines, content: content ?? "", index: index)
    }

    //MARK: Private

    func getIndex(string: String) -> Int {
        let stringIndex = string.subStringWithExpression(expression, ofGroup: 2)
        return Int(stringIndex) ?? 0
    }
}