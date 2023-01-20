//
//  Created by Jim van Zummeren on 11/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class QuoteBlockLayoutBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return QuoteMarkDownItem.self
    }

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<UIView>,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> UIView {
        let label = AttributedInteractiveLabel()
        label.markDownAttributedString = attributedStringForMarkDownItem(
            markDownItem,
            styling: styling,
            renderContext: renderContext
        )

        label.adjustsFontForContentSizeCategory = renderContext.hasScalableFonts

        if let urlOpener = renderContext.urlOpener {
            label.urlOpener = urlOpener
        }

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: label, spacing: spacing)
    }
}
