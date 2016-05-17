//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class AttributedStringViewLayoutBlockBuilder: LayoutBlockBuilder<UIView> {

    private let converter : MarkDownConverter<NSMutableAttributedString>

    required init(converter : MarkDownConverter<NSMutableAttributedString>) {
        self.converter = converter
        super.init()
    }

    func attributedStringForMarkDownItem(markdownItem : MarkDownItem, styling : ItemStyling) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()

        if let markDownItems = markdownItem.markDownItems {
            for subString in converter.convertToElements(markDownItems, applicableStyling: styling) {
                string.appendAttributedString(subString)
            }
        }

        return string
    }
}
