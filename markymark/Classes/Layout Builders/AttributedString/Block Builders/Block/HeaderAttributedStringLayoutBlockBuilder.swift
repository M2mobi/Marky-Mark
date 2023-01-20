//
//  HeaderAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 11/06/16.
//
//

import Foundation
import UIKit

class HeaderAttributedStringLayoutBlockBuilder: InlineAttributedStringLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return HeaderMarkDownItem.self
    }

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<NSMutableAttributedString>,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> NSMutableAttributedString {
        let headerMarkDownItem = markDownItem as! HeaderMarkDownItem
        let headerStyling = styling as? HeadingStyling
        headerStyling?.configureForLevel(headerMarkDownItem.level)

        let attributedString = attributedStringForMarkDownItem(
            markDownItem,
            styling: headerStyling ?? styling,
            renderContext: renderContext
        )

        return attributedStringWithContentInset(attributedString, contentInset: headerStyling?.contentInsets ?? UIEdgeInsets())
    }
}
