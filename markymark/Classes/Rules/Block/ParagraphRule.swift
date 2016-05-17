//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class ParagraphRule : Rule {

    //MARK: Rule

    func recognizesLines(lines:[String]) -> Bool {
        return true
    }

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        return ParagraphMarkDownItem(lines:lines, content: lines.first ?? "")
    }
}
