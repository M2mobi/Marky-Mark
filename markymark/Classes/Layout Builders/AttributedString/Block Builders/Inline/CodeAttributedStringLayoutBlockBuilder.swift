//
//  CodeAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/06/16.
//
//

import Foundation

class CodeAttributedStringLayoutBlockBuilder: InlineAttributedStringLayoutBlockBuilder {
    
    //MARK: LayoutBuilder
    
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return CodeBlockMarkDownItem.self
    }
    
    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: markDownItem.content)
        let attributes = StringAttributesBuilder().attributesForStyling(styling)
        attributedString.addAttributes(attributes, range: attributedString.fullRange())
        
        return attributedString
    }
}
