//
//  InlineAttributedStringLayoutBlockBuilder.swift
//  Pods
//
//  Created by Jim van Zummeren on 11/06/16.
//
//

import Foundation

class InlineAttributedStringLayoutBlockBuilder : LayoutBlockBuilder<NSMutableAttributedString> {
    
    fileprivate let converter : MarkDownConverter<NSMutableAttributedString>
    
    required init(converter : MarkDownConverter<NSMutableAttributedString>) {
        self.converter = converter
        super.init()
    }
    
    func attributedStringForMarkDownItem(_ markdownItem : MarkDownItem, styling : ItemStyling) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()
        
        if let markDownItems = markdownItem.markDownItems {
            for subString in converter.convertToElements(markDownItems, applicableStyling: styling) {
                string.append(subString)
            }
        }
        
        return string
    }
    
    func attributedStringWithContentInset(_ attributedString:NSMutableAttributedString, contentInset: UIEdgeInsets) -> NSMutableAttributedString {
        // Get existing paragraph style to append style to or create new style
        let paragraphStyle = getParagraphStyleAttribute(of: attributedString, exactlyAt: attributedString.fullRange()) ?? NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = contentInset.bottom
        paragraphStyle.paragraphSpacingBefore = contentInset.top
        paragraphStyle.firstLineHeadIndent = contentInset.left
        paragraphStyle.headIndent = contentInset.left

        attributedString.addAttributes([
            .paragraphStyle : paragraphStyle
        ], range: attributedString.fullRange())

        return attributedString
    }

    private func getParagraphStyleAttribute(of attributedString: NSAttributedString, exactlyAt range: NSRange) ->  NSMutableParagraphStyle? {
        var paragraphStyles: [NSMutableParagraphStyle] = []

        attributedString.enumerateAttribute(.paragraphStyle, in: attributedString.fullRange(), options: []) {
            value, rangeOfValue, stop in
            if let paragraphStyle = value as? NSMutableParagraphStyle, rangeOfValue == range {
                paragraphStyles.append(paragraphStyle)
            }
        }

        return paragraphStyles.first
    }
}
