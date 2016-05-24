//
// Created by Jim van Zummeren on 02/05/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class ListMarkDownItem : MarkDownItem, HasListItems, HasIndex {
    var listItems:[ListMarkDownItem]?

    let index:Int?

    required init(lines: [String], content: String, index:Int? = nil) {
        self.index = index;
        super.init(lines: lines, content: content)
    }

    var indexCharacter:String? {
        return index != nil ? "\(index)" : nil
    }
    
    public required init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}