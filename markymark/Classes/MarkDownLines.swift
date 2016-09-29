//
// Created by Jim van Zummeren on 23/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class MarkDownLines {

    /// Array of Markdown lines
    var lines:[String]

    init(_ markDown:String) {
        self.lines = markDown.components(separatedBy: "\n")
    }

    /**
     Makes the list of Markdown shorter
     Used by the Parser to remove lines that have already been matched

     - parameter rule: Rule that recognized the markdown lines
     */
    func removeLinesForMarkDownItem(_ markDownItem:MarkDownItem) {
        for _ in 0 ..< markDownItem.lines.count {
            lines.removeFirst()
        }
    }

    /**
     Total amount of lines

     - returns: number of lines
     */

    func numberOfLines() -> Int {
        return lines.count
    }

    /**
     Checks if the list is empty

     - returns: Bool to indicate if the list is empty
     */

    func isEmpty() -> Bool {
        return lines.count == 0
    }
}
