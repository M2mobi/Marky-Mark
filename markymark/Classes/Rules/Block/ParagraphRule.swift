//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public class ParagraphRule : Rule {

    //MARK: Rule

    public func recognizesLines(lines:[String]) -> Bool {
        return true
    }

    public  func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        return ParagraphMarkDownItem(lines:lines, content: lines.first ?? "")
    }
}
