//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol Rule {

    /**
     Checks if the top line(s) passed are conforming to the expected format for this rule

     - parameter lines: Array of Markdown Strings

     - returns: Whether the lines conform to the expected format
     */

    func recognizesLines(_ lines:[String]) -> Bool

    /**
     Converts recognized lines to a Markdown Item

     - parameter lines: Array of Markdown Strings

     - returns: Markdown item for given lines
     */

    func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem

    /**
     The number of lines of Markdown this rule requires
     In most cases this will be one line

     - returns: Number of lines needed for this rule
     */

    func linesConsumed() -> Int
}

extension Rule {

    /**
        Set default number of lines consumed to 1
     */

    public func linesConsumed() -> Int {
        return 1
    }
}
