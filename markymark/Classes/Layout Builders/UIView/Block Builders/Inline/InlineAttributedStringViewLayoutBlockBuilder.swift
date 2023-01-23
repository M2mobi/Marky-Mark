//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class InlineAttributedStringViewLayoutBlockBuilder: LayoutBlockBuilder<UIView> {

    private(set) var renderContext: RenderContext?

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
}

extension InlineAttributedStringViewLayoutBlockBuilder: HasRenderContext {

    func set(renderContext: RenderContext) {
        self.renderContext = renderContext
    }
}

