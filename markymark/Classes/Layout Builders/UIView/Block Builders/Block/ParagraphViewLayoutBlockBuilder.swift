//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class ParagraphViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ParagraphMarkDownItem.self
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
        let minimumHeight: CGFloat? = (styling as? MinimumHeightStylingRule)?.minimumHeight
        return ContainerView(view: label, spacing: spacing, minimumHeight: minimumHeight)
    }
}
