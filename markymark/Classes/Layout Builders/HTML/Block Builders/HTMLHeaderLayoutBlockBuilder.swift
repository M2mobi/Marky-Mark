//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class HTMLHeaderLayoutBlockBuilder: LayoutBlockBuilder<String> {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return HeaderMarkDownItem.self
    }

    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<String>, styling : ItemStyling) -> String {
        let headerMarkDownItem = markDownItem as! HeaderMarkDownItem
        let level = headerMarkDownItem.level

        return "<h\(level)>\(headerMarkDownItem.content)</h\(level)>"
    }
}