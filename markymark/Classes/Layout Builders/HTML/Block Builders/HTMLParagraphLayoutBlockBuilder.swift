//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class HTMLParagraphLayoutBlockBuilder: HTMLContainerLayoutBlockBuilder {

    // MARK: HTMLLayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ParagraphMarkDownItem.self
    }

    // MARK: HTMLContainerLayoutBlockBuilder

    override var htmlTag: String {
        return "p"
    }
}