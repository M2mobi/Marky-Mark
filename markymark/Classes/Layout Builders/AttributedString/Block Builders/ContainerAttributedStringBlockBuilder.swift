//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class ContainerAttributedStringBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString> {

    // MARK: LayoutBlockBuilder

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<NSMutableAttributedString>,
        styling: ItemStyling?,
        renderContext: RenderContext
    ) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()

        if let markDownItems = markDownItem.markDownItems {

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
