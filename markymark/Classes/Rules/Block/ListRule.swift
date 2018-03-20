//
//  Created by Jim van Zummeren on 30/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class ListRule: Rule, HasLevel {

    var numberOfListItems = 0;

    var expression:NSRegularExpression
    let listTypes:[ListType]
    let defaultListType = UnOrderedListType()

    public init(listTypes:[ListType]){
        self.listTypes = listTypes + [defaultListType]
        
        let pattern:String = self.listTypes.map({
            return $0.pattern
        }).joined(separator: "|")

        expression = NSRegularExpression.expressionWithPattern("^([  ]*)(\(pattern)) (.+?)$")
    }

    //MARK: Rule
    
    open func recognizesLines(_ lines:[String]) -> Bool {
        numberOfListItems = 0

        while(lines.count > numberOfListItems) {

            let line = lines[numberOfListItems]

            if !expression.hasMatchesInString(line) {
                break;
            }

            numberOfListItems += 1
        }

        return numberOfListItems > 0
    }

    open func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 3) ?? ""
        let stringIndex = lines.first?.subStringWithExpression(expression, ofGroup: 2) ?? ""

        for listType in listTypes {
            if let index = listType.getIndex(stringIndex) {
                return listType.relatedListMarkDownType.init(lines: lines, content: content, level: getLevel(lines[0]), index: index)
            }
        }

        return defaultListType.relatedListMarkDownType.init(lines: lines, content: content, level: getLevel(lines[0]), index: nil)

    }

    open func linesConsumed() -> Int {
        return numberOfListItems
    }

    //MARK: List Rule

    func getLevel(_ line:String) -> Int {
        let numberOfSpaces = expression.rangeInString(line, forGroup: 1)?.length ?? 0
        return numberOfSpaces / 2
    }


    //MARK: Private
}
