//
//  InlineAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 11/06/16.
//
//

import Foundation
import UIKit

class InlineAttributedStringLayoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString> {

    private let converter: MarkDownConverter<NSMutableAttributedString>

    required init(converter: MarkDownConverter<NSMutableAttributedString>) {
        self.converter = converter
        super.init()
    }

    func attributedStringForMarkDownItem(
        _ markdownItem: MarkDownItem,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()

        if let markDownItems = markdownItem.markDownItems {
            let elements = converter.convertToElements(
                markDownItems,
                applicableStyling: styling,
                renderContext: renderContext
            )

            for subString in elements {
                string.append(subString)
            }
        }

        return string
    }

    func attributedStringWithContentInset(_ attributedString: NSMutableAttributedString, contentInset: UIEdgeInsets) -> NSMutableAttributedString {
        // Get existing paragraph style to append style to or create new style
        let paragraphStyle = getParagraphStyleAttribute(of: attributedString, exactlyAt: attributedString.fullRange()) ?? NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = contentInset.bottom
        paragraphStyle.paragraphSpacingBefore = contentInset.top
        paragraphStyle.firstLineHeadIndent = contentInset.left
        paragraphStyle.headIndent = contentInset.left

        attributedString.addAttributes([
            .paragraphStyle: paragraphStyle
        ], range: attributedString.fullRange())

        return attributedString
    }

    private func getParagraphStyleAttribute(of attributedString: NSAttributedString, exactlyAt range: NSRange) -> NSMutableParagraphStyle? {
        var paragraphStyles: [NSMutableParagraphStyle] = []

        attributedString.enumerateAttribute(.paragraphStyle, in: attributedString.fullRange(), options: []) {
            value, rangeOfValue, _ in
            if let paragraphStyle = value as? NSMutableParagraphStyle, rangeOfValue == range {
                paragraphStyles.append(paragraphStyle)
            }
        }

        return paragraphStyles.first
    }
}
