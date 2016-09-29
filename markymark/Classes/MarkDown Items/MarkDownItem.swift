//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class MarkDownItem {

    var lines:[String]
    var markDownItems:[MarkDownItem]?

    open var content:String

    public required init(lines:[String], content:String) {
        self.content = content
        self.lines = lines
    }

    func allowsChildMarkDownItems() -> Bool {
        return true
    }
}
