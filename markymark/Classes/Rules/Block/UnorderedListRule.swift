//
//  Created by Jim van Zummeren on 30/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class UnorderedListRule: ListRule {
    
    var numberOfListItems = 0;

    var pattern:String

    var expression:NSRegularExpression {
        return NSRegularExpression.expressionWithPattern(pattern)
    }

    
    init(character:String) {
        /// Example: - List item
        pattern = "^([  ]*)(\\\(character)) (.+?)$"
    }
    
    //MARK: Rule
    
    func recognizesLines(lines:[String]) -> Bool {
        numberOfListItems = 0

        while(lines.count > numberOfListItems) {

            let line = lines[numberOfListItems]

            if !expression.hasMatchesInString(line) {
                break
            }

            numberOfListItems += 1
        }

        return numberOfListItems > 0
    }

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 3)
        return UnorderedListMarkDownItem(lines: lines, content: content ?? "")
    }

    func linesConsumed() -> Int {
        return numberOfListItems
    }

    //MARK: List Rule

    func getLevel(line:String) -> Int {
        let numberOfSpaces = expression.rangeInString(line, forGroup: 1)?.length ?? 0
        return numberOfSpaces / 2
    }
}