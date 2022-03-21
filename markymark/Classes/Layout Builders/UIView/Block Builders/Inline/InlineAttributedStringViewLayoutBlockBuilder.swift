//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class InlineAttributedStringViewLayoutBlockBuilder: LayoutBlockBuilder<UIView>, CanSetURLOpener {

    private(set) var urlOpener: URLOpener?

    private let converter: MarkDownConverter<NSMutableAttributedString>

    required public init(converter: MarkDownConverter<NSMutableAttributedString>) {
        self.converter = converter
        super.init()
    }

    open func attributedStringForMarkDownItem(_ markdownItem: MarkDownItem, styling: ItemStyling) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()

        if let markDownItems = markdownItem.markDownItems {
            for subString in converter.convertToElements(markDownItems, applicableStyling: styling) {
                string.append(subString)
            }
        }

        return string
    }

    open func set(urlOpener: URLOpener?) {
        self.urlOpener = urlOpener
    }
}

