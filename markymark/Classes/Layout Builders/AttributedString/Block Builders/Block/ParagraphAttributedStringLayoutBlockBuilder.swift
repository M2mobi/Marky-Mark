//
//  ParagraphAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 11/06/16.
//
//

import Foundation

class ParagraphAttributedStringLayoutBlockBuilder: InlineAttributedStringLayoutBlockBuilder {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ParagraphMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
        let paragraphStyling = styling as? ParagraphStyling
        let attributedString = attributedStringForMarkDownItem(markDownItem, styling: styling)
        
        return attributedStringWithContentInset(attributedString, contentInset: paragraphStyling?.contentInsets ?? UIEdgeInsets())
    }
}
