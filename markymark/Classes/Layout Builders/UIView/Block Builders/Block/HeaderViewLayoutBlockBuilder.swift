//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class HeaderViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return HeaderMarkDownItem.self
    }

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<UIView>,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> UIView {
        let headerMarkDownItem = markDownItem as! HeaderMarkDownItem
        let headerStyling = styling as? HeadingStyling
        headerStyling?.configureForLevel(headerMarkDownItem.level)

        let label = AttributedInteractiveLabel()

        label.markDownAttributedString = attributedStringForMarkDownItem(
            markDownItem,
            styling: headerStyling ?? styling,
            renderContext: renderContext
        )

        label.accessibilityTraits.insert(.header)
        label.adjustsFontForContentSizeCategory = renderContext.hasScalableFonts

        if let urlOpener = renderContext.urlOpener {
            label.urlOpener = urlOpener
        }

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: label, spacing: spacing)
    }
}
