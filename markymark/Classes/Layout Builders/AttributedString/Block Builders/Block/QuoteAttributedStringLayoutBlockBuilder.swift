//
//  QuoteAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/06/16.
//
//

import Foundation
import UIKit

class QuoteAttributedStringLayoutBlockBuilder: InlineAttributedStringLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return QuoteMarkDownItem.self
    }

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<NSMutableAttributedString>,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> NSMutableAttributedString {
        let paragraphStyling = styling as? QuoteStyling
        let attributedString = attributedStringForMarkDownItem(
            markDownItem,
            styling: styling,
            renderContext: renderContext
        )

        return attributedStringWithContentInset(attributedString, contentInset: paragraphStyling?.contentInsets ?? UIEdgeInsets())
    }
}
