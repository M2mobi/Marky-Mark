//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class AlphabeticallyOrderedListRule : UnorderedListRule {

    let indexCharacters:NSString = "abcdefghijklmnopqrstuvwxyz"

    init(){
        super.init(character: "-")
    }
    
    //MARK: UnorderedListRule

    /// Example: a. List item

    override var expression:NSRegularExpression {
        return NSRegularExpression.expressionWithPattern("^([  ]*)([a-zA-Z])\\. (.+?)$")
    }

    override func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let line = lines.first ?? ""
        let content = line.subStringWithExpression(expression, ofGroup: 3)
        let index = getIndex(line)
        return AlphabeticallyOrderedMarkDownItem(lines: lines, content: content ?? "", index: index)
    }
    
    //MARK: Private
    
    func getIndex(string: String) -> Int {
        let stringIndex = string.subStringWithExpression(expression, ofGroup: 2).lowercaseString
        let index = indexCharacters.rangeOfString(stringIndex).location

        return index ?? 0
    }
}
