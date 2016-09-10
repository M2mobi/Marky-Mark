//
//  OrderedListAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 12/06/16.
//
//

import Foundation

class OrderedListAttributedStringLayoutBlockBuilder : ListAttributedStringLayoutBlockBuilder {
    
    //MARK: LayoutBuilder
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return OrderedListMarkDownItem.self
    }
}