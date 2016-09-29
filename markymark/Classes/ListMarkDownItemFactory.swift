//
//  Created by Jim van Zummeren on 30/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class ListMarkDownItemFactory {

    /**
     Recursive method for generating list items.

     - parameter lines: Lines to create list from
     - parameter rules: Rules to check list syntax with
     - parameter level: List identation level

     - returns: ListMarkDownItem containing listItems that may contain more ListMarkDownItem's
     */
    func getListItemForLines(_ lines:[String], rule:ListRule, level:Int = 0) -> [ListMarkDownItem]{
        var lines = lines
        var listMarkDownItems:[ListMarkDownItem] = []

        while(lines.count > 0) {

            let numberOfLines = numberOfLinesOnLevel(level, rule:rule, lines:lines) //-> This doesn't seem right, needs to check for any list rule..

            let range = 0..<numberOfLines
            var linesForListItem = Array(lines[range])
            lines.removeSubrange(range)

            let listMarkDownItem = rule.createMarkDownItemWithLines(linesForListItem)
            linesForListItem.removeFirst()

            if let listMarkDownItem = listMarkDownItem  as? ListMarkDownItem {
                
                listMarkDownItem.listItems = getListItemForLines(linesForListItem, rule: rule, level: level + 1)
                listMarkDownItems.append(listMarkDownItem)
            }
        }
        
        return listMarkDownItems
    }

    /**
     Retrieves the number of lines one list item contains, including it's child list elements
     
     For Example:
     - List item
       - Nested list Item
       - Nested list Item
            - Nested list Item
     - List item
     
     Would return 4 lines, because the first list item contains 4 lines including it's children

     - parameter level: Level to consider as root level to check from
     - parameter rules: All list rules to compare with
     - parameter lines: Lines to check

     - returns: Number of lines on the given leven
     */

    func numberOfLinesOnLevel(_ level:Int, rule:ListRule, lines:[String]) -> Int {
        var i = 0

        for line in lines {

            if rule.getLevel(line) == level && i != 0 {
                break
            }

            i += 1
        }

        return i
    }

}
