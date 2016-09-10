//
//  AlphabeticListAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 10/09/16.
//
//

import Foundation

class AlphabeticListAttributedStringLayoutBlockBuilder : ListAttributedStringLayoutBlockBuilder {
    
    //MARK: LayoutBuilder
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return AlphabeticallyOrderedMarkDownItem.self
    }
}