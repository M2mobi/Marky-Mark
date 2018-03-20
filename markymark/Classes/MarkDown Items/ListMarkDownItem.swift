//
// Created by Jim van Zummeren on 02/05/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class ListMarkDownItem: MarkDownItem, HasListItems, HasIndex {
    var listItems: [ListMarkDownItem]?

    let level: Int
    let index: Int?

    required public init(lines: [String], content: String, level: Int, index: Int? = nil) {
        self.level = level
        self.index = index
        super.init(lines: lines, content: content)
    }

    var indexCharacter: String? {
        guard let index = index else { return nil }
        return "\(index)"
    }
    
    public required init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}
