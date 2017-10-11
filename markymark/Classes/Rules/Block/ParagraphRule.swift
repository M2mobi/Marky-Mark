//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class ParagraphRule: Rule {

    public init() {}

    //MARK: Rule

    open func recognizesLines(_ lines:[String]) -> Bool {
        return true
    }

    open  func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {
        return ParagraphMarkDownItem(lines:lines, content: lines.first ?? "")
    }
}
