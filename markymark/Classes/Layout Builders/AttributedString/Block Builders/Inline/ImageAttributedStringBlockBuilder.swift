//
//  ImageAttributedStringBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/06/16.
//
//

import Foundation

class ImageAttributedStringBlockBuilder : InlineImageAttributedStringBlockBuilder {
    
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ImageBlockMarkDownItem.self
    }
}